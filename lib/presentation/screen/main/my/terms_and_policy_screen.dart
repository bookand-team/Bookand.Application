import 'package:bookand/core/app_strings.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/widget/base_app_bar.dart';
import '../../../component/drawer_list_tile.dart';

class TermsAndPolicyScreen extends StatefulWidget {
  static String get routeName => 'termsAndPolicyScreen';

  const TermsAndPolicyScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndPolicyScreen> createState() => _TermsAndPolicyScreenState();
}

class _TermsAndPolicyScreenState extends State<TermsAndPolicyScreen> {
  final tempList = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      appBar: const BaseAppBar(title: AppStrings.termsAndPolicy),
      child: Scrollbar(
        child: ListView.separated(
          itemBuilder: (context, index) {
            return DrawerListTile(
              value: tempList[index],
              onChanged: (value) {
                setState(() {
                  tempList[index] = value;
                });
              },
              title: const Text(
                '가나다라마바사아자차카타파하',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  letterSpacing: -0.02,
                ),
              ),
              trailing: SvgPicture.asset(
                tempList[index]
                    ? 'assets/images/my/ic_drawer_close.svg'
                    : 'assets/images/my/ic_drawer_open.svg',
              ),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              maxHeight: MediaQuery.of(context).size.height * 0.56,
              drawerBackground: const Color(0xFFF5F5F7),
              child: const Markdown(
                data:
                    '가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하',
              ),
            );
          },
          separatorBuilder: (_, __) => const Divider(
            height: 0,
            thickness: 2,
            color: Color(0xFFF5F5F7),
          ),
          itemCount: tempList.length,
        ),
      ),
    );
  }
}
