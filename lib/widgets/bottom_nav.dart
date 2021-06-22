import 'package:emilios_market/constants.dart';
import 'package:flutter/material.dart';
import 'package:emilios_market/screens/home_page.dart';
import 'package:emilios_market/screens/menu_page.dart';
import 'package:emilios_market/screens/cart_page/cart_page.dart';
import 'package:emilios_market/screens/account_page.dart';

class BottomNav extends StatefulWidget {
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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          iconSize: 26,
          backgroundColor: Colors.white,
          selectedItemColor: kPrimaryColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant),
              title: Text("Menu"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text("Cart"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text("Account"),
            ),
          ],
        ));
  }
}
