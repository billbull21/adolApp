import 'package:adolapp/helpers/getSharedPrefrences.dart';
import 'package:adolapp/helpers/toastHelper.dart';
import 'package:adolapp/provider/product_provider.dart';
import 'package:adolapp/values/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final cartId;
  final cartData;

  CartItem(this.cartId, this.cartData);

//  void setData(ProductProvider productProvider) async {
//    DocumentSnapshot doc = await Firestore.instance
//        .collection('products')
//        .document(cartData['product_id'])
//        .get()
//        .then((onValue) => onValue);
//    print("HEREE");
//    productProvider.saveProductData(doc);
//  }

  @override
  Widget build(BuildContext context) {
//    final _productProvider =
//        Provider.of<ProductProvider>(context);
//    setData(_productProvider);
//
//    print("Here : "+_productProvider.getProduct());

    return StreamBuilder(
      stream: Firestore.instance
          .collection('products')
          .document(cartData['product_id'])
          .snapshots(),
      builder: (ctx, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        Timestamp timestamp = snapshot.data['updated_at'];
        String time =
            DateFormat("dd MMMM yyyy HH:mm").format(timestamp.toDate());
        print(snapshot.data.toString());
        return Dismissible(
          key: Key(cartId),
          onDismissed: (direction) async {
            Firestore.instance
                .collection("users")
                .document(await getSharedString(userID))
                .collection('cart')
                .document(cartId)
                .delete()
                .then((res) {
              showInfoToast("product removed from cart");
            }).catchError((err) => print("error : $err"));
          },
          direction: DismissDirection.endToStart,
          background: Container(
            color: Theme.of(context).errorColor,
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 40,
            ),
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            margin: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
          ),
          child: ListTile(
            leading: Image.network(
              snapshot.data['product_thumb'],
              fit: BoxFit.fill,
              width: 50,
              height: 100,
            ),
            title: Text(snapshot.data['product_name']),
            subtitle: Text(time),
            trailing: Text("${snapshot.data['product_price'].toString()} x ${cartData['quantity']}"),
            contentPadding: EdgeInsets.all(8.0),
          ),
        );
      },
    );
  }
}
