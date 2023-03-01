import 'package:bookand/domain/model/member/member_model.dart';
import 'package:bookand/presentation/component/profile_card.dart';
import 'package:bookand/presentation/provider/package_info_provider.dart';
import 'package:bookand/presentation/provider/member_provider.dart';
import 'package:bookand/presentation/provider/profile_provider.dart';
import 'package:bookand/presentation/screen/main/my/notification_setting_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widget/base_layout.dart';
import '../../../../core/util/logger.dart';
import '../../../component/menu_item.dart';

class MyScreen extends ConsumerWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileProvider = ref.watch(profileStateNotifierProvider.notifier);
    final member = ref.watch(memberStateNotifierProvider) as MemberModel;
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
              image: profileProvider.isImagePreviewMode()
                  ? Image.file(
                      profileCardState.previewImageFile!,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      imageUrl: member.profileImage ?? '',
                      errorWidget: (_, __, ___) => Container(color: Colors.grey),
                      fit: BoxFit.cover,
                    ),
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
            title: '계정관리',
            onTap: () {},
          ),
          MenuItem(
            leading: SvgPicture.asset(
              'assets/images/my/ic_notification.svg',
            ),
            title: '알림',
            onTap: () => ref.context.pushNamed(NotificationSettingScreen.routeName),
          ),
          MenuItem(
            leading: SvgPicture.asset(
              'assets/images/my/ic_notice.svg',
            ),
            title: '공지사항',
            onTap: () {},
          ),
          MenuItem(
            leading: SvgPicture.asset(
              'assets/images/my/ic_info.svg',
            ),
            title: '앱 버전정보',
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
                    logger.e('버전 정보를 가져오는 실패', e, stack);
                    return const SizedBox();
                  },
                  loading: () => const SizedBox(),
                ),
          ),
          MenuItem(
            leading: SvgPicture.asset(
              'assets/images/my/ic_policy.svg',
            ),
            title: '약관 및 정책',
            onTap: () {},
          ),
          MenuItem(
            leading: SvgPicture.asset(
              'assets/images/my/ic_bookstore.svg',
            ),
            title: '새로운 서점 제보',
            onTap: () {},
          ),
          MenuItem(
            leading: SvgPicture.asset(
              'assets/images/my/ic_feedback.svg',
            ),
            title: '피드백',
            onTap: () {},
          ),
        ],
      );
}
