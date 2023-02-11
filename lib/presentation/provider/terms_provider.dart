import 'package:flutter_riverpod/flutter_riverpod.dart';

final allAgreeProvider =
    StateNotifierProvider.autoDispose<AllAgree, bool>((ref) {
  final agreeList = [
    ref.watch(agree14YearsOfAgeOrOlderProvider.notifier),
    ref.watch(agreeTermsOfServiceProvider.notifier),
    ref.watch(agreeCollectAndUsePrivacyProvider.notifier)
  ];

  return AllAgree(agreeList);
});

final agree14YearsOfAgeOrOlderProvider = StateProvider.autoDispose((ref) {
  return false;
});

final agreeTermsOfServiceProvider = StateProvider.autoDispose((ref) {
  return false;
});

final agreeCollectAndUsePrivacyProvider = StateProvider.autoDispose((ref) {
  return false;
});

class AllAgree extends StateNotifier<bool> {
  final List<StateController<bool>> agreeList;

  AllAgree(this.agreeList) : super(false);

  void changeAgree() {
    super.state = !super.state;

    for (var item in agreeList) {
      item.state = super.state;
    }
  }

  void checkAgreeList() {
    var agreeCnt = 0;

    for (var item in agreeList) {
      if (item.state) {
        agreeCnt++;
      }
    }

    if (agreeCnt == agreeList.length) {
      super.state = true;
    } else {
      super.state = false;
    }
  }
}
