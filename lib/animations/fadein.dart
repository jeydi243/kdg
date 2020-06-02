import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum AniProps {
	opacity,
	offset
}
class FadeIn extends StatefulWidget {
	final Widget child;
	FadeIn(this.child);

	@override
	_FadeInState createState() => _FadeInState();
}

class _FadeInState extends State < FadeIn > {
	final tween = MultiTween < AniProps > ()
	..add(AniProps.opacity, Tween < double > (begin: 0, end: 1), 600. milliseconds)
	..add(AniProps.offset, Tween < Offset > (begin: Offset(50, 0), end: Offset(0, 0)), 600.milliseconds, Curves.easeInOutCubic);

	@override
	Widget build(BuildContext context) {
		return PlayAnimation < MultiTweenValues < AniProps >> (
			tween: tween,
			duration: tween.duration,
			builder: (context, childe, value) {
				return Transform.translate(
					offset: value.get(AniProps.offset),
					child: Opacity(
						opacity: value.get(AniProps.opacity),
						child: widget.child,
					)
				);
			}
		);
	}
}