import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/auth/form_submission_status.dart';
import 'package:untitled1/auth/auth_repository.dart';
import 'package:untitled1/auth/signup/signup_bloc.dart';
import 'package:untitled1/auth/signup/signup_event.dart';
import 'package:untitled1/auth/signup/signup_state.dart';
import 'package:untitled1/repositories/data_repository.dart';
import 'package:untitled1/auth_widgets/lastName_field.dart';
import 'package:untitled1/auth_widgets/name_field.dart';
import '../../auth_widgets/signup_eMail_field.dart';
import '../../auth_widgets/signup_password_field.dart';
import '../auth_cubit.dart';
import 'package:untitled1/utils/constants.dart' as constants;

class SignupScreenWidget extends StatefulWidget {
  final DataRepository dataRepo;
  final AuthRepository authRepo;
  const SignupScreenWidget({
    Key? key,
    required this.dataRepo, required this.authRepo
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SignupScreenWidgetState();
  }
}

class SignupScreenWidgetState extends State<SignupScreenWidget>{
  var key = GlobalKey<FormState>();
  AuthRepository? authRepo;
  AuthCubit? authCubit;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(240, 240, 240, 1),
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: BlocProvider(
        create: (context) => SignupBloc(
            authRepo: context.read<AuthRepository>(),
            authCubit: context.read<AuthCubit>()),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Container(
                height: height / 1.57,
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 25, bottom: 0),
                child: buildFormField(height,width)
            ), //signup button inside--
            buildBottomPart(context),
          ],
        ),
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

  Widget buildFormField(double height,double width) {
    return BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          void onchanged({required BuildContext context}){};
          final formStatus = state.formStatus;
          // exceptions management//
          widget.authRepo.printException(
              pickerType: "signUp",
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
                      fontSize: width*0.045),
                )),
                padding: const EdgeInsets.only(top: 0, bottom: 10),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: NameField(),
              ),
              const Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: LastNameField()),

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
        _onPressed(context);
      },
      child: Text(
        "Kaydol",
        style: TextStyle(color: constants.primaryTextColor.withOpacity(0.6)),
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

  void _onPressed(BuildContext context) async {
    if (key.currentState!.validate() == true) {
      context.read<SignupBloc>().add(SignupSubmitted());
    }
  }

  PreferredSize _appBar(){
    return PreferredSize(
        child: AppBar(
            backgroundColor: constants.appBarColor.withOpacity(0.9),
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
                          color: constants.appNameColor,
                          fontSize: 32))),
            ])),
        preferredSize: AppBar().preferredSize);
  }
}
