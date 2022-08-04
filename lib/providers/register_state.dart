import 'package:edenfarm_test/commons/base_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterState extends BaseProvider{

  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  bool isSecureText = true;

  Future<User?> registerWithEmail({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      user = (await auth.createUserWithEmailAndPassword(
        email: controllerEmail.text,
        password: controllerPassword.text,
      )).user;

    }catch(_){

    }
    return user;
  }

  Future<void> addUsertoFirestore() async {
    await FirebaseFirestore.instance.collection("userModel").add({
      'name': controllerUsername.text,
      'email': controllerEmail.text,
    });
  }

}