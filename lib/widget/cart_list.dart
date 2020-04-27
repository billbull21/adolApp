import 'package:adolapp/widget/cart_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartList extends StatelessWidget {

  final snapshot;

  CartList(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: snapshot.data.documents.length,
      itemBuilder: (BuildContext context, int index) {
        DocumentSnapshot document = snapshot.data.documents[index];
        String cartId = document.documentID;
        Map<String, dynamic> cartData = document.data;
        return Column(
          children: <Widget>[
            CartItem(cartId, cartData),
            Divider(color: Colors.black26,),
          ],
        );
      },
    );
  }
}
