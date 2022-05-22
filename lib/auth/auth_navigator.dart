import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/auth/auth_cubit.dart';
import 'package:untitled1/auth/signup/signup_screen_widget.dart';
import 'package:untitled1/auth/verify_email/email_verifying_screen.dart';
import 'login/login_screen_widget.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator(
          pages: [
            if(state == AuthState.login)
              const MaterialPage(child: LoginScreen()),
            if(state == AuthState.signUp || state == AuthState.verifyEmail)...[
              const MaterialPage(child: SignupScreenWidget()),
              if(state == AuthState.verifyEmail)
                MaterialPage(child: EmailVerifyingScreen(authCubit: context.read<AuthCubit>(),)),
            ]
          ],
          onPopPage: (route, result) => route.didPop(result));
    });
  }
}
