import 'package:adolapp/screens/add_product_screen.dart';
import 'package:adolapp/screens/cart_screen.dart';
import 'package:flutter/rendering.dart';

import './products_screen.dart';
import './profile_screen.dart';
import 'package:flutter/material.dart';

class HometabsScreen extends StatefulWidget {
  @override
  _HometabsScreenState createState() => _HometabsScreenState();
}

class _HometabsScreenState extends State<HometabsScreen> {
  final List<Widget> _pages = [
    ProductsScreen(),
    ProfileScreen(),
  ];

  int _selectedPageIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _addProduct() {
    Navigator.of(context).pushNamed(AddProductScreen.routeName, arguments: {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adol"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        ],
      ),
      body: _pages[_selectedPageIndex],
      floatingActionButton: _selectedPageIndex == 0
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: _addProduct,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: _selectedPageIndex == 0 ? CircularNotchedRectangle() : null,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _selectedPage(0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.home,
                        color: _selectedPageIndex == 0
                            ? Theme.of(context).accentColor
                            : Colors.black54,
                        semanticLabel: "Home",
                      ),
                      Text(
                        "HOME",
                        style: Theme.of(context).textTheme.title.copyWith(
                              color: _selectedPageIndex == 0
                                  ? Theme.of(context).accentColor
                                  : Colors.black54,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _selectedPage(1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.account_circle,
                        color: _selectedPageIndex == 1
                            ? Theme.of(context).accentColor
                            : Colors.black54,
                      ),
                      Text(
                        "PROFILE",
                        style: Theme.of(context).textTheme.title.copyWith(
                              color: _selectedPageIndex == 1
                                  ? Theme.of(context).accentColor
                                  : Colors.black54,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
