import 'dart:io';

import 'package:bookand/domain/usecase/get_random_nickname_use_case.dart';
import 'package:bookand/domain/usecase/update_member_profile_use_case.dart';
import 'package:bookand/presentation/provider/member_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_provider.g.dart';

@riverpod
class ProfileStateNotifier extends _$ProfileStateNotifier {
  @override
  ProfileCardState build() => ProfileCardState(editMode: false);

  void editToggle() {
    state = state.copyWith(editMode: !state.editMode);
  }

  void onTapComplete() async {
    final memberModel = await ref
        .read(updateMemberProfileUseCaseProvider)
        .updateMemberProfile(state.previewImageFile, state.previewNickname);
    state = ProfileCardState(editMode: false);
    ref.read(memberStateNotifierProvider.notifier).state = memberModel;
  }

  void onTapImgUpdate() async {
    final picker = ImagePicker();
    final imageXFile = await picker.pickImage(source: ImageSource.gallery);
    final imageFile = File(imageXFile!.path);
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
