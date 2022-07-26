import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import 'package:untitled1/home/main_screen_bloc.dart';
import 'package:untitled1/my_post/my_post_screen.dart';

import '../auth/auth_repository.dart';
import '../home/main_screen.dart';
import '../session_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BottomNavigationBarCubit(),
        child: BlocBuilder<BottomNavigationBarCubit, int>(
            builder: (context, state) {
          return Scaffold(
              body: IndexedStack(
                index: state,
                children:  [
                  MainScreen(sessionCubit: context.read<SessionCubit>(),authRepo: context.read<AuthRepository>(),),
                  const MyPostScreen(),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
                currentIndex: state,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                onTap: (index) =>
                    context.read<BottomNavigationBarCubit>().selectIndex(index),
                items: [
                  home(state),
                  myPost(state),
                ],
              ));
        }));
  }

  BottomNavigationBarItem home(int state){
    return BottomNavigationBarItem(
        icon: state ==0 ? const Icon(Icons.home) : const Icon(Icons.home_outlined),
        label: "home"
    );
  }

  BottomNavigationBarItem myPost(int state){
    return BottomNavigationBarItem(
        icon: state == 1 ? const Icon(Icons.add_circle) : const Icon(Icons.add_circle_outline),
        label: "myPost"
    );
  }
}
