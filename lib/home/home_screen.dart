import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/auth/auth_repository.dart';
import 'package:untitled1/repositories/data_repository.dart';
import 'package:untitled1/home/home_navigator_cubit.dart';
import 'package:untitled1/home/home_bloc.dart';
import 'package:untitled1/home/home_events.dart';
import 'package:untitled1/repositories/user_repository.dart';
import 'package:untitled1/session_cubit.dart';
import 'package:untitled1/utils/constants.dart' as constants;
import 'package:untitled1/widgets/post_card_widget.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../utils/custom_icons.dart';
import 'home_state.dart';

class HomeScreen extends StatefulWidget {
  final AuthRepository? authRepo;
  final HomeBloc homeBloc;
  final SessionCubit sessionCubit;

  const HomeScreen({
    Key? key,
    this.authRepo,
    required this.sessionCubit,
    required this.homeBloc,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  @override
  initState() {
    super.initState();
    _getCurrentUserAndPosts();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 100;
    double height = MediaQuery.of(context).size.height / 100;
    SessionCubit sessionCubit = widget.sessionCubit;
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      var posts = state.posts;
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: constants.backGroundColor,
        appBar: _appBar(context, height),
        body: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: state.userInfoForPosts == null || posts == null
                  ? const Center(heightFactor: 5,child: CircularProgressIndicator(),)
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        var currentPost = posts[index];
                        var userInfoForPost =
                            state.userInfoForPosts?[currentPost.userId];
                        return postCardWidget(
                            post: currentPost, userInfoForPost: userInfoForPost!);
                      })),
        ),
      );
    });
  }

//COMPONENTS
  Widget postCardWidget(
      {required String userInfoForPost, required Post post}) {
    return PostCardWidget(
      userInfoForPost: userInfoForPost,
      post: post,
      dataRepo: context.read<DataRepository>(),
      onHome: true,
    );
  }

  PreferredSize _appBar(BuildContext context, double fontSize) {
    return PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: AppBar(
          backgroundColor: constants.appBarColor.withOpacity(0.9),
          centerTitle: true,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Meet",
                    style: GoogleFonts.gentiumBookBasic(
                        textStyle: TextStyle(
                            color: Colors.white, fontSize: fontSize * 3.3)),
                  ),
                  Text("Up",
                      style: GoogleFonts.gentiumBookBasic(
                          textStyle: TextStyle(
                              color: constants.appNameColor,
                              fontSize: fontSize * 3.3)))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<HomeNavigatorCubit>(context).showMessages();
                  },
                  icon: const Icon(CustomIcons.commentEmpty),
                  splashRadius: 20.0,
                ),
              ],
            )
          ]),
        ));
  }

  _getCurrentUserAndPosts() {
    widget.homeBloc.add(Refresh());
    widget.homeBloc.add(GetCurrentUserPost());
  }
}
