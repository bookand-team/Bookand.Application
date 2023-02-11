abstract class MemberModelBase {}

class MemberModelInit implements MemberModelBase {}

class MemberModelSignUp implements MemberModelBase {}

class MemberModelLoading implements MemberModelBase {}

class MemberModelError implements MemberModelBase {
  final String? message;

  MemberModelError({this.message});
}

class MemberModel implements MemberModelBase {
  final int id;
  final String email;
  final String nickname;

  MemberModel({
    required this.id,
    required this.email,
    required this.nickname,
  });
}
