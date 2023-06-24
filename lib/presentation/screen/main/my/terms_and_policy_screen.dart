import 'package:bookand/core/app_strings.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/presentation/provider/terms_and_policy_provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widget/base_app_bar.dart';
import '../../../component/drawer_list_tile.dart';

class TermsAndPolicyScreen extends ConsumerStatefulWidget {
  static String get routeName => 'termsAndPolicyScreen';

  const TermsAndPolicyScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TermsAndPolicyScreen> createState() => _TermsAndPolicyScreenState();
}

class _TermsAndPolicyScreenState extends ConsumerState<TermsAndPolicyScreen> {
  late final policyList = ref.watch(termsAndPolicyProvider);
  late List<bool> isOpenList = List.generate(policyList.length, (_) => false);

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      appBar: const BaseAppBar(title: AppStrings.termsAndPolicy),
      child: SafeArea(
        child: Scrollbar(
          child: ListView.separated(
            physics: const ClampingScrollPhysics(),
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
                maxHeight: MediaQuery.of(context).size.height * 0.56,
                onTap: () {
                  setState(() {
                    isOpenList = isOpenList
                        .mapIndexed((i, e) => i == index ? !isOpenList[index] : false)
                        .toList();
                  });
                },
                isOpen: isOpenList[index],
                child: Markdown(
                  data: policyList[index].content,
                ),
              );
            },
            separatorBuilder: (_, __) => const Divider(
              height: 0,
              thickness: 2,
              color: Color(0xFFF5F5F7),
            ),
            itemCount: policyList.length,
          ),
        ),
      ),
    );
  }
}
