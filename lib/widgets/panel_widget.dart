import 'package:emilios_market/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PanelWidget extends StatelessWidget {
  final PanelController panelController;
  final ScrollController scrollController;
  final double tabBarHeight = 60.0;

  const PanelWidget({
    Key key,
    @required this.panelController,
    @required this.scrollController,
  }) : super(key: key);

  @override
  //PROBLEM PANEL HERE
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: tabBar(
        onClicked: panelController.open,
      ),
      body: BottomNav(),
    );
  }

  Widget tabBar({
    @required VoidCallback onClicked,
  }) =>
      PreferredSize(
        preferredSize: Size.fromHeight(tabBarHeight - 8.0),
        child: GestureDetector(
          onTap: onClicked,
          child: AppBar(
            title: dragIcon(), // Icon(Icons.drag_handle),
            centerTitle: true,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
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
