import 'dart:typed_data';

import 'package:bookand/domain/usecase/get_random_nickname_use_case.dart';
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

  void onTapComplete() {
    state = ProfileCardState(editMode: false);
  }

  void onTapImgUpdate() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    final imageByteArr = await imageFile?.readAsBytes();
    state = state.copyWith(previewImageByteArr: imageByteArr);
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
    return state.editMode && state.previewImageByteArr != null;
  }
}

class ProfileCardState {
  bool editMode;
  String? previewNickname;
  Uint8List? previewImageByteArr;

  ProfileCardState({required this.editMode, this.previewNickname, this.previewImageByteArr});

  ProfileCardState copyWith({
    bool? editMode,
    String? previewNickname,
    Uint8List? previewImageByteArr,
  }) {
    return ProfileCardState(
        editMode: editMode ?? this.editMode,
        previewNickname: previewNickname ?? this.previewNickname,
        previewImageByteArr: previewImageByteArr ?? this.previewImageByteArr);
  }
}
