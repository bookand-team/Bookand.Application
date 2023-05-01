import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestBody extends ConsumerStatefulWidget {
  final PreferredSizeWidget appBar;
  final Widget body;
  final List<Widget> panelBody;
  final double maxHeight;
  final double minHeight;
  final double? dismissDeadLine;
  final double? topDeadLine;
  const TestBody(
      {Key? key,
      required this.appBar,
      required this.body,
      required this.panelBody,
      required this.maxHeight,
      required this.minHeight,
      this.dismissDeadLine,
      this.topDeadLine})
      : super(key: key);

  @override
  _TestBodyState createState() => _TestBodyState();
}

class _TestBodyState extends ConsumerState<TestBody> {
  //deadline 만드는 건 20%이내
  double heightFactor = 0.2;

  // 최대(펼쳤을 떄 스크롤 가능)
  late double maxHeight;
  //max에서 min 갈려면 여기 넘어야함 아니면 돌아옴
  late double max2MinDeadLine;
  //min에서 max 갈려면 여기 넘어야함 아니면 돌아옴
  late double min2MaxDeadLine;
  // 최소(처음유지하는 높이)
  late double minHeight;
  // min에서 dismiss하려면 여기 넘어야함 아니면 돌아옴
  late double min2DismissDeadLine;
  // 바뀌는 거 감지하고 바뀌는 높이
  late double height;

  //animation

  //기본duration
  Duration normalDur = const Duration();
  Duration aniDur = Duration(milliseconds: 300);
  // ani 속도 통일
  double aniVelocity = 200;

  //바뀌며 쓰일 duration
  late Duration duration;

  ScrollController childScrollCon = ScrollController();

  //animation
  double dragVelocity = 0.0;
  double dragDistance = 0;

  DateTime? dragStartTime;
  DateTime? dragEndTime;

  bool childScrollIsTop = false;
  bool childCanScroll = false;

  AxisDirection? direction;
  //방향계산용
  double startHeight = 0;
  double endHeight = 0;

  @override
  void initState() {
    maxHeight = widget.maxHeight;
    max2MinDeadLine = maxHeight * (1 - heightFactor);
    minHeight = widget.minHeight;
    min2MaxDeadLine = minHeight * (1 + heightFactor);
    min2DismissDeadLine = minHeight * (1 - heightFactor);

    height = minHeight;

    duration = normalDur;

    super.initState();
  }

  Size? childSize;

  //to maxheight
  void open() {
    setState(() {
      height = maxHeight;
    });
  }

  // to minheight
  void close() {
    setState(() {
      height = minHeight;
    });
  }

  //duration 조정 후, 제거(tree에는 남아있고, 사라지기만)
  void dismiss() {
    duration = Duration(milliseconds: (height / aniVelocity).floor());
    setState(() {
      height = 0;
    });
    // duration 정상화
    duration = normalDur;
  }

  void toMax() {
    int ms = ((maxHeight - height) / aniVelocity).floor();
    duration = Duration(milliseconds: ms > 0 ? ms : 0);
    setState(() {
      height = maxHeight;
    });
    // duration 정상화
    duration = normalDur;
    childCanScroll = true;
    log('to top');
  }

  void toMin() {
    int ms = ((height - minHeight) / aniVelocity).floor();
    duration = Duration(milliseconds: ms > 0 ? ms : 0);
    setState(() {
      height = minHeight;
    });
    duration = normalDur;
    childCanScroll = false;
    log('to min');
  }

  bool isOpen() {
    return height == maxHeight;
  }

  bool isClose() {
    return height == minHeight;
  }

  void updateHeightDelta(double delta) {
    if (isOpen()) {
      if (height + delta < maxHeight) {
        setState(() {
          height += delta;
        });
      }
    } else {
      if (height + delta < maxHeight) {
        setState(() {
          height += delta;
        });
      } else if (height + delta > maxHeight) {
        setState(() {
          height = maxHeight;
        });
      }
    }
  }

  bool checked = false;
  void checkChildCanScroll() {
    // if(isOpen()&&){

    // }
  }

  ///변수초기화
  void onPanStart() {
    // dragVelocity = 0;
    // dragDistance = 0;
    // dragStartTime = DateTime.now();
    startHeight = 0;
    endHeight = 0;
    startHeight = height;
  }

  /// 드래그 거리 계산
  void onPanUpdate(DragUpdateDetails details) {
    // dragDistance += details.delta.distance;
  }

  /// 드래그 종료 시 속도 계산 offset/ms
  void onPanEnd(DragEndDetails details) {
    endHeight = height - startHeight;
    if (endHeight > 0) {
      direction = AxisDirection.up;
    } else {
      direction = AxisDirection.down;
    }
    // dragEndTime = DateTime.now();
    // dragVelocity =
    //     dragDistance / dragEndTime!.difference(dragStartTime!).inMilliseconds;

    // max -> min   안되고 돌아옴
    if (max2MinDeadLine < height && height < maxHeight) {
      toMax();
    }
    // min -> max or max->min
    else if (min2MaxDeadLine < height && height < max2MinDeadLine) {
      if (direction == AxisDirection.down) {
        toMin();
      } else {
        toMax();
      }
    }
    // min -> max 안되고 돌아옴
    else if (minHeight < height && height < min2MaxDeadLine) {
      toMin();
    }
    // dismiss 체크
    else if (height < minHeight) {
      if (direction == AxisDirection.down) {
        dismiss();
      } else {
        toMin();
      }
    }
  }

  /// dismiss나 toTop 애니메이션 할 때 마지막 드래그 속도 기반 duration계산 단위 ms
  Duration getAniDuration(double velocity, double height) {
    return Duration(milliseconds: (height / velocity).floor());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app bar
      appBar: widget.appBar,
      body: Stack(
        children: [
          //body
          Align(
            alignment: Alignment.bottomCenter,
            child: widget.body,
          ),
          //panel
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              constraints: BoxConstraints(maxHeight: maxHeight),
              // duration: duration,
              width: 200,
              color: Colors.black12,
              height: height,
              child: Listener(
                  onPointerMove: (event) {
                    if (!childCanScroll) {
                      updateHeightDelta(-event.delta.dy);
                      //열리고 위로 드래그
                      if (isOpen() && event.delta.direction < 0) {
                        log('test');
                        childCanScroll = true;
                      }
                    } else {
                      if (isOpen() &&
                          event.delta.direction > 0 &&
                          childScrollCon.offset == 0) {
                        SchedulerBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          Timer(timeStamp, () {
                            childCanScroll = false;
                          });
                        });
                      }
                    }
                  },
                  child: ListView.builder(
                    // physics:
                    //     childCanScroll ? null : NeverScrollableScrollPhysics(),
                    controller: childScrollCon,
                    itemCount: widget.panelBody.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: widget.panelBody,
                      );
                    },
                  )

                  // SingleChildScrollView(

                  //   controller: childScrollCon,
                  //   physics:
                  //       childCanScroll ? null : NeverScrollableScrollPhysics(),
                  //   child: Column(
                  //     children: widget.panelBody,
                  //   ),
                  // ),
                  ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: TextButton(onPressed: close, child: Text('close')),
          ),
        ],
      ),
    );
  }
}
