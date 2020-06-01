import 'dart:ui';

import 'package:flutter/material.dart';


class BlurCard extends StatefulWidget {
	BlurCard({
		Key key,
		@required this.child
	}): super(key: key);
	final Widget child;

	@override
	_BlurCardState createState() => _BlurCardState();
}

class _BlurCardState extends State < BlurCard > {
	PageController _controller;

	@override
	void initState() {
		super.initState();
		_controller = new PageController();

	}
	@override
	Widget build(BuildContext context) {
		return Stack(
			children: [
				SizedBox(
				height: 100.0,
				width: 400.0,
				child: BackdropFilter(
					filter: ImageFilter.blur(
						sigmaX: 5,
						sigmaY: 5
					),
					child: widget.child
				),
			), 
			]
		);
	}
}