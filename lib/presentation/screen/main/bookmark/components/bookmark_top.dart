// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookmarkTop extends ConsumerWidget {
  final bool isBookmark; 
const BookmarkTop({ Key? key,required this.isBookmark }) : super(key: key);

  final TextStyle buttonStyle =const TextStyle(fontSize: 22,fontWeight: FontWeight.bold);
  final selectedColor = const Color(0xff222222);
  final unselectedColor = const Color(0xffDDDDDD);

  final String BOOKSTORE = '서점';
  final String ARTICLE = '아티클';


  Widget createButton({required bool isActive,required String data,required void Function() ontap}){
    return GestureDetector(
      onTap: ontap,
      child: Text(data,style: buttonStyle.copyWith(color: isActive ? selectedColor : unselectedColor),),
    );
  }

  @override
  Widget build(BuildContext context,WidgetRef ref){
    return Row(
      children: [
        createButton(data: BOOKSTORE,isActive: isBookmark,ontap: () {
          
        },),
        Text('/',style: buttonStyle.copyWith(color: unselectedColor),),
        createButton(data: ARTICLE,isActive: !isBookmark,ontap: () {
          
        },),

      ],
    );
  }
}