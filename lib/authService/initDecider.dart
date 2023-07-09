import 'package:checkup/UI/docDash.dart';
import 'package:checkup/UI/patientDash.dart';
import 'package:checkup/UI/patientDoc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class initDecider extends StatefulWidget {
  const initDecider({Key? key}) : super(key: key);

  @override
  State<initDecider> createState() => _initDeciderState();
}

final user = FirebaseAuth.instance.currentUser;

class _initDeciderState extends State<initDecider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              FirebaseFirestore.instance
                  .collection('userData')
                  .doc(user?.uid)
                  .get()
                  .then((DocumentSnapshot documentSnapshot) {
                if (documentSnapshot.exists) {
                  if (documentSnapshot['role'] == 'doc') {
                    return doc();
                  }
                  return patient();
                }
                print('Account does not exists in the database');
              });
              return Center(child: Container(
                width: 200,
                margin: const EdgeInsets.symmetric(horizontal:50),
                padding: const EdgeInsets.symmetric(vertical:50),

                child: ElevatedButton(
                  child: const Text('signout') ,
                  onPressed: (){
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context)=> const Center(child: CircularProgressIndicator(),)
                    );
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const patientDoc(),
                      ),
                    );

                  },
                ),

              ),) ;
            } else {
              return const patientDoc();
            }
          }),
    );
  }

  doc() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const docDash()),
    );
  }

  patient() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const patientDash()),
    );
  }

  authacces(BuildContext context) {
    FirebaseFirestore.instance
        .collection('userData')
        .doc(user?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot['role'] == 'doc') {
          return doc();
        }
        return patient();
      }
      print('Account does not exists in the database');
    });
  }
}
