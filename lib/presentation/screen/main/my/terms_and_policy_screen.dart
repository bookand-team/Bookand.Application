import 'package:bookand/core/app_strings.dart';
import 'package:bookand/core/const/hive_key.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/widget/base_app_bar.dart';
import '../../../../domain/model/policy_model.dart';
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
      child: ValueListenableBuilder(
          valueListenable: Hive.box(HiveKey.policyBoxKey).listenable(),
          builder: (_, Box box, __) {
            final List<PolicyModel> policyList = box.get(HiveKey.policyKey);

            return Scrollbar(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return DrawerListTile(
                    title: Text(
                      policyList[index].title,
                      style: const TextStyle(
                        color: Color(0xFF222222),
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        letterSpacing: -0.02,
                      ),
                    ),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    drawerBackground: const Color(0xFFF5F5F7),
                    child: Markdown(data: policyList[index].content),
                  );
                },
                separatorBuilder: (_, __) => const Divider(
                  height: 0,
                  thickness: 2,
                  color: Color(0xFFF5F5F7),
                ),
                itemCount: policyList.length,
              ),
            );
          }),
    );
  }
}
