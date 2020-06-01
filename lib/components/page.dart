import 'dart:math';

import 'package:flutter/material.dart';
import 'package:parallax_image/parallax_image.dart';


class MyPage extends StatefulWidget {
	MyPage({
		Key key
	}): super(key: key);

	@override
	_MyPageState createState() => _MyPageState();
}

class _MyPageState extends State < MyPage > {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Container(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.start,
					children: < Widget > [
						Padding(padding: EdgeInsets.only(
								top: MediaQuery.of(context).padding.top,
								left: 40,

							),
							child: Text("Find you next Place", style: TextStyle(
								fontWeight: FontWeight.bold
							), ),
						),
						Expanded(
							child: PageV()
						)

					],
				),
			),
		);
	}
}

class PageV extends StatefulWidget {
	PageV({
		Key key
	}): super(key: key);

	@override
	_PageVState createState() => _PageVState();
}

class _PageVState extends State < PageV > {
	PageController _controller;
	double myFraction = 0.8;
	double pageOffset = 0;

	@override
	void initState() {
		super.initState();
		_controller = new PageController(viewportFraction: myFraction)..addListener(() {
			setState(() {
				pageOffset = _controller.page;
			});
		});
	}


	@override
	Widget build(BuildContext context) {
		return PageView.builder(
			physics: BouncingScrollPhysics(),
			controller: _controller,
			itemCount: 4,
			itemBuilder: (context, index) {
				double scale = max(myFraction, (1 - (pageOffset - index).abs()) + myFraction);
				return Container(
					padding: EdgeInsets.only(right: 20.0, top: 100 - scale * 25, bottom: 50),
					child: ParallaxImage(extent: 90.0, image: AssetImage("assets/dix-sept.jpg")),
				);
			}
		);
	}
}