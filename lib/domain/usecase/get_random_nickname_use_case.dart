import 'dart:convert';

import 'package:bookand/data/repository/member_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../repository/member_repository.dart';

part 'get_random_nickname_use_case.g.dart';

@riverpod
GetRandomNicknameUseCase getRandomNicknameUseCase(GetRandomNicknameUseCaseRef ref) {
  final memberRepository = ref.read(memberRepositoryProvider);

  return GetRandomNicknameUseCase(memberRepository);
}

class GetRandomNicknameUseCase {
  final MemberRepository memberRepository;

  GetRandomNicknameUseCase(this.memberRepository);

  Future<String> getRandomNickname() async {
    final nickname = await memberRepository.getRandomNickname();
    return const Utf8Decoder().convert(nickname.codeUnits);
  }
}
