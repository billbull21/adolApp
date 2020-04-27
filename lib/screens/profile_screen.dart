import 'package:adolapp/api/authentication.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: RaisedButton(
        onPressed: () async {
          await Auth().signOut();
          Navigator.of(context).pushReplacementNamed("/");
        },
        child: Text("Sign out"),
      ),
    );
  }
}
