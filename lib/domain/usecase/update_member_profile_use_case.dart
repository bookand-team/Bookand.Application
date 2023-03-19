import 'dart:io';

import 'package:bookand/data/repository/member_repository_impl.dart';
import 'package:bookand/domain/repository/member_repository.dart';
import 'package:bookand/domain/usecase/upload_files_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/member/member_model.dart';

part 'update_member_profile_use_case.g.dart';

@riverpod
UpdateMemberProfileUseCase updateMemberProfileUseCase(UpdateMemberProfileUseCaseRef ref) {
  final memberRepository = ref.read(memberRepositoryProvider);
  final uploadFilesUseCase = ref.read(uploadFilesUseCaseProvider);

  return UpdateMemberProfileUseCase(memberRepository, uploadFilesUseCase);
}

class UpdateMemberProfileUseCase {
  final MemberRepository memberRepository;
  final UploadFilesUseCase uploadFilesUseCase;

  UpdateMemberProfileUseCase(
    this.memberRepository,
    this.uploadFilesUseCase,
  );

  Future<MemberModel> updateMemberProfile(File? imageFile, String? nickname) async {
    var member = await memberRepository.getMe();
    String? imageUrl;

    if (imageFile != null) {
      final files = await uploadFilesUseCase.uploadFiles([imageFile]);
      imageUrl = files.first.fileUrl;
    }

    return await memberRepository.updateMemberProfile(
      imageUrl ?? (member.profileImage),
      nickname ?? member.nickname,
    );
  }
}
