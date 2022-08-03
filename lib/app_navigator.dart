import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/auth/auth_navigator.dart';
import 'package:untitled1/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:untitled1/home/home_navigator_cubit.dart';
import 'package:untitled1/loading_screen.dart';
import 'package:untitled1/session_cubit.dart';
import 'package:untitled1/session_state.dart';
import 'auth/auth_cubit.dart';

class AppNavigator extends StatelessWidget {
  final AuthCubit? authCubit;
  const AppNavigator({Key? key,this.authCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
        builder: (context, state) {
      return  Navigator(
        pages: [
          if(state is UnknownMainScreenState)
            const MaterialPage(child:LoadingScreen()),
          if(state is UnAuthenticated)
            MaterialPage(child: BlocProvider<AuthCubit>(create: (context)=>AuthCubit(sessionCubit: context.read<SessionCubit>()),
            child: const AuthNavigator(),)),
          if(state is Authenticated)
            MaterialPage(child: BottomNavBar(homeNavCubit: HomeNavigatorCubit(),)),
        ],
        onPopPage: (route,result)=> route.didPop(result),
      );
    });
  }
}
