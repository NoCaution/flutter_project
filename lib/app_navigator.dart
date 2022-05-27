import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/auth/auth_navigator.dart';
import 'package:untitled1/auth/login/auth_repository.dart';
import 'package:untitled1/loading_screen.dart';
import 'package:untitled1/main_screen_cubit.dart';
import 'package:untitled1/main_screen_state.dart';
import 'package:untitled1/screens/main_screen.dart' as main_screen;

import 'auth/auth_cubit.dart';

class AppNavigator extends StatelessWidget {
  final AuthCubit? authCubit;
  const AppNavigator({Key? key,this.authCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenCubit, MainScreenState>(
        builder: (context, state) {
      return  Navigator(
        pages: [
          if(state is UnknownMainScreenState)
            const MaterialPage(child:LoadingScreen()),
          if(state is UnAuthenticated)
            MaterialPage(child: BlocProvider<AuthCubit>(create: (context)=>AuthCubit(mainScreenCubit: context.read<MainScreenCubit>()),
            child: const AuthNavigator(),)),
          if(state is Authenticated)
            MaterialPage(child: main_screen.MainScreen(mainScreenCubit: context.read<MainScreenCubit>(),authRepo: context.read<AuthRepository>(),)),
        ],
        onPopPage: (route,result)=> route.didPop(result),
      );
    });
  }
}
