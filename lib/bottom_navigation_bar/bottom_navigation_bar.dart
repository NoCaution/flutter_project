import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import 'package:untitled1/home/home_navigator.dart';
import 'package:untitled1/home/home_navigator_cubit.dart';
import 'package:untitled1/my_post/my_post_screen.dart';
import 'package:untitled1/settings/settings_navigator.dart';
import 'package:untitled1/settings/settings_screen.dart';
import '../my_post/my_post_bloc.dart';


class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key,this.homeNavCubit,}) : super(key: key);
  final HomeNavigatorCubit? homeNavCubit;

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
                  const HomeNavigator(),
                  MyPostScreen(postBloc: context.read<MyPostBloc>(),bottomNavBarCubit: context.read<BottomNavigationBarCubit>()),
                  const SettingsNavigator(),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                selectedLabelStyle: GoogleFonts.gentiumBasic(),
                unselectedLabelStyle: GoogleFonts.gentiumBasic(),
                selectedItemColor: Colors.black,
                currentIndex: state,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                onTap: (index){
                  context.read<BottomNavigationBarCubit>().selectIndex(index);
                  if(state == 0){
                    homeNavCubit?.showHome();
                  }
                },
                items: [
                  home(state),
                  myPost(state),
                  settings(state),
                ],
              ));
        }));
  }

  BottomNavigationBarItem home(int state){
    return BottomNavigationBarItem(
        icon: state ==0 ? const Icon(Icons.home) : const Icon(Icons.home_outlined),
        label: "Ana Sayfa"
    );
  }

  BottomNavigationBarItem myPost(int state){
    return BottomNavigationBarItem(
        icon: state == 1 ? const Icon(Icons.add_circle) : const Icon(Icons.add_circle_outline),
        label: "Etkinliğim"
    );
  }
  BottomNavigationBarItem settings(int state){
    return const BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: "Ayarlar",
    );
  }
}
