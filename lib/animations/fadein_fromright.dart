import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

// il s'agit d'un enum necessaire, tu le nomme comme tu veux
enum Props { opacity, offset }

class FadeInRight extends StatefulWidget {
  FadeInRight(this.child, {Key? key, this.delay = 1.0}) : super(key: key);
  final Widget child;
  double delay;

  @override
  _FadeInLeftState createState() => _FadeInLeftState();
}

class _FadeInLeftState extends State<FadeInRight> {
  final tween = MultiTween<Props>()
    ..add(Props.opacity, Tween<double>(begin: 0, end: 1), 2.seconds)
    ..add(Props.offset, Tween<Offset>(begin: Offset(-40, 0), end: Offset(0, 0)),
        2.seconds, Curves.easeInOutCubic);

  @override
  Widget build(BuildContext context) {
    return PlayAnimation<MultiTweenValues<Props>>(
        tween: tween,
        duration: tween.duration,
        delay: widget.delay.seconds,
        builder: (context, childe, value) {
          return Transform.translate(
              offset: value.get(Props.offset),
              child: Opacity(
                opacity: value.get(Props.opacity),
                child: widget.child,
              ));
        });
  }
}
