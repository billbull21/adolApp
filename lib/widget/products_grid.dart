import 'package:adolapp/widget/product_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsGrid extends StatelessWidget {

  final snapshot;

  ProductsGrid(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: snapshot.data.documents.length,
      itemBuilder: (BuildContext context, int index) {
        DocumentSnapshot document = snapshot.data.documents[index];
        String productId = document.documentID;
        Map<String, dynamic> product = document.data;
        return ProductItem(productId, product);
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        childAspectRatio: 2/3,
        mainAxisSpacing: 10,
      ),
    );
  }
}
