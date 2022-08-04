import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edenfarm_test/commons/base_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeState extends BaseProvider{
  User? user;
  String? firestoreUserId;
  Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (_) {

    }
  }

  void getFirestoreUserId()async{
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('userModel')
        .limit(1)
        .where('email', isEqualTo: user!.email.toString())
        .get();
    if(querySnapshot.docs.length>0){
      DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
      firestoreUserId = documentSnapshot.id;
    }
  }
}