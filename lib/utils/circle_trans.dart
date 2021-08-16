import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/painting/alignment.dart';
import 'package:flutter/src/animation/curves.dart';
import 'package:flutter/src/animation/animation.dart';
import 'package:get/route_manager.dart';
import 'package:kdg/utils/circle_transition.dart';

class CircleTrans extends CustomTransition {
  @override
  Widget buildTransition(
      BuildContext context,
      Curve curve,
      Alignment alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    double beginsRadius = 0.0;
    double endRadius = Get.height * 1.2;
    var screenSize = Get.size;
    var centerCircleClipper = Offset(screenSize.width, screenSize.height);
    var radiusTween = Tween(begin: beginsRadius, end: endRadius);
    var radiusTweenAnimation = animation.drive(radiusTween);

    return ClipPath(
      child: child,
      clipper: CircleTransition(
          radius: radiusTweenAnimation.value, center: centerCircleClipper),
    );
  }
}
