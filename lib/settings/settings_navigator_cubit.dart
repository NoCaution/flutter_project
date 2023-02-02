import 'package:flutter_bloc/flutter_bloc.dart';

enum SettingsNavigatorState{settings,account,privacy}

class SettingsNavigatorCubit extends Cubit<SettingsNavigatorState>{
  SettingsNavigatorCubit() : super(SettingsNavigatorState.settings);

  showSettings()=> emit(SettingsNavigatorState.settings);
  showAccount() => emit(SettingsNavigatorState.account);
  showPrivacy() => emit(SettingsNavigatorState.privacy);
}