import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/settings/screens/account_screen.dart';
import 'package:untitled1/settings/settings_navigator_cubit.dart';
import 'package:untitled1/settings/settings_screen.dart';

class SettingsNavigator extends StatelessWidget {
  const SettingsNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsNavigatorCubit(),
      child: BlocBuilder<SettingsNavigatorCubit, SettingsNavigatorState>(
          builder: (context, state) {
        return Navigator(
          pages: [
            const MaterialPage(child: SettingsScreen()),
            if(state==SettingsNavigatorState.account)
              const MaterialPage(child: AccountScreen())
          ],
          onPopPage: (route, result) {
            context.read<SettingsNavigatorCubit>().showSettings();
            return route.didPop(result);
          },
        );
      }),
    );
  }
}
