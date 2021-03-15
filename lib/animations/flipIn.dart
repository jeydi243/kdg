import 'package:flutter/material.dart';
import 'package:kdg/animations/easeOutBounce.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import 'dart:math' as math;

enum AniProps { opacity, deg, x }

class FlipIn extends StatelessWidget {
  FlipIn({this.dur, this.child});
  double dur;
  Widget child;

  final _tween = TimelineTween<AniProps>() // <-- design tween
    ..addScene(begin: 0.milliseconds, duration: 1.seconds)
        .animate(AniProps.opacity, tween: 0.0.tweenTo(1.0))
        .animate(
          AniProps.x,
          tween: (250.0).tweenTo(0),
          curve: easeOutBounce(),
        )
    ..addScene(begin: 500.milliseconds, duration: 700.milliseconds)
        .animate(AniProps.deg, tween: 0.0.tweenTo(5.0))
        .animate(
          AniProps.deg,
          tween: 5.0.tweenTo(0.0),
          curve: easeOutBounce(),
        );
  @override
  Widget build(BuildContext context) {
    return PlayAnimation<TimelineValue<AniProps>>(
        tween: _tween,
        duration: _tween.duration,
        delay: dur.seconds,
        builder: (context, childe, value) {
          return Opacity(
            opacity: value.get(AniProps.opacity),
            child: Transform.rotate(
              alignment: Alignment.bottomLeft,
              angle: value.get(AniProps.deg) * math.pi / 180,
              child: Transform.translate(
                offset: Offset(value.get(AniProps.x), 0),
                child: child,
              ),
            ),
          );
        });
  }
}
