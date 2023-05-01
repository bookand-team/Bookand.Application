import 'package:bookand/core/const/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'test_body.dart';

class Testbottomsheetadd extends ConsumerStatefulWidget {
  const Testbottomsheetadd({Key? key}) : super(key: key);

  @override
  _TestbottomsheetState createState() => _TestbottomsheetState();
}

class _TestbottomsheetState extends ConsumerState<Testbottomsheetadd> {
  //몇 초 안에 드래그 해서 저기까지 아래로 이동했으면animate로 height 0으로 만들고 없애버리기
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TestBody(
            maxHeight: 600,
            // maxHeight: MediaQuery.of(context).size.height,
            minHeight: 300,
            appBar: TestBar(),
            body: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(SEOUL_COORD_LAT, SEOUL_COORD_LON),
                    zoom: 13)),
            panelBody: [
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
              Text('test'),
            ]),
      ),
    );
  }
}

class TestBar extends StatelessWidget implements PreferredSizeWidget {
  const TestBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      color: Colors.amber.shade200,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(200, 50);
}
