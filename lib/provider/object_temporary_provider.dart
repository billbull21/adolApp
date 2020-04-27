import 'package:flutter/material.dart';

// this class handle object data changes
class ObjectTemporaryProvider with ChangeNotifier {

  String cartId;

  // this is will use temporary
  void saveProduct(String id) {
    cartId = id;
    notifyListeners();
  }

  String getCartId() {
    return cartId;
  }

}