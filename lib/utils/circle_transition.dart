import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CircleTransition extends CustomClipper<Path> {
  final Offset center;
  final double radius;

  CircleTransition({this.center, this.radius});
  @override
  Path getClip(Size size) {
    return Path()..addOval(Rect.fromCircle(center: center, radius: radius));
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

Route cr({Widget secondRoute}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => secondRoute,
    transitionDuration: Duration(milliseconds: 1000),
    reverseTransitionDuration: Duration(milliseconds: 1000),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var screenSize = Get.size;
      var centerCircleClipper =
          Offset(screenSize.width , screenSize.height);
      double beginsRadius = 0.0;
      double endRadius = Get.height * 1.2;
      var radiusTween = Tween(begin: beginsRadius, end: endRadius);
      var radiusTweenAnimation = animation.drive(radiusTween);

      return ClipPath(
        child: child,
        clipper: CircleTransition(
            radius: radiusTweenAnimation.value, center: centerCircleClipper),
      );
    },
  );
}
