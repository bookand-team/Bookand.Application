import 'package:bookand/data/repository/auth_repository_impl.dart';
import 'package:bookand/data/repository/member_repository_impl.dart';
import 'package:bookand/domain/repository/auth_repository.dart';
import 'package:bookand/domain/repository/member_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/member/member_model.dart';

part 'sign_up_use_case.g.dart';

@riverpod
SignUpUseCase signUpUseCase(SignUpUseCaseRef ref) {
  final authRepository = ref.read(authRepositoryProvider);
  final memberRepository = ref.read(memberRepositoryProvider);
  return SignUpUseCase(authRepository, memberRepository);
}

class SignUpUseCase {
  final AuthRepository authRepository;
  final MemberRepository memberRepository;

  SignUpUseCase(this.authRepository, this.memberRepository);

  Future<MemberModel> signUp() async {
    await authRepository.signUp();
    return await memberRepository.getMe();
  }
}
