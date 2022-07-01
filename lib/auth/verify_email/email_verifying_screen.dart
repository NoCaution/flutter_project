import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/auth/auth_cubit.dart';
import 'package:untitled1/auth/form_submission_status.dart';
import 'package:untitled1/auth/auth_repository.dart';
import 'package:untitled1/auth/verify_email/verif_email_event.dart'
    as verify_email_event;
import 'package:untitled1/auth/verify_email/verify_email_bloc.dart';
import 'package:untitled1/auth/verify_email/verify_email_state.dart';
import 'package:untitled1/validators/validations.dart';
import 'package:untitled1/auth_widgets/email_verification_field.dart';

class EmailVerifyingScreen extends StatefulWidget {
  final AuthCubit? authCubit;

  const EmailVerifyingScreen({Key? key, this.authCubit}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EmailVerifyingScreenState();
  }
}

class EmailVerifyingScreenState extends State<EmailVerifyingScreen>with Validations {
  final otpController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: BlocProvider(
        create: (context) => VerifyEmailBloc(
            authRepo: context.read<AuthRepository>(),
            authCubit: context.read<AuthCubit>()),
        child: Container(
          color: const Color.fromRGBO(230, 230, 230, 1),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  alignment: Alignment.center,
                  child: Column(children: [
                    Text(
                      "${widget.authCubit?.credentials!.eMail!.trim()} email hesabına bir kod yolladık. email hesabını doğrulayabilmemiz için lütfen kodu aşağıya gir.",
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 40,
                ),
                BlocListener<VerifyEmailBloc, VerifyEmailState>(
                  listener: (BuildContext context, state) {
                    var formStatus = state.formStatus;
                    // exception management
                    printException(formStatus: formStatus,context: context);
                  },
                  child: buildFormField(),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildSubmitButton(),
                    reSendOTPButton(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form buildFormField() {
    return Form(
      key: formKey,
      child: const EmailVerificationField(),
    );
  }

  Widget buildSubmitButton() {
    return BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
        builder: (context, state) {
      return state.formStatus is FormSubmitted
          ? const CircularProgressIndicator()
          : TextButton(
              onPressed: () {
                _onPressed(context);
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.only(
                    left: 35,
                    right: 35,
                  )),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide.none,
                  ))),
              child: const Text(
                "Onayla",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black45,
                ),
              ));
    });
  }

  Widget reSendOTPButton() {
    return BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
        builder: (context, state) {
      return TextButton(
        onPressed: () async {
          context
              .read<VerifyEmailBloc>()
              .add(verify_email_event.RestartFormStatus());
          context
              .read<VerifyEmailBloc>()
              .add(verify_email_event.VerifyEmailCodeChanged(code: ""));
          await sendOTP(widget.authCubit!.credentials!.eMail!);
        },
        child: const Text(
          "Kod gönder",
          style: TextStyle(fontSize: 15, color: Colors.black45),
        ),
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.only(left: 20, right: 20)),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide.none,
            ))),
      );
    });
  }

  void _onPressed(BuildContext context) async {
    if (formKey.currentState!.validate() == true) {
      context
          .read<VerifyEmailBloc>()
          .add(verify_email_event.VerifyEmailSubmitted());
    }
  }

  Future<bool> sendOTP(String eMail) async {
    var response =
        await EmailAuth(sessionName: "session").sendOtp(recipientMail: eMail);
    return response;
  }

  void printException({FormSubmissionStatus? formStatus, BuildContext? context}){
    String? message = verifyEmailExceptionPicker(formStatus!);
    if(message !=null){
      showMessage(message: message,context: context); //exception picker in validations
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
            title: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Meet",
                  style: GoogleFonts.gentiumBasic(
                      textStyle:
                      const TextStyle(color: Colors.white, fontSize: 35)),
                ),
                Text("Up",
                    style: GoogleFonts.gentiumBasic(
                        textStyle: const TextStyle(
                            color: Color.fromRGBO(255, 222, 118, 1),
                            fontSize: 35))),
                const Padding(padding: EdgeInsets.all(20)),
              ]),
            )),
        preferredSize: AppBar().preferredSize);
  }
}
