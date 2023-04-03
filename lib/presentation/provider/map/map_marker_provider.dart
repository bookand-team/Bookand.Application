// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// import 'package:bookand/core/const/asset_path.dart';

// part 'map_marker_provider.g.dart';

// class TestObj {
//   String name;
//   int type;
//   double lat;
//   double lng;
//   TestObj(
//       {required this.name,
//       required this.type,
//       required this.lat,
//       required this.lng});
// }

// @Riverpod()
// class MapMarkerNotifer extends _$MapMarkerNotifer {
//   @override
//   Set<Marker> build() {
//     assetToUnit8List(mapBasicMarkerPath).then((value) => {basicIcon = value});
//     assetToUnit8List(bookmarkActivatePath)
//         .then((value) => {bookmarkIcon = value});
//     assetToUnit8List(mapHideMarkerPath).then((value) => {hideIcon = value});
//     return {};
//   }

//   late Uint8List basicIcon;
//   late Uint8List bookmarkIcon;
//   late Uint8List hideIcon;

//   //초기 위치
//   static const initPosition = LatLng(37.5665, 126.9780);
//   //marker

//   Future<Uint8List> assetToUnit8List(String assetPath) async {
//     ByteData byteData = await rootBundle.load(assetPath);
//     Uint8List uint8list = byteData.buffer.asUint8List();
//     return uint8list;
//   }

//   Marker makeMarker(
//       {required String id,
//       required Uint8List data,
//       required double lat,
//       required double lng}) {
//     return Marker(
//         markerId: MarkerId(id),
//         icon: BitmapDescriptor.fromBytes(data),
//         position: LatLng(lat, lng));
//   }

//   void setMarkers(Set<Marker> markers) {
//     state = markers;
//   }

//   void setTestMakrers(List<TestObj> objs) {
//     Set<Marker> markers = {};

//     objs.forEach((element) {
//       Uint8List iconData;

//       //basick
//       if (element.type == 0) {
//         iconData = basicIcon;
//       }
//       //bookmark
//       else if (element.type == 1) {
//         iconData = bookmarkIcon;
//       }
//       // hide
//       else if (element.type == 2) {
//         iconData = hideIcon;
//       } else {
//         iconData = basicIcon;
//       }
//       Marker marker = makeMarker(
//           id: element.name, data: iconData, lat: element.lat, lng: element.lng);
//       markers.add(marker);
//     });
//     state = markers;
//   }

//   void initMarkers() {
//     state = <Marker>{};
//   }
//   // static String userMarkerId = 'user';
//   // Marker userMarker =
//   //     Marker(markerId: MarkerId(userMarkerId), position: initPosition);

//   // void toggleUserMarker() {
//   //   if (state.contains(userMarker)) {
//   //     state = Set.from(state..remove(userMarker));
//   //   } else {
//   //     state = Set.from(state..add(userMarker));
//   //   }
//   // }

//   // void updateUserMarkerPos({required double lat, required double lng}) {
//   //   if (state.contains(userMarker)) {
//   //     state = Set.from(state.map((e) {
//   //       if (e.markerId.value == userMarkerId) {
//   //         return e.copyWith(positionParam: LatLng(lat, lng));
//   //       }
//   //       return e;
//   //     }));
//   //   }
//   // }
// }
