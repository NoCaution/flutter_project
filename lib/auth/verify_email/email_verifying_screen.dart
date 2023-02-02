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
import 'package:untitled1/repositories/data_repository.dart';
import 'package:untitled1/auth_widgets/email_verification_field.dart';

class EmailVerifyingScreen extends StatefulWidget {
  const EmailVerifyingScreen({Key? key,}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EmailVerifyingScreenState();
  }
}

class EmailVerifyingScreenState extends State<EmailVerifyingScreen>{
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
                      "${context.read<AuthCubit>().credentials!.eMail!.trim()} email hesabına bir kod yolladık. email hesabını doğrulayabilmemiz için lütfen kodu aşağıya gir.",
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
                    context.read<AuthRepository>().printException(formStatus: formStatus,context: context,pickerType: "eMailVerify");
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
          await context.read<AuthRepository>().sendOtp(eMail: context.read<AuthCubit>().credentials?.eMail!);
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
                  style: GoogleFonts.gentiumBookBasic(
                      textStyle:
                      const TextStyle(color: Colors.white, fontSize: 35)),
                ),
                Text("Up",
                    style: GoogleFonts.gentiumBookBasic(
                        textStyle: const TextStyle(
                            color: Color.fromRGBO(255, 222, 118, 1),
                            fontSize: 35))),
                const Padding(padding: EdgeInsets.all(20)),
              ]),
            )),
        preferredSize: AppBar().preferredSize);
  }
}
