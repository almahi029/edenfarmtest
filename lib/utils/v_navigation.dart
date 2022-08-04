import 'package:edenfarm_test/views/home_screen.dart';
import 'package:edenfarm_test/views/login_screen.dart';
import 'package:flutter/material.dart';

class VNavigation {
//  static void replaceHome(BuildContext context) {
//    Navigator.pushReplacementNamed(context, '/home',);
//  }

  static void register(BuildContext context,) {
    Navigator.pushNamed(context, '/register',);
  }
  static void profile(BuildContext context,) {
    Navigator.pushNamed(context, '/profile',);
  }


  static void home(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(),
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position:
                Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
            child: child,
          );
        },
      ),
      (route) => false,
    );
  }

  static void login(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position:
            Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
            child: child,
          );
        },
      ),
          (route) => false,
    );
  }

}
