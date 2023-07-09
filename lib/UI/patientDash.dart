import 'dart:async';
import 'package:checkup/UI/docDirectory/account.dart';
import 'package:checkup/UI/docDirectory/notifications.dart';
import 'package:checkup/UI/patientDirectory/Others.dart';
import 'package:checkup/UI/patientDirectory/heartRate.dart';
import 'package:checkup/UI/patientDirectory/sugarLevel.dart';
import 'package:checkup/UI/patientDoc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';



class patientDash extends StatefulWidget {
  const patientDash({Key? key}) : super(key: key);

  @override
  State<patientDash> createState() => _patientDashState();
}


class _patientDashState extends State<patientDash> {
  @override
  final user = FirebaseAuth.instance.currentUser;

  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), ()
    {
      if (user != null){
        final uid = user?.uid;
        DocumentReference users = FirebaseFirestore.instance.collection('userData').doc(uid);
        users.set({
          "role":"patient",
        },
        );
      }
    }
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              accountName: Container(
                child:  Text("Name: ${user!.displayName}"),
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
              leading: const Icon(Icons.receipt_long),
              title: const Text("Heart Rate"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const heartRate()),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bloodtype),
              title: const Text("Blood/Sugar Level"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const sugarLevel()),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.bloodtype_outlined),
              title: const Text("Others"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const others(),
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
            // Container(
            //   alignment: Alignment.center,
            //   margin: const EdgeInsets.all(10),
            //   padding: const EdgeInsets.all(10),
            //   decoration: const BoxDecoration(
            //     // border: Border.all(width: 3, color: Colors.red)
            //   ),
            //   child: const Text('Patient dash',
            //     style: TextStyle(
            //       fontWeight: FontWeight.bold,
            //       fontSize: 30,
            //       color: Colors.red,
            //     ),
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.all(15),
              alignment: Alignment.centerLeft,
              child: Text('Hey, ${user!.displayName} 👋 ️'),
            ),
            Container(
              child: CircularPercentIndicator(
                  radius: 125.0,
                  lineWidth: 13.0,
                  animation: true,
                  percent: 0.37,
                  center: const Text(
                    "37.0°C",
                    style:
                     TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
                  ),
                  footer: Text(
                    "Current Body Temperature",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Colors.redAccent,
                ),
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
                        child: Text('Heart Rate ', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Expanded(
                        child: Container(
                          child:Icon(Icons.monitor_heart,
                          size:100,
                          color:Colors.white),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text('75 BPM',
                          style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
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
                        child: const Text('Blood Pressure',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Expanded(
                        child: Container(
                          child: const Icon(Icons.bloodtype,
                              size:100,
                              color:Colors.white),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text('120/80 ', style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
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


