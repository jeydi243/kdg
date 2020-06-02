import 'package:flutter/material.dart';
import 'package:kdg/animations/fadein.dart';
import 'package:kdg/components/blur.dart';
import 'package:kdg/views/CarsHome.dart';
import 'dart:math';


class PageV extends StatefulWidget {
	PageV({
		Key key,
	}): super(key: key);

	@override
	_PageVState createState() => _PageVState();
}

class _PageVState extends State < PageV > {
	PageController _controller;
	String name;
	double myFraction = 0.8;
	double pageOffset = 0;
	List < String > _list = ["assets/deux.jpg", "assets/onze.jpg", "assets/six.jpg", "assets/quinze.jpg"];

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
		return FadeIn(PageView.builder(
			physics: BouncingScrollPhysics(),
			controller: _controller,
			itemCount: _list.length,
			itemBuilder: (context, index) {
				double scale = max(myFraction, (1 - (pageOffset - index).abs()) + myFraction);
				name = _list[index];
				return Container(
					height: 80.0,
					padding: EdgeInsets.only(
						right: 20.0,
						top: 80 - scale * 25,
						bottom: 20
					),
					child: ClipRRect(
						borderRadius: BorderRadius.circular(20.0),
						child: Stack(
							children: [
								SizedBox(
									height: double.infinity,
									child: GestureDetector(
										onTap: () {
											Navigator.push(context, MaterialPageRoute(builder: (context) => CarsHome(name: _list[index])));
										},
										child: Hero(
											tag: name,
											child: Image.asset(_list[index], fit: BoxFit.cover, ),
										),
									),
								),
								Align(
									alignment: Alignment.bottomCenter,
									child: Hero(tag: 'un${_list[index]}', child: BlurCard()),
								)
							]
						),
					),
					// child: Image.asset(_list[index]),
				);

			}
		), );
	}
}