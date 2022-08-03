import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/archive/archive_screen.dart';
import 'package:untitled1/home/home_navigator_cubit.dart';
import 'package:untitled1/home/main_screen.dart';
import 'package:untitled1/messaging/messages/messages_screen.dart';
import '../auth/auth_repository.dart';
import '../messaging/message_details.dart';
import '../session_cubit.dart';

class HomeNavigator extends StatelessWidget {
  const HomeNavigator({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>HomeNavigatorCubit(),
      child: BlocBuilder<HomeNavigatorCubit, HomeNavigatorState>(
        builder: (context, state) {
          return Navigator(
            pages: [
              MaterialPage(child: MainScreen(sessionCubit: SessionCubit(),authRepo: AuthRepository())),
              if (state == HomeNavigatorState.archive)
                const MaterialPage(child: ArchiveScreen()),
              if(state == HomeNavigatorState.messages)
                const MaterialPage(child: MessagesScreen()),
              if(state == HomeNavigatorState.messageDetails)
                const MaterialPage(child: MessageDetailsScreen()),
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
}
