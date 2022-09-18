import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          Text(AppLocalizations.of(context)!.hello_1),
          ElevatedButton(onPressed: () => throw Exception(), child: const Text("error"))
        ],
      )),
    );
  }

}