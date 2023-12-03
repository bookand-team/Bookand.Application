// ignore_for_file: constant_identifier_names

enum SocialType {
  NONE(name: 'N/A'),
  GOOGLE(name: 'Google'),
  APPLE(name: 'Apple');

  final String name;

  const SocialType({
    required this.name,
  });
}
