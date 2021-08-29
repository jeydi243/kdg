import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomImage extends StatefulWidget {
  CustomImage({Key key, this.imgsrc}) : super(key: key);
  final String imgsrc;
  @override
  _CustomImageState createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  Tween<double> heightAnime =
      Tween(begin: Get.height * .2, end: Get.height * .45);
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: heightAnime,
      duration: 1.seconds,
      curve: Curves.decelerate,
      builder: (context, double value, child) {
        return SizedBox(width: double.infinity, height: value, child: child);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        child: Hero(
          tag: widget.imgsrc,
          child: Image.asset(
            widget.imgsrc,
            fit: BoxFit.cover,
            height: Get.height * .45,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
