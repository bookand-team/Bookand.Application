import 'package:bookand/core/app_strings.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../../../core/widget/base_app_bar.dart';
import '../../../component/drawer_list_tile.dart';

class TermsAndPolicyScreen extends StatefulWidget {
  static String get routeName => 'termsAndPolicyScreen';

  const TermsAndPolicyScreen({Key? key}) : super(key: key);

  @override
  State<TermsAndPolicyScreen> createState() => _TermsAndPolicyScreenState();
}

class _TermsAndPolicyScreenState extends State<TermsAndPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      appBar: const BaseAppBar(title: AppStrings.termsAndPolicy),
      child: Scrollbar(
        child: ListView.separated(
          itemBuilder: (context, index) {
            return const DrawerListTile(
              title: Text(
                '가나다라마바사아자차카타파하',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  letterSpacing: -0.02,
                ),
              ),
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              drawerBackground: Color(0xFFF5F5F7),
              child: Markdown(
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
          itemCount: 5,
        ),
      ),
    );
  }
}
