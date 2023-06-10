import 'dart:math';

import 'logger.dart';

class CommonUtil {
  static double getDistance({
    required double lat1,
    required double lon1,
    required double lat2,
    required double lon2,
  }) {
    final theta = lon1 - lon2;
    var dist = sin(degToRad(lat1)) * sin(degToRad(lat2)) +
        cos(degToRad(lat1)) * cos(degToRad(lat2)) * cos(degToRad(theta));

    dist = acos(dist);
    dist = radToDeg(dist);
    dist *= 60 * 1.1515;
    dist *= 1609.344;

    return dist;
  }

  static bool coordInRect({
    required double targetLat,
    required double targetLon,
    required double minLat,
    required double minLon,
    required double maxLat,
    required double maxLon,
  }) {
    if (targetLat >= minLat &&
        targetLat <= maxLat &&
        targetLon >= minLon &&
        targetLon <= maxLon) {
      return true;
    } else {
      return false;
    }
  }

  static double degToRad(double degree) {
    return degree * pi / 180;
  }

  static double radToDeg(double radian) {
    return radian * 180 / pi;
  }

  static bool checkRequiredUpdate(String appVersion, String serverVersion) {
    final splitAppVersion = appVersion.trim().split('.');
    final splitServerVersion = serverVersion.trim().split('.');

    if (splitAppVersion.length != 3 || splitServerVersion.length != 3) {
      return false;
    }

    try {
      for (var i = 0; i < 3; i++) {
        final app = int.parse(splitAppVersion[i]);
        final server = int.parse(splitServerVersion[i]);

        if (app < server) {
          return true;
        } else if (app > server) {
          return false;
        }
      }

      return false;
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  static String distance2TypedStr(double distance) {
    String type = 'm';
    int data = distance.floor();
    if (distance >= 1000) {
      type = 'km';
      data = distance ~/ 1000;
    }
    return '$data$type';
  }
}
