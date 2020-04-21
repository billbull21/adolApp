import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final Firestore firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adol"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('products').orderBy('created_at').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = snapshot.data.documents[index];
              Map<String, dynamic> task = document.data;
              return Card(
                child: ListTile(
                  title: Text(task['product_name']),
                  subtitle: Text(
                    task['product_desc'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  isThreeLine: false,
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 24.0,
                        height: 24.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "here",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        "Here",
                        style: TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (BuildContext context) {
                      return List<PopupMenuEntry<String>>()
                        ..add(PopupMenuItem<String>(
                          value: 'edit',
                          child: Text('Edit'),
                        ))
                        ..add(PopupMenuItem<String>(
                          value: 'delete',
                          child: Text('Delete'),
                        ));
                    },
                    onSelected: (String value) async {
                      if (value == 'edit') {
                        // TODO: fitur edit task
                      } else if (value == 'delete') {
                        // TODO: fitur hapus task
                      }
                    },
                    child: Icon(Icons.more_vert),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
