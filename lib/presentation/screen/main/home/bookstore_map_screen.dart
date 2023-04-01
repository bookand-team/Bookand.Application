import 'package:bookand/core/widget/base_app_bar.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookstoreMapScreen extends StatelessWidget {
  static String get routeName => 'bookstoreMap';
  final String latitude;
  final String longitude;

  const BookstoreMapScreen({Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      appBar: const BaseAppBar(),
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            double.parse(latitude),
            double.parse(longitude),
          ),
          zoom: 16,
        ),
        zoomControlsEnabled: false,
      ),
    );
  }
}
