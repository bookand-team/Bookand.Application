import 'package:bookand/core/widget/base_app_bar.dart';
import 'package:bookand/core/widget/base_dialog.dart';
import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/presentation/provider/auth_provider.dart';
import 'package:bookand/presentation/provider/member_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/app_strings.dart';
import '../../../../core/const/auth_state.dart';

class AccountManagementScreen extends ConsumerWidget {
  static String get routeName => 'accountManagementScreen';

  const AccountManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final member = ref.watch(memberStateNotifierProvider);
    final authState = ref.watch(authStateNotifierProvider);

    return BaseLayout(
      isLoading: authState == AuthState.loading,
      ignoring: authState == AuthState.loading,
      appBar: const BaseAppBar(
        title: AppStrings.accountManagement,
      ),
      child: Column(
        children: [
          ListTile(
            title: const Text(
              '닉네임',
              style: TextStyle(
                color: Color(0xFF222222),
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: -0.02,
              ),
            ),
            trailing: Text(
              member.nickname,
              style: const TextStyle(
                color: Color(0xFF222222),
                fontWeight: FontWeight.w500,
                fontSize: 15,
                letterSpacing: -0.02,
              ),
            ),
          ),
          ListTile(
            title: const Text(
              '로그인 정보',
              style: TextStyle(
                color: Color(0xFF222222),
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: -0.02,
              ),
            ),
            trailing: Text(
              member.providerType.name,
              style: const TextStyle(
                color: Color(0xFF222222),
                fontWeight: FontWeight.w500,
                fontSize: 15,
                letterSpacing: -0.02,
              ),
            ),
          ),
          ListTile(
            title: const Text(
              '로그인 ID',
              style: TextStyle(
                color: Color(0xFF222222),
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: -0.02,
              ),
            ),
            trailing: Text(
              member.providerEmail,
              style: const TextStyle(
                color: Color(0xFF222222),
                fontWeight: FontWeight.w500,
                fontSize: 15,
                letterSpacing: -0.02,
              ),
            ),
          ),
          const Divider(
            thickness: 8,
            color: Color(0xFFF5F5F5),
          ),
          ListTile(
            title: const Text(
              '로그아웃',
              style: TextStyle(
                color: Color(0xFF222222),
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: -0.02,
              ),
            ),
            onTap: () => showLogoutDialog(ref),
          ),
          ListTile(
            title: const Text(
              '계정 삭제',
              style: TextStyle(
                color: Color(0xFFACACAC),
                fontWeight: FontWeight.w400,
                fontSize: 16,
                letterSpacing: -0.02,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  void showLogoutDialog(WidgetRef ref) => showDialog(
        context: ref.context,
        builder: (_) => BaseDialog(
          isTwoBtn: true,
          negativeBtnText: '취소',
          onTapPositiveBtn: () {
            ref.watch(memberStateNotifierProvider.notifier).logout();
          },
          content: Column(
            children: const [
              Text(
                '로그아웃',
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  letterSpacing: -0.02,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '로그아웃 하시겠습니까?',
                style: TextStyle(
                  color: Color(0xFFACACAC),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  letterSpacing: -0.02,
                ),
              ),
            ],
          ),
        ),
      );
}
