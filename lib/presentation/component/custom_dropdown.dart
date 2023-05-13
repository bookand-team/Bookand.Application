import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String? hint;
  final ValueChanged<T?>? onChanged;

  const CustomDropdown({
    Key? key,
    required this.items,
    this.value,
    this.hint,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  bool isOpenDropdown = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<T>(
      value: widget.value,
      hint: widget.hint == null
          ? null
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                widget.hint ?? '',
                style: const TextStyle(
                  color: Color(0xFFACACAC),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  letterSpacing: -0.02,
                ),
              ),
            ),
      items: addDividerAfterItems(),
      onChanged: widget.onChanged,
      onMenuStateChange: (value) {
        setState(() {
          isOpenDropdown = value;
        });
      },
      underline: const SizedBox(),
      buttonStyleData: ButtonStyleData(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF222222)),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(8),
            topRight: const Radius.circular(8),
            bottomLeft: Radius.circular(isOpenDropdown ? 0 : 8),
            bottomRight: Radius.circular(isOpenDropdown ? 0 : 8),
          ),
        ),
      ),
      iconStyleData: IconStyleData(
        icon: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: SvgPicture.asset(
            'assets/images/my/ic_drawer_open.svg',
          ),
        ),
        openMenuIcon: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: SvgPicture.asset(
            'assets/images/my/ic_drawer_close.svg',
          ),
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        width: MediaQuery.of(context).size.width - 32,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF222222)),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        elevation: 0,
      ),
      menuItemStyleData: MenuItemStyleData(
        customHeights: List.generate(
          addDividerAfterItems().length,
          (index) => index % 2 == 0 ? 46.0 : 0.0,
        ),
        padding: EdgeInsets.zero,
      ),
    );
  }

  List<DropdownMenuItem<T>> addDividerAfterItems() {
    List<DropdownMenuItem<T>> menuItems = [];
    for (var item in widget.items) {
      menuItems.addAll([
        item,
        if (item != widget.items.last)
          const DropdownMenuItem(
            enabled: false,
            child: Divider(
              height: 0,
              color: Color(0xFF222222),
            ),
          )
      ]);
    }
    return menuItems;
  }
}
