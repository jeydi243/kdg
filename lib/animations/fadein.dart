// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum AniProps { opacity, offset }

class FadeIn extends StatefulWidget {
  FadeIn(this.child, {Key? key, this.delay = 1.0}) : super(key: key);
  final Widget child;
  double delay;

  @override
  _FadeInState createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> {
  final tween = MultiTween<AniProps>()
    ..add(AniProps.opacity, Tween<double>(begin: 0, end: 1), 1000.milliseconds)
    ..add(
        AniProps.offset,
        Tween<Offset>(begin: Offset(0, 40), end: Offset(0, 0)),
        1000.milliseconds,
        Curves.easeInOutCubic);

  @override
  Widget build(BuildContext context) {
    return PlayAnimation<MultiTweenValues<AniProps>>(
        tween: tween,
        duration: tween.duration,
        delay: widget.delay.seconds,
        builder: (context, childe, value) {
          return Transform.translate(
              offset: value.get(AniProps.offset),
              child: Opacity(
                opacity: value.get(AniProps.opacity),
                child: widget.child,
              ));
        });
  }
}
