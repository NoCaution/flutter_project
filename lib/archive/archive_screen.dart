import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/repositories/data_repository.dart';
import 'package:untitled1/session_cubit.dart';
import 'package:untitled1/utils/constants.dart' as constants;
import 'package:untitled1/widgets/post_card_widget.dart';
import '../models/post.dart';
import '../models/user.dart';
import 'archive_bloc.dart';
import 'archive_event.dart';
import 'archive_state.dart';

class ArchiveScreen extends StatefulWidget {
  final ArchiveBloc archiveBloc;
  final DataRepository dataRepo;

  const ArchiveScreen(
      {Key? key, required this.archiveBloc, required this.dataRepo})
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
    SessionCubit sessionCubit = context.read<SessionCubit>();
    User? currentUser = sessionCubit.getCurrentUser;
    double width = MediaQuery.of(context).size.width / 100;
    double height = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      appBar: _appBar(width: width),
      backgroundColor: constants.backGroundColor,
      body: BlocBuilder<ArchiveBloc, ArchiveState>(
          builder: (context, state) {
            var userInfo ="${currentUser!.name} ${currentUser.lastName} ${currentUser.imageUrl}";
            return state.archivedPosts == null
                ? Text(
                    "Henüz hiçbir etkinlik kaydetmediniz.",
                    style: GoogleFonts.gentiumBookBasic(
                        textStyle: TextStyle(
                            color: state.primaryTextColor?.withOpacity(0.75),
                            fontSize: width * 8,
                            fontWeight: FontWeight.bold)),
                  )
                : _postCardWidget(
                    width: width,
                    archivedPosts: state.archivedPosts,
                    userInfoForPost: userInfo);
          },
        ),
    );
  }

  //COMPONENTS

  Widget _postCardWidget(
      {required double width,
      List<Post?>? archivedPosts,
      required String userInfoForPost}) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ListView.builder(
          itemCount: archivedPosts!.length,
          itemBuilder: (context, int position) {
            var text = widget.dataRepo
                .parseDateTime(date: archivedPosts[position]!.createdAt!);
            if (position > 0) {
              return archivedPosts[position - 1]?.createdAt == text
                  ? _postCardWithoutDate(
                      position: position, userInfoForPost: userInfoForPost)
                  : _postCardWithDate(
                      text: text,
                      width: width,
                      position: position,
                      userInfoForPost: userInfoForPost,
                      archivedPosts: archivedPosts,
                    );
            } else {
              return _postCardWithDate(
                text: text,
                width: width,
                position: position,
                userInfoForPost: userInfoForPost,
                archivedPosts: archivedPosts,
              );
            }
          }),
    );
  }

  Widget _postCardWithDate({
    required String text,
    required double width,
    required int position,
    required String userInfoForPost,
    required List<Post?> archivedPosts,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildDatePart(message: text, width: width),
        PostCardWidget(
          post: archivedPosts[position]!,
          userInfoForPost: userInfoForPost,
          dataRepo: context.read<DataRepository>(),
          archived: true,
        ),
      ],
    );
  }

  Widget _postCardWithoutDate(
      {required int position,
      List<Post?>? archivedPosts,
      required String userInfoForPost}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: PostCardWidget(
        post: archivedPosts![position]!,
        userInfoForPost: userInfoForPost,
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
            style: GoogleFonts.gentiumBookBasic(
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
      preferredSize: AppBar().preferredSize,
      child: AppBar(
        backgroundColor: constants.appBarColor.withOpacity(0.9),
        centerTitle: true,
        title: Text(
          "Etkinlik Arşivi",
          style: GoogleFonts.gentiumBookBasic(
              textStyle: TextStyle(
            color: Colors.white,
            fontSize: width * 6,
          )),
        ),
      ),
    );
  }
}
