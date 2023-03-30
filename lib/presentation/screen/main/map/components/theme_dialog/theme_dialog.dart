import 'package:bookand/core/widget/slide_icon.dart';
import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';

class ThemeDialog extends StatefulWidget {
  const ThemeDialog({Key? key}) : super(key: key);

  @override
  _ThemeDialogState createState() => _ThemeDialogState();
}

class _ThemeDialogState extends State<ThemeDialog> {
  final EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 15);
  final Radius bRaidus = const Radius.circular(24);
  final Radius chipBRaidus = const Radius.circular(4);

  //장비에 따라 달라질 수 있음. 디자이너나 기획자한테 말해서 동적인건지 정적인건지 알아내야함
  final double wrapSpacing = 15;
  final double wrapVerticalSpacing = 10;

  final Size chipSize = const Size(70, 30);
  final Size buttonSize = const Size(1000, 44);
  final double iconSize = 14;

  final chipColor = const Color(0xfff5f5f7);
  final refreshColor = const Color(0xff565656);
  final buttonColor = const Color(0xffdddddd);
  final selectedColor = const Color(0xff222222);

  final titleStyle = const TextStyle(fontSize: 18, color: Color(0xff222222));
  final refreshStyle = const TextStyle(fontSize: 12, color: Color(0xff565656));
  final chipStyle = const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xffacacac));
  final buttonStyle = const TextStyle(
      fontSize: 15, fontWeight: FontWeight.w400, color: Color(0xffacacac));

  final buttonRaidus = const Radius.circular(8);

  final List<String> options = const [
    '여행',
    '음악',
    '그림',
    '애완동물',
    '영화',
    '추리',
    '역사'
  ];
  List<int> selected = [];

  @override
  Widget build(BuildContext context) {
    bool isSelected = selected.isNotEmpty;
    Size screenSize = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: bRaidus, topRight: bRaidus, bottomLeft: Radius.zero)),
      insetPadding: EdgeInsets.zero,
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: padding,
        width: 1000,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            slideIcon,
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '테마',
                  style: titleStyle,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.refresh,
                      color: refreshColor,
                      size: iconSize,
                    ),
                    Text(
                      '초기화',
                      style: refreshStyle,
                    )
                  ],
                )
              ],
            ),

            const SizedBox(
              height: 20,
            ),
            //options 초이스 칩
            SizedBox(
              width: screenSize.width,
              child: Wrap(
                spacing: wrapSpacing,
                runSpacing: wrapVerticalSpacing,
                children: List.generate(
                    options.length,
                    (index) => SizedBox(
                          // margin: EdgeInsets.only(
                          // right: ((index + 1) % 4 == 0) ? 0 : 5),
                          width: chipSize.width,
                          height: chipSize.height,
                          child: FilterChip(
                            showCheckmark: false,
                            padding: EdgeInsets.zero,
                            backgroundColor: chipColor,
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(chipBRaidus)),
                            selectedColor: selectedColor,
                            selected: selected.contains(index),
                            labelStyle: chipStyle.copyWith(
                                color: selected.contains(index)
                                    ? Colors.white
                                    : null),
                            label: Center(
                              child: Text(
                                options[index],
                              ),
                            ),
                            onSelected: (value) {
                              setState(() {
                                value
                                    ? selected.add(index)
                                    : selected.remove(index);
                              });
                            },
                          ),
                        )),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            //적용 버튼
            GestureDetector(
              onTap: () {},
              child: Container(
                width: buttonSize.width,
                height: buttonSize.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(buttonRaidus),
                    color: isSelected ? selectedColor : buttonColor),
                child: Center(
                    child: Text(
                  '적용',
                  style: buttonStyle.copyWith(
                      color: isSelected ? Colors.white : null),
                )),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
