import 'package:bookand/core/const/enum_boomark_marker_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../gen/assets.gen.dart';

class MarkerUtils {
  static final Widget _normalStore = SvgPicture.asset(
    Assets.images.map.bookstoreNormal,
    width: 28,
    height: 28,
  );
  static final Widget _bigStore = SvgPicture.asset(
    Assets.images.map.bookstoreBig,
    width: 36,
    height: 36,
  );

  static final Widget _hidestore =
      SvgPicture.asset(Assets.images.map.hidestore);

  static final Widget _bookmarkStore = SvgPicture.asset(
    Assets.images.map.bookmarkActive,
    width: 28,
    height: 28,
  );

  static final Widget _bookmarkStoreBig = SvgPicture.asset(
    Assets.images.map.bookmarkActive,
    width: 36,
    height: 36,
  );

  static Future<BitmapDescriptor> createIconData(
      String label, BookStoreMarkerType type) async {
    late BitmapDescriptor body;
    switch (type) {
      case BookStoreMarkerType.basic:
        body = await _createNormalBody(label).toBitmapDescriptor();
        break;
      case BookStoreMarkerType.big:
        body = await _createBigBody(label).toBitmapDescriptor();
        break;
      case BookStoreMarkerType.bookmark:
        body = await _createBookmarkedBody(label).toBitmapDescriptor();
        break;
      case BookStoreMarkerType.bookmarkBig:
        body = await _createBookmarkedBigBody(label).toBitmapDescriptor();
        break;
      case BookStoreMarkerType.hideRecommend:
        body = await _createHidestoreBody(label).toBitmapDescriptor();
        break;
      default:
        body = await _createNormalBody(label).toBitmapDescriptor();
    }
    return body;
  }

  static Widget _createMarkerText(String data, [bool bigStore = false]) {
    Radius br = const Radius.circular(5);
    EdgeInsets padding = const EdgeInsets.symmetric(vertical: 1, horizontal: 2);
    Color color = Colors.white;
    return Container(
      padding: padding,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.all(br)),
      child: Text(
        data,
        style: bigStore
            ? const TextStyle(
                color: Color(0xFF222222),
                fontSize: 15,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w700,
                letterSpacing: -0.30,
              )
            : const TextStyle(
                color: Color(0xFF222222),
                fontSize: 13,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w700,
                letterSpacing: -0.26,
              ),
      ),
    );
  }

  static Widget _createHidestoreBody(String data) {
    return SizedBox(
      height: 70,
      child: Column(
        children: [_hidestore, _createMarkerText(data, true)],
      ),
    );
  }

  static Widget _createBigBody(String data) {
    return SizedBox(
      height: 70,
      child: Column(
        children: [_bigStore, _createMarkerText(data, true)],
      ),
    );
  }

  static Widget _createNormalBody(String data) {
    return SizedBox(
      height: 60,
      child: Column(
        children: [_normalStore, _createMarkerText(data)],
      ),
    );
  }

  static Widget _createBookmarkedBody(String data) {
    return SizedBox(
      height: 60,
      child: Column(
        children: [_bookmarkStore, _createMarkerText(data)],
      ),
    );
  }

  static Widget _createBookmarkedBigBody(String data) {
    return SizedBox(
      height: 70,
      child: Column(
        children: [_bookmarkStoreBig, _createMarkerText(data, true)],
      ),
    );
  }
}
