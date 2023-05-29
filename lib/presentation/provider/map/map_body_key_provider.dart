import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///theme 버튼 열고 있을 때 활성화 용
class MapBodyKeyNotifier extends StateNotifier<GlobalKey> {
  MapBodyKeyNotifier() : super(GlobalKey());
}

final mapBodyKeyProvider = StateNotifierProvider<MapBodyKeyNotifier, GlobalKey>(
    (ref) => MapBodyKeyNotifier());
