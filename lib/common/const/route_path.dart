enum RoutePath {
  splash(path: '/splash'),
  login(path: '/login'),
  termsAgree(path: '/login/termsAgree'),
  termsAgreeDetail(path: '/login/termsAgree/termsAgreeDetail'),
  home(path: '/');

  final String path;

  const RoutePath({required this.path});
}
