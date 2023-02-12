enum Policy {
  age(name: '', title: '만 14세 이상', isConsentRequired: true, hasDocs: false),
  terms(name: 'terms', title: '서비스 이용약관 동의', isConsentRequired: true),
  personalInfoAgree(name: 'personal-info-agree', title: '개인정보 수집 및 이용 동의', isConsentRequired: true),
  locationBaseTerms(name: 'location-base-terms', title: '위치기반 서비스 이용약관'),
  privacy(name: 'privacy', title: '개인정보처리방침'),
  operation(name: 'operation', title: '운영정책');

  final String name;
  final String title;
  final bool isConsentRequired;
  final bool hasDocs;

  const Policy({
    required this.name,
    required this.title,
    this.isConsentRequired = false,
    this.hasDocs = true,
  });
}
