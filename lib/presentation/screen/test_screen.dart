import 'package:bookand/core/const/map.dart';
import 'package:bookand/core/widget/base_bottom_sheet.dart';
import 'package:bookand/domain/model/bookstore/bookstore_map_model.dart';
import 'package:bookand/presentation/provider/map/map_bookstores_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestScreen extends ConsumerStatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends ConsumerState<TestScreen> {
  bool inited = false;
  List<BookStoreMapModel> response = [];

  Future initBookstore() async {
    if (inited) {
      return;
    } else {
      await ref
          .read(mapBooksStoreNotifierProvider.notifier)
          .fetchBookstoreList(userLat: SEOUL_COORD[0], userLon: SEOUL_COORD[1]);
      setState(() {
        response = ref.read(mapBooksStoreNotifierProvider);
      });
      inited = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  showCustomBottomSheet(context);
                },
                child: const Text('show bottom sheet')),
            TextButton(
                onPressed: () {
                  initBookstore();
                },
                child: const Text('api test, boomstore -> map')),
            Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(border: Border.all()),
                child: SingleChildScrollView(
                    child: Column(
                        children:
                            response.map((e) => Text(e.toString())).toList()))),
            TextButton(
                onPressed: () {
                  showCustomBottomSheet(context);
                },
                child: const Text('api test,  bookmark bookstore folder ')),
            TextButton(
                onPressed: () {
                  showCustomBottomSheet(context);
                },
                child: const Text('api test, bookmark article folder')),
          ],
        ),
      ),
    );
  }
}
