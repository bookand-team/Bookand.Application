import '../app_strings.dart';

enum FeedbackTarget {
  push(name: '알림이 너무 자주와요'),
  information(name: '정보가 정확하지 않거나 부족해요'),
  use(name: '이용방법이 불편해요'),
  etc(name: AppStrings.other);

  final String name;

  const FeedbackTarget({required this.name});
}
