import 'package:bookand/core/util/common_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('1km 이내에 있는 장소 구하기 테스트', () {
    final currentLocation = Location(37.554451841348516, 126.97082429649981, "서울역");
    final locationList = [
      Location(37.54047297179801, 126.97134458004501, "남영역"),
      Location(37.54410181715197, 126.95100336436153, "공덕역"),
      Location(37.564796682080704, 126.97715876242063, "시청역"),
      Location(37.39503256391748, 127.11114738706654, "판교역"),
      Location(36.81117608924655, 127.14598013258748, "천안역"),
      Location(37.88519978887186, 127.71690531861549, "춘천역"),
      Location(37.47656168148877, 126.61609098318361, "인천역"),
      Location(37.88844429534917, 126.74701421451313, "임진강역"),
      Location(37.558147422068565, 126.97765877299251, "회현역"),
      Location(37.55137344161844, 126.98818534448591, "남산타워"),
      Location(37.559297159676454, 126.96346576083825, "충정로역"),
      Location(37.545153812075256, 126.97195949842808, "숙대입구역"),
      Location(37.55999399228521, 126.97528143674715, "숭례문"),
    ];

    final in1KmLocationList = locationList.where((e) {
      final distance = CommonUtil.getDistance(
          lat1: currentLocation.latitude,
          lon1: currentLocation.longitude,
          lat2: e.latitude,
          lon2: e.longitude);
      print('${currentLocation.name}에서 ${e.name}까지의 거리 : ${distance.round()}m');
      return distance <= 1000;
    }).toList();

    print('${currentLocation.name} 반경 1km 이내에 있는 지역 : ${in1KmLocationList.map((e) => e.name).toList()}');
    
    expect(in1KmLocationList.map((e) => e.name).toList(), ['회현역', '충정로역', '숭례문']);
  });

  test('버전 체크 테스트', () {
    expect(CommonUtil.checkRequiredUpdate('1.0.0', '0.0.1'), false);
    expect(CommonUtil.checkRequiredUpdate('1.0.0', '1.0.1'), true);
    expect(CommonUtil.checkRequiredUpdate('1.0.0', '1.1.1'), true);
    expect(CommonUtil.checkRequiredUpdate('1.0.0', '1.10.1'), true);
    expect(CommonUtil.checkRequiredUpdate('1.0.0', '0.0.10'), false);
    expect(CommonUtil.checkRequiredUpdate('1.0.0', '0.10.1'), false);
    expect(CommonUtil.checkRequiredUpdate('1.0.0', '0.10.0'), false);
    expect(CommonUtil.checkRequiredUpdate('1.0.0', '3.0.0'), true);
    expect(CommonUtil.checkRequiredUpdate('1.0.0', '1.0.0'), false);
    expect(CommonUtil.checkRequiredUpdate('1.0.0', '1.0.10'), true);
    expect(CommonUtil.checkRequiredUpdate('1.0.0', ''), false);
    expect(CommonUtil.checkRequiredUpdate('1.0.0', 'test'), false);
    expect(CommonUtil.checkRequiredUpdate('1.0.0', '    '), false);
    expect(CommonUtil.checkRequiredUpdate('1.0.0', '12.32.14.43'), false);
    expect(CommonUtil.checkRequiredUpdate('1.0.0', '1.0.10    '), true);
    expect(CommonUtil.checkRequiredUpdate('1.0.0', '    1.0.10'), true);
  });
}

class Location {
  final double latitude;
  final double longitude;
  final String name;

  Location(this.latitude, this.longitude, this.name);
}
