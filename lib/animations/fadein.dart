import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum AniProps {
	opacity,
	translatey
}
class FadeIn extends StatefulWidget {
	final double delay;
	final Widget child;
	FadeIn(this.delay, this.child);

	@override
	_FadeInState createState() => _FadeInState();
}

class _FadeInState extends State < FadeIn > {
	final tween = MultiTween < AniProps > ()..add(AniProps.opacity, 0.0.tweenTo(1.0), 1000. milliseconds)..add(AniProps.translatey, 30.0.tweenTo(0.0), 1000. milliseconds);

	@override
	Widget build(BuildContext context) {
		return PlayAnimation<MultiTweenValues>(
			tween: tween,
			duration: tween.duration,
			curve: Curves.easeInOutBack,
			builder: (_,child,value){
				return Transform.translate(
					offset: value.get(AniProps.translatey),
					child: child,
				);
			}
		);
	}
}