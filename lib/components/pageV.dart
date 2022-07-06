import 'package:flutter/material.dart';
import 'dart:math';

class PageV extends StatefulWidget {
  PageV({
    Key? key,
  }) : super(key: key);

  @override
  _PageVState createState() => _PageVState();
}

class _PageVState extends State<PageV> {
  late PageController _controller;
  double? myFraction = 0.8;
  double? pageOffset = 0.0;
  Map<String, String> _list = {
    "Rexton": "assets/quatre.jpg",
    "Audi": "assets/treze.jpg",
    "Nissan Bus": "assets/six.jpg",
    "Nissan camionette": "assets/sami.jpg"
  };

  @override
  void initState() {
    super.initState();
    _controller =
        new PageController(viewportFraction: myFraction!, initialPage: 1)
          ..addListener(() {
            setState(() {
              // pageOffset = _controller.page;
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
          double scale =
              max(myFraction!, (1 - (pageOffset! - index).abs()) + myFraction!);

          return Container(
            height: double.infinity,
            padding:
                EdgeInsets.only(right: 20.0, top: 40 - scale * 5, bottom: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: SizedBox(
                height: double.infinity,
                child: GestureDetector(
                  child: Hero(
                      tag: '${_list[_list.keys.elementAt(index)]}',
                      child: Image.asset(
                          _list[_list.keys.elementAt(index)] as String,
                          fit: BoxFit.cover)),
                ),
              ),
            ),
            // child: Image.asset(_list[index]),
          );
        });
  }
}
