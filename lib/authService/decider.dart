import 'dart:async';
import 'package:checkup/UI/docDash.dart';
import 'package:checkup/UI/docReg.dart';
import 'package:checkup/UI/patientDash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class decider extends StatefulWidget {
  const decider({Key? key}) : super(key: key);

  @override
  State<decider> createState() => _deciderState();
}

class _deciderState extends State<decider> {
  @override
  final user = FirebaseAuth.instance.currentUser;


  void initState() {
    super.initState();
    Timer(Duration(seconds: 0),
            () {
          authacces(context);

        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            margin:EdgeInsets.all(40),
            child:Text('CheckUp',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),),
          ),
        ),
      ),
    );
  }


  patient() {
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder:
          (context) =>
          patientDash()
      ),
    );
  }
  patientreg() {
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder:
          (context) => patientreg()
      ),
    );
  }
  doc() {
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder:
          (context) =>
          docDash()
      ),
    );
  }
  docreg() {
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder:
          (context) =>
          docReg()
      ),);
  }
  authacces(BuildContext context){
    FirebaseFirestore.instance
        .collection('userData')
        .doc(user?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if(documentSnapshot['role']== 'doc'){
          return docAccess(context);
        }
        return patientAccess(context);
      }
      print('Document does not exists on the database');
    });
  }
  docAccess(BuildContext context){
    FirebaseFirestore.instance
        .collection('UserData')
        .doc(user?.uid)
        .collection('request')
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.size == null) {
        return docreg();
      }
      else {
        return doc();
      }
    });

  }
  patientAccess(BuildContext context){
    FirebaseFirestore.instance
        .collection('UserData')
        .doc(user?.uid)
        .collection('request')
        .limit(1)
        .get()
        .then((snapshot) {
      if (snapshot.size == null ) {
        return patientreg();
      }
      else {
        return patient();
      }
    });
  }
}



