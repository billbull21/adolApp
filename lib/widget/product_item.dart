import 'package:adolapp/screens/detail_product_screen.dart';
import 'package:adolapp/widget/custom_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

import '../helpers/getSharedPrefrences.dart';
import '../provider/object_temporary_provider.dart';
import '../values/strings.dart';

class ProductItem extends StatelessWidget {

  final productId;
  final product;

  ProductItem(this.productId, this.product);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(DetailProductScreen.routeName, arguments: {"id" : productId,"data": product});
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: Hero(
            tag: productId,
            child: Image.network(
              product['product_thumb'],
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                );
              },
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              product['product_name'],
              textAlign: TextAlign.left,
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                showDialog(context: context, builder: (BuildContext context) => NumberPickerDialog.integer(minValue: 1, maxValue: 10, initialIntegerValue: 1, title: Text("Quantity"),),).then((onValue) async {
                  if (onValue == null) {
                    return;
                  }
                  Firestore.instance
                      .collection("users")
                      .document(await getSharedString(userID))
                      .collection('cart')
                      .add({
                  "product_id": productId,
                  "quantity": onValue,
                  "created_at": Timestamp.now(),
                  "updated_at": Timestamp.now(),
                  }).then((result) {
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Added product to cart!',
                        ),
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () async {
                            Firestore.instance
                                .collection("users")
                                .document(await getSharedString(userID))
                                .collection('cart')
                                .document(result.documentID).delete()
                                .then((res) {})
                                .catchError((err) => print(err));
                          },
                        ),
                      ),
                    );
                  }).catchError((err) => print(err));
                });
              },
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
