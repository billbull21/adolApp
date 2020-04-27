import 'package:adolapp/screens/hometabs_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    FirebaseAuth.instance
        .currentUser()
        .then((currentUser) {
              if (currentUser == null) {
                Navigator.of(context).pushReplacementNamed("/login");
              } else {
                  Firestore.instance
                      .collection("users")
                      .document(currentUser.uid)
                      .get()
                      .then((DocumentSnapshot result) => currentUser.isEmailVerified ?
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => HometabsScreen())
                          ) : Navigator.of(context).pushReplacementNamed("/login"))
                      .catchError((err) => print(err));
              }
            })
        .catchError((err) => print(err));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Loading"),
      ),
    );
  }
}
