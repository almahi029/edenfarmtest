import 'package:edenfarm_test/views/home_screen.dart';
import 'package:edenfarm_test/views/login_screen.dart';
import 'package:edenfarm_test/views/profile_screen.dart';
import 'package:edenfarm_test/views/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  User? user = FirebaseAuth.instance.currentUser;
  bool isLoggedIn = false;
  if(user!=null){
    isLoggedIn = true;
  }
  runApp(MyApp(isLoggedIn: isLoggedIn,));
}

class MyApp extends StatelessWidget {
  bool? isLoggedIn;
  MyApp({Key? key,this.isLoggedIn = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/home": (context) => HomeScreen(),
        "/login": (context) => LoginScreen(),
        "/register": (context) => RegisterScreen(),
        "/profile": (context) => ProfileScreen(),

      },
      title: 'Eden Farm Test',
      home: isLoggedIn! ? HomeScreen() : LoginScreen(),
    );
  }
}
