import 'dart:math';

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

  static double degToRad(double degree) {
    return degree * pi / 180;
  }

  static double radToDeg(double radian) {
    return radian * 180 / pi;
  }
}
