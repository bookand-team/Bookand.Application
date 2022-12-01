import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavProvider = StateNotifierProvider((ref) => BottomNavStateNotifier(0));

class BottomNavStateNotifier extends StateNotifier<int> {
  int selectedIndex = 0;

  BottomNavStateNotifier(this.selectedIndex) : super(0);

  
}