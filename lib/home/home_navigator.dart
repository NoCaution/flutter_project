import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:untitled1/add_post/add_post_screen.dart';
import 'package:untitled1/auth/auth_repository.dart';
import 'package:untitled1/home/home_navigator_cubit.dart';
import 'package:untitled1/home/home_screen.dart';
import 'package:untitled1/home/home_state.dart';
import 'package:untitled1/messaging/messages/messages_screen.dart';
import 'package:untitled1/session_cubit.dart';
import '../messaging/message_details_screen.dart';
import 'home_bloc.dart';

class HomeNavigator extends StatelessWidget {
  final SessionCubit sessionCubit;
  const HomeNavigator({Key? key,required this.sessionCubit}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeNavigatorCubit>(
      create: (context)=>HomeNavigatorCubit(),
      child: BlocBuilder<HomeNavigatorCubit, HomeNavigatorState>(
        builder: (context, state) {
          return Navigator(
            pages: [
              MaterialPage(child: _homeScreen(authRepository: context.read<AuthRepository>())),
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

  Widget _homeScreen({required AuthRepository authRepository}){
    return BlocProvider<HomeBloc>(
      create: (context)=>HomeBloc(currentUser: sessionCubit.getCurrentUser,currentUserPost: sessionCubit.getCurrentPost),
      child: BlocBuilder<HomeBloc,HomeState>(
        builder: (context,state)=> HomeScreen(authRepo: authRepository, homeBloc: context.read<HomeBloc>(),sessionCubit: sessionCubit,),
      )
    );
  }
}
