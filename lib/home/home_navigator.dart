import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/add_post/add_post_screen.dart';
import 'package:untitled1/auth/auth_repository.dart';
import 'package:untitled1/home/home_navigator_cubit.dart';
import 'package:untitled1/home/main_screen.dart';
import 'package:untitled1/messaging/messages/messages_screen.dart';
import 'package:untitled1/repositories/user_credential_repository.dart';
import 'package:untitled1/session_cubit.dart';
import '../messaging/message_details.dart';

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
              MaterialPage(child: MainScreen(userCredential: context.read<UserCredentialRepository>(),sessionCubit: context.read<SessionCubit>(),authRepo: context.read<AuthRepository>(),)),
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
