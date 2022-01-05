import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatelessWidget {
  const GoogleMapPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(35.07396943121907, -89.93218569969048),
          zoom: 15,
        ),
      ),
    );
  }
}
