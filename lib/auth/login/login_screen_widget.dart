import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled1/auth/auth_cubit.dart';
import 'package:untitled1/auth/form_submission_status.dart';
import 'package:untitled1/auth/login/auth_repository.dart';
import 'package:untitled1/auth/login/login_bloc.dart';
import 'package:untitled1/models/user.dart';
import 'package:untitled1/widgets/login_eMail_field.dart';
import 'package:untitled1/widgets/login_password_field.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  static const iconColor = Color.fromRGBO(47, 183, 254, 0.9);
  TextEditingController eMailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  User? user;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: const Color.fromRGBO(255, 123, 78, 0.9),
            centerTitle: true,
            title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Meet",
                style: GoogleFonts.kanit(
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 32)),
              ),
              Text("Up",
                  style: GoogleFonts.kanit(
                      textStyle: const TextStyle(
                          color: Color.fromRGBO(255, 222, 118, 1),
                          fontSize: 32))),
            ])),
        body: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
              authRepository: context.read<AuthRepository>(),
              authCubit: context.read<AuthCubit>()),
          child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(240, 240, 240, 1),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                fontSize: 20),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BlocListener<LoginBloc, LoginState>(
                        listener: (context, state) {
                          final formStatus = state.formStatus;
                          exceptionManagement(formStatus);
                        },
                        child: formField(), //form
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: SizedBox(
                          height: 37,
                          width: 100,
                          child: buildSubmitButton(),
                        ),
                      ),
                      Expanded(
                        child: buildBottomPart(context, width),
                      ),
                    ]),
              )),
        ));
  }

  Widget formField() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: LoginEmailField(
              textEditingController: eMailController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: LoginPasswordField(
              textEditingController: passwordController,
            ),
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
                onPressed(context);
              },
              child: const Text(
                "Giriş yap",
                style: TextStyle(color: Colors.black45),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white70),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide.none,
                  ))),
            );
    });
  }

  void onPressed(BuildContext context) {
    if (formKey.currentState!.validate() == true) {
      context.read<LoginBloc>().add(LoginSubmitted());
    }
  }

  void exceptionManagement(FormSubmissionStatus formStatus) {
    if (formStatus is SubmissionFailed) {
      if (formStatus.exception.toString() =="[firebase_auth/wrong-password] The password is invalid or the user does not have a password.") {
        showToast("kullanıcı adı ya da şifre hatalı!", Colors.red);
      } else if (formStatus.exception.toString() == "null") {
        showToast(formStatus.error!, Colors.red);
      }
    }
  }

  void showToast(String message, Color backGroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backGroundColor,
      textColor: Colors.white,
      fontSize: 8.0,
    );
  }
}
