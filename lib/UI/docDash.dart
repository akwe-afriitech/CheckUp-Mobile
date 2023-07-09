import 'dart:async';

import 'package:checkup/UI/docDirectory/abnormalities.dart';
import 'package:checkup/UI/docDirectory/account.dart';
import 'package:checkup/UI/docDirectory/criticalCases.dart';
import 'package:checkup/UI/docDirectory/notifications.dart';
import 'package:checkup/UI/docDirectory/patients.dart';
import 'package:checkup/UI/patientDoc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class docDash extends StatefulWidget {
  const docDash({Key? key}) : super(key: key);

  @override
  State<docDash> createState() => _docDashState();
}

class _docDashState extends State<docDash> {

  final user = FirebaseAuth.instance.currentUser;

  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), ()
        {
              if (user != null){
                final uid = user?.uid;
                DocumentReference users = FirebaseFirestore.instance.collection('userData').doc(uid);
                users.set({
                  "role":"doc",
                },
                );
              }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final user =  FirebaseAuth.instance.currentUser!;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              accountName: Container(
                child:  Text("Name: ${user.displayName}"),
              ),
              accountEmail:const Text('Number: pending....'),
              otherAccountsPictures: const [
                CircleAvatar(
                  child: Icon(Icons.person_add),
                ),
              ],
            ),
            ListTile(
              tileColor: Colors.grey[200],
              leading: const Icon(Icons.home),
              title: const Text("Dashboard"),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("Patients"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const patients()),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text("Critical Cases"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const criticalCases()),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bloodtype_outlined),
              title: const Text("Abnomalities"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const abnormalities(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text("Notifications"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const notifications(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text("My Account"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const myAccount(),
                  ),
                );
              },
            ),
            Container(
              width: 20,
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

            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Medical Info Today'),
        centerTitle: true,
        actions: [

          IconButton(
            icon: const Icon(Icons.notifications)
            ,onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const notifications(),
              ),
            );
          },),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              alignment: Alignment.centerLeft,
              child: Text('Hey Dr, ${user.displayName} 👋 ️'),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150.0,
                  height: 200.0,
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.all(15.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [ Colors.pinkAccent, Colors.pink, Colors.redAccent,Colors.red]
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.red, width: 2.0)
                  ),
                  child:Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Patients ',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Expanded(
                        child: Container(
                          child:Icon(Icons.people,
                              size:100,
                              color:Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text('75 Patients',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 150.0,
                  height: 200.0,
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.all(15.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [ Colors.pinkAccent, Colors.pink, Colors.redAccent,Colors.red]
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.red, width: 2.0)
                  ),
                  child:Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Critical Cases',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Expanded(
                        child: Container(
                          child:Icon(Icons.dangerous,
                              size:100,
                              color:Colors.white),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text('5 cases ',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150.0,
                  height: 200.0,
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.all(15.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [ Colors.pinkAccent, Colors.pink, Colors.redAccent,Colors.red]
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.red, width: 2.0)
                  ),
                  child:Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text('Abnormalities',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),),
                      ),
                      Expanded(
                        child: Container(
                          child:Icon(Icons.addchart_outlined,
                              size:100,
                              color:Colors.white),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text('5 Cases',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 150.0,
                  height: 200.0,
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.all(15.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [ Colors.pinkAccent, Colors.pink, Colors.redAccent,Colors.red]
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.red, width: 2.0)
                  ),
                  child:Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('My Account',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Expanded(
                        child: Container(
                          child: const Icon(Icons.account_circle,
                              size:100,
                              color:Colors.white),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('edit ',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}