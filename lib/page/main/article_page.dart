import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArticlePage extends ConsumerWidget {
  static String get routeName => 'article';
  final String name;

  const ArticlePage({super.key, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    throw UnimplementedError();
  }

}