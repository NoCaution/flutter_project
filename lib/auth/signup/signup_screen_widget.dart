import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/auth/form_submission_status.dart';
import 'package:untitled1/auth/login/auth_repository.dart';
import 'package:untitled1/auth/signup/signup_bloc.dart';
import 'package:untitled1/auth/signup/signup_event.dart';
import 'package:untitled1/auth/signup/signup_state.dart';
import 'package:untitled1/validators/validations.dart';
import 'package:untitled1/widgets/lastName_field.dart';
import 'package:untitled1/widgets/name_field.dart';
import '../../widgets/signup_eMail_field.dart';
import '../../widgets/signup_password_field.dart';
import '../auth_cubit.dart';

class SignupScreenWidget extends StatefulWidget {
  const SignupScreenWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SignupScreenWidgetState();
  }
}

class SignupScreenWidgetState extends State<SignupScreenWidget>
    with Validations {
  var key = GlobalKey<FormState>();
  AuthRepository? authRepo;
  AuthCubit? authCubit;

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
      body: BlocProvider(
        create: (context) => SignupBloc(
            authRepo: context.read<AuthRepository>(),
            authCubit: context.read<AuthCubit>()),
        child: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(240, 240, 240, 1),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Container(
                    height: height / 1.57,
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 25, bottom: 0),
                    child: buildFormField(height)),//signup button inside--

                buildBottomPart(context),
              ],
            )),
      ),
    );
  }

  //COMPONENTS//

  Widget buildBottomPart(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "Hesabın var mı?",
              style: TextStyle(color: Colors.black45),
            ),
            TextButton(
              onPressed: () => context.read<AuthCubit>().showLogin(),
              child: const Text(
                "giriş yap",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            ),
          ])
        ],
      ),
    );
  }

  Widget buildFormField(double height) {
    return BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          // exceptions management//
          printException(
              formStatus: formStatus,
              context: context); //if there is an exception, print it.
        },
        child: Form(
          key: key,
          child: Column(
            children: [
              Padding(
                child: Center(
                    child: Text(
                  "KAYDOL",
                  style: GoogleFonts.asap(
                      color: const Color.fromRGBO(126, 124, 255, 0.7),
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                )),
                padding: const EdgeInsets.only(top: 0, bottom: 10),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: NameField(),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                child: LastNameField(),
              ),
              const Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: SignUpEmailField()),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                child: SignUpPasswordField(),
              ),
              SizedBox(
                height: height / 28,
              ),
              //signup button here//
              BlocBuilder<SignupBloc, SignupState>(
                builder: (context, state) {
                  return state.formStatus is FormSubmitted
                      ? const CircularProgressIndicator()
                      : buildSignUpButton(context, state);
                },
              ),
            ],
          ),
        ));
  }

  TextButton buildSignUpButton(BuildContext context, SignupState state) {
    return TextButton(
      onPressed: () {
        _onPressed(context, state);
      },
      child: const Text(
        "Kaydol",
        style: TextStyle(color: Colors.black54),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white70),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.only(left: 40, right: 40)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide.none,
          ))),
    );
  }

  void _onPressed(BuildContext context, SignupState state) async {
    if (key.currentState!.validate() == true) {
      context.read<SignupBloc>().add(SignupSubmitted());
    }
  }

  void printException(
      {FormSubmissionStatus? formStatus, BuildContext? context}) {
    String? message = signupExceptionPicker(formStatus: formStatus);
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
}
