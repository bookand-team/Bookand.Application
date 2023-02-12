enum Policy {
  terms(name: 'terms'),
  personalInfoAgree(name: 'personal-info-agree'),
  locationBaseTerms(name: 'location-base-terms'),
  privacy(name: 'privacy'),
  operation(name: 'operation');

  final String name;

  const Policy({required this.name});
}
