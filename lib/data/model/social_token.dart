import 'package:bookand/const/social_type.dart';

abstract class SocialTokenBase {}

class SocialTokenError implements SocialTokenBase {
  final String message;

  SocialTokenError({required this.message});
}

class SocialToken implements SocialTokenBase {
  final String token;
  final SocialType socialType;

  SocialToken(this.token, this.socialType);
}