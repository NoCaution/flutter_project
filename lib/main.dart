import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/auth/auth_cubit.dart';
import 'package:untitled1/auth/auth_repository.dart';
import 'package:untitled1/repositories/data_repository.dart';
import 'package:untitled1/session_cubit.dart';
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
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context)=> AuthRepository(dataRepo: DataRepository()),),
          RepositoryProvider(create: (context)=> DataRepository()),
          ],
        child: BlocProvider(
            create: (context)=>SessionCubit(authRepo: context.read<AuthRepository>()),
            child: AppNavigator(authCubit: AuthCubit(),),
        )
      )
    );
  }
}
