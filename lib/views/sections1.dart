import 'package:flutter/material.dart';

class Section1 extends StatefulWidget {
  Section1({Key key}) : super(key: key);

  @override
  _Section1State createState() => _Section1State();
}

class _Section1State extends State<Section1> {
  List<String> imgsrc = [
    'assets/melissa2.jpg',
    'assets/melki.jpg',
    'assets/epa.jpg',
    'assets/melissa.jpg',
    'assets/sami.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...imgsrc.map((e) => Image.asset(e)).toList(),
        ],
      ),
    );
  }
}
