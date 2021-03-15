import 'package:flutter/material.dart';
import 'package:kdg/components/blur.dart';
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
	String _name;
	double myFraction = 0.8;
	double pageOffset = 0;
	String valeurBlur = "";
	Map < String,
	String > _list = {
		"Rexton": "assets/onze.jpg",
		"Audi": "assets/treze.jpg",
		"Nissan Bus": "assets/six.jpg",
		"Nissan camionette": "assets/un.jpg"
	};

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
	void dispose() {
		super.dispose();
		_controller.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return PageView.builder(
			physics: BouncingScrollPhysics(),
			controller: _controller,
			itemCount: _list.length,
			itemBuilder: (context, index) {
				double scale = max(myFraction, (1 - (pageOffset - index).abs()) + myFraction);
				_name = _list[index];
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
										child: Hero(tag: '${_list[_list.keys.elementAt(index)]}', child: Image.asset(_list[_list.keys.elementAt(index)], fit: BoxFit.cover)),
									),
								),
								Align(
									alignment: Alignment(0, 1),
									child: Hero(tag: "${_list[_list.keys.elementAt(index)]}2",
										child: BlurCard(titre: _list.keys.elementAt(index), )
									)
								),
							]
						),
					),
					// child: Image.asset(_list[index]),
				);
			}
		);
	}
}