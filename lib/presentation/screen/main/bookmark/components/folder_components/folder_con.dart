import 'package:flutter/material.dart';

//폴더의 이미지, 이름 출력하고, 탭하면 접근하는 위젯
class FolderCon extends StatelessWidget {
  final dynamic data;
  const FolderCon({Key? key, required this.data}) : super(key: key);

  final Radius br = const Radius.circular(4);
  final double strokeWidth = 1;

  final Size conSize = const Size(80, 80);

  final TextStyle titleStyle = const TextStyle(fontSize: 10);
  final Color grey = const Color(0xff999999);
  @override
  Widget build(BuildContext context) {
    String title = data.title;
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
          width: conSize.width,
          height: conSize.height,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(br),
                child: Image.network(
                  '',
                  width: conSize.width,
                  height: conSize.height,
                ),
              ),
              Align(
                alignment: const Alignment(0, -0.5),
                child: Text(
                  title,
                  style: titleStyle.copyWith(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              )
            ],
          )),
    );
  }
}
