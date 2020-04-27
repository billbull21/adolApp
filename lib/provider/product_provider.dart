import 'package:adolapp/widget/product_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductData {

  final productName;
  final productDesc;
  final productThumb;
  final productPrice;
  final createdAt;
  final updatedAt;

  const ProductData(this.productName, this.productDesc, this.productThumb, this.productPrice, this.createdAt, this.updatedAt);

}

class ProductProvider with ChangeNotifier {

  ProductData productData;

  void saveProductData(DocumentSnapshot data) {
    print("here");
    productData = ProductData(data['product_name'], data['product_desc'], data['product_thumb'], data['product_price'], data['createdAt'], data['updatedAt'],);
    print("data : "+productData.productThumb);
    notifyListeners();
  }

  String getProduct() {
    return productData.productName;
  }

}