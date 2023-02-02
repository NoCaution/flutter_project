import 'package:flutter/cupertino.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  CustomPageRoute({required this.child,}) :super(
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondAnimation, Widget child) {
        return SlideTransition(position: Tween<Offset>(
          begin: const Offset(0.0,1.0),
          end: Offset.zero
        ).animate(animation),
          child: child,
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionDuration: const Duration(milliseconds: 175),
      reverseTransitionDuration: const Duration(milliseconds: 175)
  );
}

