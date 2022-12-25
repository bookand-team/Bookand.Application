import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class BookmarkButton extends StatefulWidget {
  final double? width;
  final double? height;
  final bool isBookmark;
  final Function() onTapBookmark;

  const BookmarkButton({
    super.key,
    this.width = 40,
    this.height = 40,
    required this.isBookmark,
    required this.onTapBookmark,
  });

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 100),
    vsync: this,
  );
  late final Animation<double> _animation = Tween(begin: 1.0, end: 1.3).animate(_controller);

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTapBookmark();
      },
      child: Container(
          width: widget.width,
          height: widget.height,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.8), shape: BoxShape.circle),
          child: ScaleTransition(
            scale: _animation,
            child: SvgPicture.asset(
              widget.isBookmark
                  ? 'assets/images/home/ic_40_bookmark_active.svg'
                  : 'assets/images/home/ic_40_bookmark_inactive.svg',
            ),
          )),
    );
  }
}
