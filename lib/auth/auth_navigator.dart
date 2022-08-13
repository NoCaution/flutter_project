import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/auth/auth_cubit.dart';
import 'package:untitled1/auth/auth_repository.dart';
import 'package:untitled1/auth/signup/signup_screen.dart';
import 'package:untitled1/auth/verify_email/email_verifying_screen.dart';
import '../repositories/data_repository.dart';
import 'login/login_screen.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator(
          pages: [
            if(state == AuthState.login)
              MaterialPage(child: LoginScreen(dataRepo: context.read<DataRepository>(), authRepo: AuthRepository(dataRepo: DataRepository()),)),
            if(state == AuthState.signUp || state == AuthState.verifyEmail)...[
              MaterialPage(child: SignupScreenWidget(dataRepo: DataRepository(), authRepo: context.read<AuthRepository>(),)),
              if(state == AuthState.verifyEmail)
                MaterialPage(child: EmailVerifyingScreen(authCubit: context.read<AuthCubit>(), authRepo: context.read<AuthRepository>(), dataRepo: context.read<DataRepository>(),)),
            ]
          ],
          onPopPage: (route, result) => route.didPop(result));
    });
  }
}
