import 'package:bookand/presentation/component/profile_card.dart';
import 'package:bookand/presentation/provider/package_info_provider.dart';
import 'package:bookand/presentation/provider/member_provider.dart';
import 'package:bookand/presentation/provider/profile_provider.dart';
import 'package:bookand/presentation/screen/main/my/account_management_screen.dart';
import 'package:bookand/presentation/screen/main/my/new_bookstore_report_screen.dart';
import 'package:bookand/presentation/screen/main/my/notice_screen.dart';
import 'package:bookand/presentation/screen/main/my/notification_setting_screen.dart';
import 'package:bookand/presentation/screen/main/my/terms_and_policy_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app_strings.dart';
import '../../../../core/widget/base_layout.dart';
import '../../../../core/util/logger.dart';
import '../../../component/menu_item.dart';
import 'feedback_screen.dart';

class MyScreen extends ConsumerWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileProvider = ref.watch(profileStateNotifierProvider.notifier);
    final member = ref.watch(memberStateNotifierProvider);
    final profileCardState = ref.watch(profileStateNotifierProvider);

    return BaseLayout(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28, bottom: 16, left: 16, right: 16),
            child: ProfileCard(
              isEditMode: profileCardState.editMode,
              nickname: profileProvider.isNicknamePreviewMode()
                  ? profileCardState.previewNickname!
                  : member.nickname,
              email: member.providerEmail,
              image: Builder(builder: (_) {
                if (profileProvider.isImagePreviewMode()) {
                  return Image.file(
                    profileCardState.previewImageFile!,
                    fit: BoxFit.cover,
                  );
                }

                return member.profileImage.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: member.profileImage,
                        errorWidget: (_, __, ___) => Container(color: Colors.grey),
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        profileCardState.previewImageFile!,
                        fit: BoxFit.cover,
                      );
              }),
              onTapEdit: profileProvider.editToggle,
              onTapReset: profileProvider.onTapReset,
              onTapComplete: profileProvider.onTapComplete,
              onTapImgUpdate: profileProvider.onTapImgUpdate,
              onTapChangeNickname: profileProvider.onTapChangeNickname,
            ),
          ),
          Expanded(
            child: _menuList(ref),
          ),
        ],
      ),
    );
  }

  Widget _menuList(WidgetRef ref) => ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          MenuItem(
            leading: SvgPicture.asset(
              'assets/images/my/ic_user.svg',
            ),
            title: AppStrings.accountManagement,
            onTap: () => ref.context.pushNamed(AccountManagementScreen.routeName),
          ),
          MenuItem(
            leading: SvgPicture.asset(
              'assets/images/my/ic_notification.svg',
            ),
            title: AppStrings.notification,
            onTap: () => ref.context.pushNamed(NotificationSettingScreen.routeName),
          ),
          MenuItem(
            leading: SvgPicture.asset(
              'assets/images/my/ic_notice.svg',
            ),
            title: AppStrings.notice,
            onTap: () => ref.context.pushNamed(NoticeScreen.routeName),
          ),
          MenuItem(
            leading: SvgPicture.asset(
              'assets/images/my/ic_info.svg',
            ),
            title: AppStrings.appVersionInfo,
            trailing: ref.watch(packageInfoProvider).when(
                  data: (packageInfo) => Text(
                    packageInfo.version,
                    style: const TextStyle(
                      color: Color(0xFFF86C30),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      letterSpacing: -0.02,
                    ),
                  ),
                  error: (e, stack) {
                    logger.e('버전 정보를 가져오는데 실패', e, stack);
                    return const SizedBox();
                  },
                  loading: () => const SizedBox(),
                ),
          ),
          MenuItem(
            leading: SvgPicture.asset(
              'assets/images/my/ic_policy.svg',
            ),
            title: AppStrings.termsAndPolicy,
            onTap: () => ref.context.pushNamed(TermsAndPolicyScreen.routeName),
          ),
          MenuItem(
            leading: SvgPicture.asset(
              'assets/images/my/ic_bookstore.svg',
            ),
            title: AppStrings.newBookstoreReport,
            onTap: () => ref.context.pushNamed(NewBookstoreReportScreen.routeName),
          ),
          MenuItem(
            leading: SvgPicture.asset(
              'assets/images/my/ic_feedback.svg',
            ),
            title: AppStrings.feedback,
            onTap: () => ref.context.pushNamed(FeedbackScreen.routeName),
          ),
        ],
      );
}
