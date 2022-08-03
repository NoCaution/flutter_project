import 'package:flutter_bloc/flutter_bloc.dart';

enum HomeNavigatorState {home,archive,messages,messageDetails}

class HomeNavigatorCubit extends Cubit<HomeNavigatorState>{
  static final HomeNavigatorCubit _signleton = HomeNavigatorCubit._internal();

  factory HomeNavigatorCubit(){
    return _signleton;
  }

  HomeNavigatorCubit._internal() : super(HomeNavigatorState.home);

  void showHome()=> emit(HomeNavigatorState.home);
  void showArchive()=>emit(HomeNavigatorState.archive);
  void showMessages()=>emit(HomeNavigatorState.messages);
  void showMessaging()=> emit(HomeNavigatorState.messageDetails);

}