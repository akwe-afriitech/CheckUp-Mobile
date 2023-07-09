
import 'package:checkup/UI/docReg.dart';
import 'package:checkup/UI/login.dart';
import 'package:checkup/UI/patientReg.dart';
import 'package:flutter/material.dart';

class patientDoc extends StatelessWidget {
  const patientDoc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 450,
                margin: const EdgeInsets.all( 35.0),
                padding: const EdgeInsets.only(top: 30.0),
                decoration: BoxDecoration(
                  border:Border.all( width: 8.0, color: Colors.red, ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Container(
                      margin:EdgeInsets.all(40),
                      child:Text('CheckUp',
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(250, 50),
                            shape: const StadiumBorder(),
                          ),
                          onPressed: (){
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context)=> const Center(child: CircularProgressIndicator(),)
                            );
                            Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context) =>
                                  patientReg(),
                              ),);
                          },
                          child: const Text('Patient',
                            style:TextStyle(
                                fontSize: 17
                            ) ,
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(260,50),
                            shape: const StadiumBorder(),
                          ),
                          onPressed: (){
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context)=> const Center(child: CircularProgressIndicator(),)
                            );
                            Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context) =>
                                  docReg(),
                              ),);
                          },
                          child: const Text('Doctor',
                            style: TextStyle(
                                fontSize: 17
                            ),
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an Account:'),
                          TextButton(
                              onPressed: (){
                                showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context)=> const Center(child: CircularProgressIndicator(),)
                                );
                                Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder:
                                      (context) =>
                                      login(),
                                  ),);
                              },
                              child: const Text('Login',
                                style: TextStyle(
                                    fontSize: 17
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
