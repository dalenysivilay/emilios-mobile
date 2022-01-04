import 'package:emilios_grocery/constants.dart';
import 'package:emilios_grocery/screens/account_page/account_page.dart';
import 'package:emilios_grocery/screens/cart_page/cart_page.dart';
import 'package:emilios_grocery/screens/home_page.dart';
import 'package:emilios_grocery/screens/menu_page.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  final int index;

  const BottomNav({
    Key key,
    this.index,
  }) : super(key: key);
  @override
  _BottomNav createState() => _BottomNav();
}

class _BottomNav extends State<BottomNav> {
  int _selectedPageIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    MenuPage(),
    CartPage(),
    AccountPage(),
  ];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedPageIndex],
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 8.0,
            bottom: 8.0,
          ),
          color: Colors.white,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: _selectPage,
            currentIndex: _selectedPageIndex,
            elevation: 0,
            iconSize: 26,
            backgroundColor: Colors.white,
            selectedItemColor: kPrimaryColor,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant),
                label: "Menu",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Account",
              ),
            ],
          ),
        ));
  }
}
