import 'package:bookand/core/widget/base_layout.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/bookmark_contents.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/bookmark_folders.dart';
import 'package:bookand/presentation/screen/main/bookmark/components/bookmark_top.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarkScreen extends ConsumerStatefulWidget {
  const BookmarkScreen({ Key? key }) : super(key: key);

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends ConsumerState<BookmarkScreen> {
  //서점과 아티클 구별, false일 경우 아티클 화면
  bool isBookmark = true;
  
  @override
  Widget build(BuildContext context) {
    return 
    BaseLayout(child: 
    Column(
      children: [
        BookmarkTop(isBookmark: isBookmark),
        BookmarkFolders(),
        BookmarkContents(dataList: [],)
      ],
      
    )
    );
  }
}