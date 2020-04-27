import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {

  final onTap;
  final child;

  CustomOutlinedButton({this.onTap, this.child});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white30, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        width: double.infinity,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}