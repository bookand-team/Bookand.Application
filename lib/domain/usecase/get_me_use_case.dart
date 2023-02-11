import 'dart:async';

import 'package:bookand/core/const/storage_key.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/member_model.dart';
import '../repository/member/member_repository.dart';
import '../repository/member/member_repository_impl.dart';

part 'get_me_use_case.g.dart';

@riverpod
GetMeUseCase getMeUseCase(GetMeUseCaseRef ref) {
  final repository = ref.read(memberRepositoryProvider);
  const storage = FlutterSecureStorage();

  return GetMeUseCase(repository, storage);
}

class GetMeUseCase {
  final MemberRepository repository;
  final FlutterSecureStorage storage;

  GetMeUseCase(this.repository, this.storage);

  Future<MemberModel> getMe() async {
    final accessToken = await storage.read(key: accessTokenKey);
    final refreshToken = await storage.read(key: refreshTokenKey);

    if (refreshToken == null || accessToken == null) {
      throw Exception('로그인 정보가 없음');
    }

    return await repository.getMe(accessToken);
  }
}
