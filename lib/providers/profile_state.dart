import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edenfarm_test/commons/base_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileState extends BaseProvider{
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerHeight = TextEditingController();

  String birthDate = "";
  DateTime selectedDate = DateTime.now();
  String? fireStoreUserId;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1965),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate){
      selectedDate = picked;
      birthDate = DateFormat('dd / MM / yyyy').format(selectedDate);
    }
    notifyListeners();
  }

  void getFirestoreUserData()async{
    User? user = FirebaseAuth.instance.currentUser;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('userModel')
        .limit(1)
        .where('email', isEqualTo: user!.email.toString())
        .get();
    CollectionReference _collectionReference = FirebaseFirestore.instance.collection('userModel');
    
    QuerySnapshot result = await _collectionReference.where('email', isEqualTo: user!.email.toString()).get();
    
    if(querySnapshot.docs.length>0){
      DocumentSnapshot documentSnapshot = querySnapshot.docs[0];
      fireStoreUserId = documentSnapshot.id;
      var data = documentSnapshot.data() as Map<String,dynamic>;
      
      controllerUsername.text = data['name']??"";
      controllerEmail.text = data['email']??user.email.toString();
      controllerHeight.text = data['height']??"";
      if(data['birthDate'] == null){
        selectedDate = DateTime.now();
      }else{
        Timestamp birthDateTimestamp = data['birthDate'];
        selectedDate = DateTime.fromMicrosecondsSinceEpoch(birthDateTimestamp.microsecondsSinceEpoch);
      }
      birthDate = DateFormat('dd / MM / yyyy').format(selectedDate);
    }
    notifyListeners();
  }


}