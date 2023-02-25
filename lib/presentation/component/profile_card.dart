import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileCard extends StatelessWidget {
  final bool isEditMode;
  final String nickname;
  final String email;
  final Widget image;
  final Function() onTapEdit;
  final Function() onTapReset;
  final Function() onTapComplete;
  final Function() onTapImgUpdate;
  final Function() onTapChangeNickname;

  const ProfileCard({
    Key? key,
    required this.isEditMode,
    required this.nickname,
    required this.email,
    required this.image,
    required this.onTapEdit,
    required this.onTapReset,
    required this.onTapComplete,
    required this.onTapImgUpdate,
    required this.onTapChangeNickname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            foregroundDecoration: const BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.6),
            ),
            child: image,
          ),
        ),
        isEditMode ? editMode() : viewMode(),
        Positioned(
          left: 16,
          bottom: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: isEditMode ? onTapChangeNickname : null,
                child: Text(
                  nickname,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    letterSpacing: -0.02,
                  ),
                ),
              ),
              Text(
                email,
                style: const TextStyle(
                  color: Color(0xFFACACAC),
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: -0.02,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget viewMode() => Positioned(
        top: 12,
        right: 12,
        child: InkWell(
          onTap: onTapEdit,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              '수정',
              style: TextStyle(
                color: Color(0xFFDDDDDD),
                fontWeight: FontWeight.w500,
                fontSize: 14,
                letterSpacing: -0.02,
              ),
            ),
          ),
        ),
      );

  Widget editMode() => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 12,
              right: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: onTapReset,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      '되돌리기',
                      style: TextStyle(
                        color: Color(0xFFDDDDDD),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: -0.02,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: onTapComplete,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      '완료',
                      style: TextStyle(
                        color: Color(0xFFDDDDDD),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        letterSpacing: -0.02,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          InkWell(
            onTap: onTapImgUpdate,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset('assets/images/my/ic_photo.svg'),
            ),
          ),
        ],
      );
}
