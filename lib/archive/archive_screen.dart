import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/archive/archive_screen_bloc.dart';
import 'package:untitled1/archive/archive_screen_event.dart';
import 'package:untitled1/repositories/data_repository.dart';
import 'package:untitled1/repositories/user_credential_repository.dart';
import 'package:untitled1/utils/constants.dart' as constants;
import 'package:untitled1/widgets/post_card_widget.dart';
import '../models/post.dart';
import 'archive_screen_state.dart' as s;

class ArchiveScreen extends StatefulWidget {
  final ArchiveScreenBloc archiveBloc;
  final UserCredentialRepository userCredential;
  final DataRepository dataRepo;

  const ArchiveScreen(
      {Key? key,
      required this.archiveBloc,
      required this.userCredential,
      required this.dataRepo})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ArchiveScreenState();
  }
}

class ArchiveScreenState extends State<ArchiveScreen> {
  @override
  void initState() {
    super.initState();
    widget.archiveBloc.add(GetArchivedPosts());
  }

  @override
  Widget build(BuildContext context) {
    List<Post>? archivedPosts = widget.userCredential.archivedPosts;
    double width = MediaQuery.of(context).size.width / 100;
    double height = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      appBar: _appBar(width: width),
      backgroundColor: constants.backGroundColor,
      body: BlocProvider(
        create: (BuildContext context) => ArchiveScreenBloc(
            userCredential: context.read<UserCredentialRepository>()),
        child: BlocBuilder<ArchiveScreenBloc, s.ArchiveScreenState>(
          builder: (context, state) {
            return archivedPosts == null
                ? Text(
                    "Henüz hiçbir etkinlik kaydetmediniz.",
                    style: GoogleFonts.gentiumBasic(
                        textStyle: TextStyle(
                            color: state.primaryTextColor?.withOpacity(0.75),
                            fontSize: width * 8,
                            fontWeight: FontWeight.bold)),
                  )
                : _postCardWidget(width: width, archivedPosts: archivedPosts);
          },
        ),
      ),
    );
  }

  //COMPONENTS

  Widget _postCardWidget({required double width, List<Post>? archivedPosts}) {
    var ref = widget.userCredential;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ListView.builder(
          itemCount: archivedPosts!.length,
          itemBuilder: (context, int position) {
            var text = widget.dataRepo
                .parseDateTime(date: archivedPosts[position].createdAt!);
            if (position > 0) {
              return archivedPosts[position - 1].createdAt == text
                  ? _postCardWithoutDate(ref: ref, position: position)
                  : _postCardWithDate(
                      text: text,
                      width: width,
                      position: position,
                      ref: ref,
                    );
            } else {
              return _postCardWithDate(
                text: text,
                width: width,
                position: position,
                ref: ref,
              );
            }
          }),
    );
  }

  Widget _postCardWithDate({
    required String text,
    required double width,
    required int position,
    required UserCredentialRepository ref,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildDatePart(message: text, width: width),
        PostCardWidget(
          post: ref.archivedPosts![position],
          user: ref.user,
          dataRepo: context.read<DataRepository>(),
          archived: true,
        ),
      ],
    );
  }

  Widget _postCardWithoutDate(
      {required int position, required UserCredentialRepository ref}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PostCardWidget(
        post: ref.archivedPosts![position],
        user: ref.user,
        dataRepo: context.read<DataRepository>(),
        archived: true,
      ),
    );
  }

  Widget _buildDatePart({required String message, required double width}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            message,
            style: GoogleFonts.gentiumBasic(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: width * 6,
                    color: constants.primaryTextColor.withOpacity(0.75))),
          ),
        ),
      ],
    );
  }

  PreferredSize _appBar({required double width}) {
    return PreferredSize(
      child: AppBar(
        backgroundColor: constants.appBarColor.withOpacity(0.9),
        centerTitle: true,
        title: Text(
          "Etkinlik Arşivi",
          style: GoogleFonts.gentiumBasic(
              textStyle: TextStyle(
            color: Colors.white,
            fontSize: width * 6,
          )),
        ),
      ),
      preferredSize: AppBar().preferredSize,
    );
  }
}
