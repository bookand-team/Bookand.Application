import 'dart:io';

import 'package:bookand/data/repository/member_repository_impl.dart';
import 'package:bookand/domain/usecase/get_random_nickname_use_case.dart';
import 'package:bookand/domain/usecase/update_member_profile_use_case.dart';
import 'package:bookand/presentation/provider/member_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/util/logger.dart';

part 'profile_provider.g.dart';

@riverpod
class ProfileStateNotifier extends _$ProfileStateNotifier {
  late final updateMemberProfileUseCase = ref.read(updateMemberProfileUseCaseProvider);
  late final memberRepository = ref.read(memberRepositoryProvider);

  @override
  ProfileCardState build() => ProfileCardState(editMode: false);

  void editToggle() {
    state = state.copyWith(editMode: !state.editMode);
  }

  void onTapComplete({required Function(String) onError}) async {
    try {
      await updateMemberProfileUseCase.updateMemberProfile(
          state.previewImageFile, state.previewNickname);
      state = ProfileCardState(editMode: false);
      ref.read(memberStateNotifierProvider.notifier).state = await memberRepository.getMe();
    } catch (e, stack) {
      logger.e('사용자 정보 업데이트 중 문제 발생', e, stack);
      onError('사용자 정보 수정 중 문제가 발생하였습니다.\n잠시 후 다시 시도해주세요.');
    }
  }

  void onTapImgUpdate() async {
    final picker = ImagePicker();
    final imageXFile = await picker.pickImage(source: ImageSource.gallery);
    final imageFilePath = imageXFile?.path;

    if (imageFilePath == null) return;

    final imageFile = File(imageFilePath);
    state = state.copyWith(previewImageFile: imageFile);
  }

  void onTapReset() {
    state = ProfileCardState(editMode: true);
  }

  void onTapChangeNickname() async {
    final nickname = await ref.watch(getRandomNicknameUseCaseProvider).getRandomNickname();
    state = state.copyWith(previewNickname: nickname);
  }

  bool isNicknamePreviewMode() {
    return state.editMode && state.previewNickname != null;
  }

  bool isImagePreviewMode() {
    return state.editMode && state.previewImageFile != null;
  }
}

class ProfileCardState {
  bool editMode;
  String? previewNickname;
  File? previewImageFile;

  ProfileCardState({required this.editMode, this.previewNickname, this.previewImageFile});

  ProfileCardState copyWith({
    bool? editMode,
    String? previewNickname,
    File? previewImageFile,
  }) {
    return ProfileCardState(
        editMode: editMode ?? this.editMode,
        previewNickname: previewNickname ?? this.previewNickname,
        previewImageFile: previewImageFile ?? this.previewImageFile);
  }
}
