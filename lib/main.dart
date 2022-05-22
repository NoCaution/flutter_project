import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/auth/auth_cubit.dart';
import 'package:untitled1/auth/login/auth_repository.dart';
import 'package:untitled1/main_screen_cubit.dart';

import 'app_navigator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( const MeetUp());
}

class MeetUp extends StatelessWidget {
  const MeetUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context)=> AuthRepository(),
        child: BlocProvider(
            create: (context)=>MainScreenCubit(authRepo: context.read<AuthRepository>(),),
            child: AppNavigator(authCubit: AuthCubit(),),
        )
      )
    );
  }
}
