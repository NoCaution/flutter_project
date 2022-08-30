import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/auth/form_submission_status.dart';
import 'package:untitled1/auth/auth_repository.dart';
import '../../models/user.dart';
import '../../repositories/data_repository.dart';
import '../../repositories/user_repository.dart';
import '../auth_cubit.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthCubit authCubit;
  final DataRepository dataRepo;

  LoginBloc( {required this.authRepository, required this.authCubit,required this.dataRepo})
      : super(LoginState()) {
    {
      on<LoginEmailChanged>((event, emit) {
        emit(state.copyWith(eMail: event.eMail));
      });
      on<LoginPasswordChanged>((event, emit) {
        emit(state.copyWith(password: event.password));
      });
      on<RestartFormStatus>((event, emit) {
        emit(state.copyWith(formStatus: FormSubmitting()));
      });
      on<AutoLoginActivated>((event, emit) async {
        emit(state.copyWith(autoLogin: true));
      });
      on<AutoLoginDeactivated>((event, emit) async {
        emit(state.copyWith(autoLogin: false));
      });
      on<LoginSubmitted>((event, emit) async {
        emit(state.copyWith(formStatus: FormSubmitted()));
        try {
          User? user = await UserRepository().getUserByEmail(state.eMail);
          await authRepository.login(
            eMail: state.eMail!.trim(),
            password: state.password!.trim(),
          );
          emit(state.copyWith(formStatus: SubmissionSuccess()));
          if(state.autoLogin == true){
            User? newUser = dataRepo.changeUserProperty(user: user!,property: "autoLogin",value: "true")!;
            await UserRepository().updateUser(newUser);
          }
          authCubit.showMainScreen();
        } catch (e) {
          emit(state.copyWith(formStatus: SubmissionFailed(exception: e)));
        }
      });
    }
  }
}
