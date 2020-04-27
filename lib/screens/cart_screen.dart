import 'package:adolapp/helpers/getSharedPrefrences.dart';
import 'package:adolapp/values/strings.dart';
import 'package:adolapp/widget/cart_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {

  static const routeName = "/CartScreen";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  String userId;

  void getUserId() async {
    final id = await getSharedString(userID);
    setState(() {
      userId = id;
    });
  }

  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Shopping Cart"),),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('users').document(userId).collection('cart').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return CartList(snapshot);
        },
      ),
    );
  }
}
