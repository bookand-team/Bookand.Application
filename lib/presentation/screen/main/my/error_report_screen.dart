import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/app_strings.dart';
import '../../../../core/widget/base_app_bar.dart';
import '../../../../core/widget/base_layout.dart';

class ErrorReportScreen extends ConsumerWidget {
  static String get routeName => 'ErrorReportScreen';

  const ErrorReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseLayout(
      appBar: const BaseAppBar(title: AppStrings.errorReport),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom != 0 ? 20 : 56,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

          ],
        ),
      ),
    );
  }
}
