import 'package:flutter/animation.dart';
import 'dart:math';

// ignore: camel_case_types
class easeOutBounce extends Curve {
  const easeOutBounce({
    this.a = 0.15,
    this.w = 19.4,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return -(pow(e, -t / a) * cos(t * w)) + 1;
  }
}
