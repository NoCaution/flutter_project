import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/add_post/add_post_screen.dart';
import 'package:untitled1/archive/archive_screen.dart';
import 'package:untitled1/home/home_navigator_cubit.dart';
import 'package:untitled1/home/main_screen.dart';
import 'package:untitled1/home/main_screen_bloc.dart';
import 'package:untitled1/messaging/messages/messages_screen.dart';
import 'package:untitled1/repositories/data_repository.dart';
import 'package:untitled1/repositories/user_credantial_repository.dart';
import '../auth/auth_repository.dart';
import '../messaging/message_details.dart';
import '../session_cubit.dart';

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>HomeNavigatorCubit(),
      child: BlocBuilder<HomeNavigatorCubit, HomeNavigatorState>(
        builder: (context, state) {
          return Navigator(
            pages: [
              MaterialPage(child: MainScreen(sessionCubit: context.read<SessionCubit>(),authRepo: AuthRepository(dataRepo: context.read<DataRepository>()), userCredential: context.read<UserCredentialRepository>(),)),
              if (state == HomeNavigatorState.archive)
                const MaterialPage(child: ArchiveScreen()),
              if(state == HomeNavigatorState.messages)
                const MaterialPage(child: MessagesScreen()),
              if(state == HomeNavigatorState.messageDetails)
                const MaterialPage(child: MessageDetailsScreen()),
              if(state==HomeNavigatorState.addPost)
                const MaterialPage(child: AddPostScreen()),
            ],
            onPopPage: (route,result) {
              state == HomeNavigatorState.messageDetails
                  ? context.read<HomeNavigatorCubit>().showMessages()
                  : context.read<HomeNavigatorCubit>().showHome();
              return route.didPop(result);
            },
          );
        },
      ),
    );
  }
}
