import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final Function(bool value) onChanged;

  const CustomSwitch({Key? key, required this.value, required this.onChanged}) : super(key: key);

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  var milliseconds = 0;

  @override
  void initState() {
    /// 자연스러운 애니메이션을 위해 100ms 이후에 작동
    Future.delayed(const Duration(milliseconds: 100), () {
      milliseconds = 300;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: milliseconds),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(2),
        width: 44,
        height: 22,
        alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F7),
          borderRadius: BorderRadius.circular(11.5),
        ),
        child: Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: widget.value ? const Color(0xFFF86C30) : const Color(0xFFACACAC),
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
