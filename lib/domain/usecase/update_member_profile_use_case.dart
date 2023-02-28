import 'dart:io';

import 'package:bookand/core/const/storage_key.dart';
import 'package:bookand/data/repository/member_repository_impl.dart';
import 'package:bookand/domain/repository/member_repository.dart';
import 'package:bookand/domain/usecase/upload_files_use_case.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/member/member_model.dart';

part 'update_member_profile_use_case.g.dart';

@riverpod
UpdateMemberProfileUseCase updateMemberProfileUseCase(UpdateMemberProfileUseCaseRef ref) {
  final memberRepository = ref.read(memberRepositoryProvider);
  final uploadFilesUseCase = ref.read(uploadFilesUseCaseProvider);
  const storage = FlutterSecureStorage();

  return UpdateMemberProfileUseCase(memberRepository, uploadFilesUseCase, storage);
}

class UpdateMemberProfileUseCase {
  final MemberRepository memberRepository;
  final UploadFilesUseCase uploadFilesUseCase;
  final FlutterSecureStorage storage;

  UpdateMemberProfileUseCase(
    this.memberRepository,
    this.uploadFilesUseCase,
    this.storage,
  );

  Future<MemberModel> updateMemberProfile(File? imageFile, String? nickname) async {
    final accessToken = await storage.read(key: accessTokenKey);
    var member = await memberRepository.getMe(accessToken!);
    String? imageUrl;

    if (imageFile != null) {
      final files = await uploadFilesUseCase.uploadFiles([imageFile]);
      imageUrl = files.first.fileUrl;
    }

    member = await memberRepository.updateMemberProfile(
      accessToken,
      imageUrl ?? (member.profileImage ?? ''),
      nickname ?? member.nickname,
    );

    return MemberModel.convertUtf8(model: member);
  }
}
