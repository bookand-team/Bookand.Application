import 'package:bookand/core/widget/base_app_bar.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/presentation/utils/marker_util.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookstoreMapScreen extends StatefulWidget {
  static String get routeName => 'bookstoreMap';
  final String id;
  final String name;
  final String latitude;
  final String longitude;

  const BookstoreMapScreen(
      {Key? key,
      required this.id,
      required this.name,
      required this.latitude,
      required this.longitude})
      : super(key: key);

  @override
  State<BookstoreMapScreen> createState() => _BookstoreMapScreenState();
}

class _BookstoreMapScreenState extends State<BookstoreMapScreen> {
  List<Marker> markers = [];

  @override
  void initState() {
    createMarker(
            id: widget.id,
            label: widget.name,
            latitude: double.parse(widget.latitude),
            longitude: double.parse(widget.longitude))
        .then((marker) {
      setState(() {
        markers = [marker];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      appBar: const BaseAppBar(),
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            double.parse(widget.latitude),
            double.parse(widget.longitude),
          ),
          zoom: 16,
        ),
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        markers: markers.toSet(),
      ),
    );
  }
}
