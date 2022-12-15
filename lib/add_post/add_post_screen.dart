import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/add_post/add_post_screen_bloc.dart';
import 'package:untitled1/add_post/add_post_screen_event.dart'as e;
import 'package:untitled1/bottom_navigation_bar/bottom_navigation_bar_cubit.dart';
import 'package:untitled1/repositories/data_repository.dart';
import 'package:untitled1/add_post/add_post_screen_state.dart' as s;
import 'package:untitled1/repositories/post_repository.dart';
import 'package:untitled1/repositories/user_credential_repository.dart';
import 'package:untitled1/utils/constants.dart' as constants;
import '../models/post.dart';
import '../models/user.dart';
import '../validators/validations.dart';

class AddPostScreen extends StatefulWidget {
  final User? user;
  final DataRepository? dataRepo;
  final BottomNavigationBarCubit bottomNavBarCubit;

  const AddPostScreen(
      {Key? key, this.user, this.dataRepo, required this.bottomNavBarCubit})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddPostScreenState();
  }
}

class AddPostScreenState extends State<AddPostScreen> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 100;
    double height = MediaQuery.of(context).size.height / 100;
    User? user = widget.user;
    String? userName = widget.dataRepo?.capitalizeFirstLetter(user!.name!);
    String? userLastName =
        widget.dataRepo?.capitalizeFirstLetter(user!.lastName!);
    Color color = constants.primaryTextColor.withOpacity(0.75);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: constants.backGroundColor,
      appBar: _appBar(context: context, width: width, height: height),
      body: BlocProvider<AddPostBloc>(
        create: (context) => AddPostBloc(
            userCredential: context.read<UserCredentialRepository>(),
            bottomNavBarCubit: widget.bottomNavBarCubit),
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(20),
          width: width * 90,
          height: height * 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  _circleAvatar(user!, width, height),
                  // avatar
                  Text(
                    userName!,
                    style: textStyle(color, width * 4),
                  ),
                  // user name
                  const SizedBox(width: 7),
                  Text(
                    userLastName!,
                    style: textStyle(color, width * 4),
                  ),
                  // user last name
                ],
              ),
              _thinLinePart(), //thin divider
              _form(width: width, height: height, color: color),
            ],
          ),
        ),
      ),
    );
  }

//COMPONENTS

  Form _form(
      {required double width, required double height, required Color color}) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          _descriptionPart(width: width, height: height, color: color),
          //description part
          _whatToDoPart(
              width: width, height: height, color: color),
          //whatToDo part
        ],
      ),
    );
  }

  Padding _whatToDoPart(
      {required double height,
      required double width,
      Color? color,}) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, top: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black45),
        ),
        height: height * 6.7,
        width: width * 70,
        child: _whatToDoFormField(),
        padding: const EdgeInsets.all(10),
      ),
    );
  }

  Widget _circleAvatar(User user, double width, double height) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 20),
      child: CircleAvatar(
          backgroundImage:
              const AssetImage("lib/assets/images/imageflutter.jpeg"),
          backgroundColor: constants.appBarColor.withOpacity(0.9),
          radius: width * 8,
          child: user.imageUrl! == " "
              ? Text(
                  user.name!.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    fontSize: width * 7,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              : const SizedBox(
                  width: 0,
                  height: 0,
                )),
    );
  }

  Container _descriptionPart(
      {required double width, required double height, required Color color}) {
    return Container(
      height: height * 15,
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.only(left: 30, top: 20, bottom: 30, right: 30),
      child: SingleChildScrollView(
        child: _postDescriptionField(),
        clipBehavior: Clip.antiAlias,
      ),
    );
  }

  TextStyle textStyle(Color? color, double? width) {
    return TextStyle(
        fontSize: width, color: color, fontWeight: FontWeight.bold);
  }

  Widget _thinLinePart() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
        top: 30,
      ),
      child: Container(
        height: 0.2,
        color: Colors.black45,
      ),
    );
  }

  PreferredSize _appBar(
      {required BuildContext context,
      required double width,
      required double height}) {
    return PreferredSize(
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          color: constants.appBarColor.withOpacity(0.9),
          alignment: Alignment.centerLeft,
          splashRadius: 2,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.cancel_outlined,
            color: Colors.white,
            size: width * 7,
          ),
        ),
        title: Text(
          "Yeni etkinlik",
          style: TextStyle(color: Colors.white, fontSize: width * 4.58),
        ),
        actions: [
          _doneButton(width: width, height: height),
        ],
        backgroundColor: constants.appBarColor.withOpacity(0.9),
        centerTitle: true,
      ),
      preferredSize: AppBar().preferredSize,
    );
  }

  Widget _doneButton({required double width, required double height}) {
    return BlocBuilder<AddPostBloc, s.AddPostScreenState>(
      builder: (context, state) => TextButton(
          clipBehavior: Clip.none,
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            backgroundColor: MaterialStateProperty.all(
                constants.appBarColor.withOpacity(0.9)),
          ),
          onPressed: () async{
            context.read<AddPostBloc>().add(e.PostSubmitted());
            Navigator.of(context).pop();
            widget.bottomNavBarCubit.selectIndex(0);
          },
          child: Text(
            "Paylaş",
            style: TextStyle(color: Colors.blue, fontSize: width * 4.10),
          )),
    );
  }

  BlocBuilder _postDescriptionField() {
    return BlocBuilder<AddPostBloc, s.AddPostScreenState>(
      builder: (context, state) {
        return TextFormField(
            maxLines: null,
            cursorColor: Colors.blueAccent,
            style: const TextStyle(
              color: Colors.black54,
            ),
            onChanged: (value) {
              context
                  .read<AddPostBloc>()
                  .add(e.PostDescriptionChanged(description: value));
            },
            keyboardType: TextInputType.text,
            validator: (description) => Validations()
                .postDescriptionValidator(description: description),
            decoration: InputDecoration(
                errorStyle: const TextStyle(fontSize: 9),
                hintText: "Açıklama yaz..",
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                filled: true,
                fillColor: Colors.white.withOpacity(0.80),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8)),
                isDense: true,
                errorMaxLines: 1,
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(5))));
      },
    );
  }

  Widget _whatToDoFormField() {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 7),
      child: BlocBuilder<AddPostBloc, s.AddPostScreenState>(
        builder: (context, state) => TextFormField(
            cursorColor: Colors.blueAccent,
            style: const TextStyle(
              color: Colors.black54,
            ),
            onChanged: (value) {
              context
                  .read<AddPostBloc>()
                  .add(e.PostWhatToDoChanged(whatToDo: value));
            },
            keyboardType: TextInputType.text,
            validator: (whatToDo) =>
                Validations().postWhatToDoValidator(whatToDo: whatToDo),
            decoration: InputDecoration(
                errorStyle: const TextStyle(fontSize: 9),
                hintText: "Ne Yapacaksın ?",
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8)),
                isDense: true,
                errorMaxLines: 1,
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(5),
                ),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(5)))),
      ),
    );
  }
}
