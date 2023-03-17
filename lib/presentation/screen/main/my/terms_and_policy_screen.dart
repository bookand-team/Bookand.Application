import 'package:bookand/core/app_strings.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/presentation/provider/terms_and_policy_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widget/base_app_bar.dart';

class TermsAndPolicyScreen extends ConsumerWidget {
  static String get routeName => 'termsAndPolicyScreen';

  const TermsAndPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final policyList = ref.watch(termsAndPolicyProvider);

    return BaseLayout(
      appBar: const BaseAppBar(title: AppStrings.termsAndPolicy),
      child: Scrollbar(
        child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                policyList[index].title,
                style: const TextStyle(
                  color: Color(0xFF222222),
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  letterSpacing: -0.02,
                ),
              ),
              onTap: () {

              },
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
    );
  }
}
