import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListToggleNotifier extends StateNotifier<bool> {
  ListToggleNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

final listToggleProvider = StateNotifierProvider<ListToggleNotifier, bool>(
    (ref) => ListToggleNotifier());

class GpsToggleNotifier extends StateNotifier<bool> {
  GpsToggleNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

final gpsToggleProvider = StateNotifierProvider<GpsToggleNotifier, bool>(
    (ref) => GpsToggleNotifier());
