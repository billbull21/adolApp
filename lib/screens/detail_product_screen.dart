import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailProductScreen extends StatelessWidget {
  static const routeName = "DetailProductScreen";

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
        ModalRoute.of(context).settings.arguments as Map;

    Timestamp timestamp = data['data']['updated_at'];
    String time = DateFormat("dd MMMM yyyy HH:mm").format(timestamp.toDate());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 350,
                  color: Colors.red,
                ),
                Hero(
                  tag: data['id'],
                  child: Image.network(
                    data['data']['product_thumb'],
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
                    width: double.infinity,
                    height: 300,
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        shape: BoxShape.circle
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -5,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 30, left: 30, right: 20,),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(80)),
                      color: Colors.white
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(data['data']['product_name']),
                        Text(data['data']['product_price'].toString()),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          time,
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .copyWith(color: Colors.grey),
                        ),
                        Text(data['data']['product_desc']),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
