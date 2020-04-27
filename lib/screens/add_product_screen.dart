import 'package:validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../helpers/validator.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = "/AddProductScreen";

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _productName;
  String _productThumb;
  String _productDesc;
  String _productPrice;
  
  bool _isLoading = false;
  bool _autoValidate = false;

  void _submitData() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    final FormState form = _formKey.currentState;
    setState(() {
      _isLoading = true;
    });
    if (form.validate()) {
      form.save(); //  trigger method onSaved on textFormField
      CollectionReference tasks = Firestore.instance.collection('products');
      DocumentReference result = await tasks.add(<String, dynamic>{
        'product_name': _productName,
        'product_desc': _productDesc,
        'product_price': _productPrice,
        'product_thumb': _productThumb,
        'created_at': DateTime.now(),
        'updated_at': DateTime.now(),
      });
      if (result.documentID != null) {
        Navigator.of(context).pop();
      }
    } else {
      setState(() {
        _isLoading = false;
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final heightMedia = (MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: heightMedia * 0.1,
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: heightMedia * 0.1,
                  padding: EdgeInsets.only(
                    left: 10.0,
                    top: 10.0,
                    right: 10.0,
                    bottom: 10.0,
                  ),
                  child: Text(
                    "Add New Product!",
                    style: Theme.of(context).textTheme.body1.copyWith(
                          color: Colors.white,
                          fontSize: 40,
                      fontFamily: 'Google'
                        ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  height: heightMedia * 0.8,
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      color: Colors.white),
                  child: Form(
                    key: _formKey,
                    autovalidate: _autoValidate,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: "Product Name", hintText: "type your product name",),
                          style: Theme.of(context).textTheme.body1,
                          validator: commonValidator,
                          onSaved: (input) => _productName = input,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Product Description", hintText: "type your product description",),
                          validator: commonValidator,
                          style: Theme.of(context).textTheme.body1,
                          onSaved: (input) => _productDesc = input,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Product Price", hintText: "type your product price",),
                          validator: commonValidator,
                          keyboardType: TextInputType.number,
                          style: Theme.of(context).textTheme.body1,
                          onSaved: (input) => _productPrice = input,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Product Thumbnail", hintText: "type your product thumb url",),
                          validator: urlValidator,
                          keyboardType: TextInputType.url,
                          style: Theme.of(context).textTheme.body1,
                          onSaved: (input) => _productThumb = input,
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: _isLoading ? CircularProgressIndicator() : RaisedButton(
                            child: Text("Add New Product", style: Theme.of(context).textTheme.title.copyWith(
                              color: Colors.white,
                            ),),
                            color: Theme.of(context).accentColor,
                            onPressed: _submitData,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
