import 'package:emilios_grocery/constants.dart';
import 'package:emilios_grocery/screens/account_page/account_page.dart';
import 'package:emilios_grocery/screens/cart_page/cart_page.dart';
import 'package:emilios_grocery/screens/home_page.dart';
import 'package:emilios_grocery/widgets/panel_widget.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PageControl extends StatefulWidget {
  @override
  _PageControlState createState() => _PageControlState();
}

class _PageControlState extends State<PageControl> {
  final PageController _pageController = PageController(initialPage: 1);
  final _panelController = PanelController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        controller: _panelController,
        collapsed: GestureDetector(
          onTap: _panelController.open,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 12.0),
                dragIcon(),
                const SizedBox(height: 12.0),
                Text("Menu",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    )),
              ],
            ),
          ),
        ),
        maxHeight: MediaQuery.of(context).size.height,
        minHeight: 65.0,
        panelBuilder: (scrollController) {
          return PanelWidget(
            scrollController: scrollController,
            panelController: _panelController,
          );
        },
        body: pageSwipe(),
      ),
    );
  }

  Widget dragIcon() => Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        width: 40,
        height: 8,
      );

  Widget pageSwipe() {
    return PageView(
      controller: _pageController,
      onPageChanged: (newIndex) {
        setState(() {
          this._currentIndex = newIndex;
          if (newIndex == 0) {
            hidePanel();
          } else {
            showPanel();
          }
        });
      },
      children: [
        AccountPage(),
        HomePage(),
        CartPage(),
      ],
    );
  }

  Future<void> hidePanel() async {
    _panelController.isPanelShown;
    _panelController.hide();
  }

  Future<void> showPanel() async {
    _panelController.isPanelShown;
    _panelController.show();
  }
}
