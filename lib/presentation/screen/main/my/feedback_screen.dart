import 'package:flutter/material.dart';

import '../../../../core/app_strings.dart';
import '../../../../core/widget/base_app_bar.dart';
import '../../../../core/widget/base_layout.dart';

class FeedbackScreen extends StatelessWidget {
  static String get routeName => 'feedbackScreen';

  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      resizeToAvoidBottomInset: false,
      appBar: const BaseAppBar(title: AppStrings.feedback),
      child: Column(
        children: [],
      ),
    );
  }
}
