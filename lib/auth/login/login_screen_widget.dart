import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/auth/auth_cubit.dart';
import 'package:untitled1/auth/form_submission_status.dart';
import 'package:untitled1/auth/auth_repository.dart';
import 'package:untitled1/auth/login/login_bloc.dart';
import 'package:untitled1/models/user.dart';
import 'package:untitled1/validators/validations.dart';
import 'package:untitled1/auth_widgets/login_eMail_field.dart';
import 'package:untitled1/auth_widgets/login_password_field.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, this.authRepo}) : super(key: key);
  final AuthRepository? authRepo;

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> with Validations {
  static const iconColor = Color.fromRGBO(47, 183, 254, 0.9);
  var formKey = GlobalKey<FormState>();
  User? user;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
        resizeToAvoidBottomInset: false,
        appBar: _appBar() ,
        body: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
              authRepository: context.read<AuthRepository>(),
              authCubit: context.read<AuthCubit>()),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  alignment: Alignment.center,
                  width: width / 2.5,
                  height: height / 15,
                  child: Text(
                    "GİRİŞ YAP",
                    style: GoogleFonts.asap(
                        color: const Color.fromRGBO(126, 124, 255, 0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  final formStatus = state.formStatus;
                  printException(
                      formStatus: formStatus,
                      context: context); //if there is an exception, print it.
                },
                child: formField(), //form
              ),
              BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("oturumumu açık tut",
                        style: TextStyle(color: Colors.black54)),
                    Switch.adaptive(
                        value: state.autoLogin!,
                        onChanged: (value) {
                          value == true
                              ? context
                                  .read<LoginBloc>()
                                  .add(AutoLoginActivated())
                              : context
                                  .read<LoginBloc>()
                                  .add(AutoLoginDeactivated());
                        })
                  ],
                );
              }),
              SizedBox(
                height: height / 40,
              ),
              Center(
                child: buildSubmitButton(),
              ),
              Expanded(
                child: buildBottomPart(context, width),
              ),
            ]),
          ),
        ));
  }

  Widget formField() {
    return Form(
      key: formKey,
      child: Column(
        children: const [
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: LoginEmailField(),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: LoginPasswordField(),
          ),
        ],
      ),
    );
  }

  Widget buildBottomPart(BuildContext context, double width) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "Hesabın yok mu?",
            style: TextStyle(color: Colors.black45),
          ),
          TextButton(
            onPressed: () => context.read<AuthCubit>().showSignUp(),
            child: const Text(
              "kaydol",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
          ),
          SizedBox(
            width: width / 7,
          ),
          TextButton(
            onPressed: () => context.read<AuthCubit>().showPasswordForgot(),
            child: const Text(
              "şifremi unuttum",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
          ),
        ]),
      ],
    );
  }

  Widget buildSubmitButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitted
          ? const CircularProgressIndicator()
          : TextButton(
              onPressed: () {
                _onPressed(context);
              },
              child: const Text(
                "Giriş yap",
                style: TextStyle(color: Colors.black45),
              ),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.only(left: 30, right: 30)),
                  backgroundColor: MaterialStateProperty.all(Colors.white70),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide.none,
                  ))),
            );
    });
  }

  void _onPressed(BuildContext context) {
    if (formKey.currentState!.validate() == true) {
      context.read<LoginBloc>().add(LoginSubmitted());
    }
  }

  void printException(
      {FormSubmissionStatus? formStatus, BuildContext? context}) {
    String? message = loginExceptionPicker(formStatus: formStatus);
    if (message != null) {
      showMessage(
          message: message, context: context); //exceptionPicker in validations
    }
  }

  void showMessage({String? message, BuildContext? context}) {
    final snackBar = SnackBar(
      content: Text(
        message!,
        style: const TextStyle(fontSize: 15, color: Colors.white),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red[400],
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 40, left: 5, right: 5),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide.none,
      ),
    );
    ScaffoldMessenger.of(context!).showSnackBar(snackBar);
  }

  PreferredSize _appBar(){
    return PreferredSize(
        child: AppBar(
            backgroundColor: const Color.fromRGBO(255, 123, 78, 0.9),
            centerTitle: true,
            title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Meet",
                style: GoogleFonts.gentiumBasic(
                    textStyle:
                    const TextStyle(color: Colors.white, fontSize: 32)),
              ),
              Text("Up",
                  style: GoogleFonts.gentiumBasic(
                      textStyle: const TextStyle(
                          color: Color.fromRGBO(255, 222, 118, 1),
                          fontSize: 32))),
            ])),
        preferredSize: AppBar().preferredSize);
  }
}
