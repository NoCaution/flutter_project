import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/archive/archive_bloc.dart';
import 'package:untitled1/auth/auth_cubit.dart';
import 'package:untitled1/auth/auth_repository.dart';
import 'package:untitled1/home/home_bloc.dart';
import 'package:untitled1/repositories/data_repository.dart';
import 'package:untitled1/session_cubit.dart';
import 'app_navigator.dart';
import 'home/home_navigator_cubit.dart';
import 'my_post/my_post_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MeetUp());
}

class MeetUp extends StatelessWidget {
  const MeetUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MultiRepositoryProvider(
            providers: [
              RepositoryProvider(
                create: (context) => AuthRepository(dataRepo: DataRepository()),
              ),
              RepositoryProvider(create: (context) => DataRepository()),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                    create: (context) => SessionCubit(
                        authRepo: context.read<AuthRepository>())),
                BlocProvider(
                    create: (context)=> ArchiveBloc(
                        currentUser: context.read<SessionCubit>().getCurrentUser)),
                BlocProvider(
                  create: (context) => MyPostBloc(),
                ),
                BlocProvider(create: (context) => HomeNavigatorCubit()),
              ],
              child: AppNavigator(
                authCubit: AuthCubit(),
                sessionCubit: SessionCubit(),
              ),
            )));
  }
}
