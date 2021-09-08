import 'package:emilios_market/constants.dart';
import 'package:emilios_market/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PanelWidget extends StatelessWidget {
  final PanelController panelController;
  final ScrollController scrollController;
  final double tabBarHeight = 65.0;

  const PanelWidget({
    Key key,
    @required this.panelController,
    @required this.scrollController,
  }) : super(key: key);

  @override
  //PROBLEM PANEL HERE
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: tabBar(
        onClicked: panelController.close,
      ),
      body: BottomNav(),
    );
  }

  Widget tabBar({
    @required VoidCallback onClicked,
  }) =>
      PreferredSize(
        preferredSize: Size.fromHeight(tabBarHeight),
        child: AppBar(
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          title: GestureDetector(
            onTap: onClicked,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  dragIcon(),
                  const SizedBox(height: 12.0),
                  Text(
                    "Back",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
        ),
      );

  Widget dragIcon() => Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        width: 40,
        height: 8,
      );
}
