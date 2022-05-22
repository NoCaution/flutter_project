import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/auth/auth_cubit.dart';
import 'package:untitled1/auth/form_submission_status.dart';
import 'package:untitled1/auth/login/auth_repository.dart';
import 'package:untitled1/auth/verify_email/verif_email_event.dart'
    as verify_email_event;
import 'package:untitled1/auth/verify_email/verify_email_bloc.dart';
import 'package:untitled1/auth/verify_email/verify_email_state.dart';
import 'package:untitled1/widgets/email_verification_field.dart';

class EmailVerifyingScreen extends StatefulWidget {
  final AuthCubit? authCubit;
  const EmailVerifyingScreen({
    Key? key,this.authCubit
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EmailVerifyingScreenState();
  }
}

class EmailVerifyingScreenState extends State<EmailVerifyingScreen> {
  final otpController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
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
        create: (context) => VerifyEmailBloc(
            authRepo: context.read<AuthRepository>(),
            authCubit: context.read<AuthCubit>()),
        child: Container(
          color: const Color.fromRGBO(220, 220, 220, 1),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  alignment: Alignment.center,
                  child: Column(children: [
                    Text(
                      "'${widget.authCubit?.credentials!.eMail!.trim()}' email hesabına bir kod yolladık. email hesabını doğrulayabilmemiz için lütfen kodu aşağıya gir..",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: BlocListener<VerifyEmailBloc, VerifyEmailState>(
                    listener: (BuildContext context, state) {
                      var formStatus = state.formStatus;
                      // exception management
                      checkForExceptions(formStatus!);
                    },
                    child: buildFormField(),
                  ),
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

  Form buildFormField(){
    return Form(
      key: formKey,
      child: EmailVerificationField(otpController: otpController,),
    );
  }
  Widget buildSubmitButton() {
    return BlocBuilder<VerifyEmailBloc, VerifyEmailState>(
        builder: (context, state) {
          return state.formStatus is FormSubmitted
              ? const CircularProgressIndicator()
              : TextButton(
              onPressed: () {
                onPressed(context);
              },
              child: const Text(
                "Onayla",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(47, 183, 254, 0.9),
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
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide.none,
            ))),
      );
    });
  }

  void onPressed(BuildContext context) async {
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

  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      timeInSecForIosWeb: 1,
      toastLength: Toast.LENGTH_LONG,
    );
  }
  void checkForExceptions(FormSubmissionStatus formStatus) {
    if (formStatus is SubmissionFailed) {
      showToast(formStatus.error!);
    }
    if (formStatus is SubmissionFailed &&
        formStatus.exception.toString() != "null") {
      showToast(formStatus.exception.toString());
    }
  }
}
