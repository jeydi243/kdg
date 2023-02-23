import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Details extends StatefulWidget {
  Details({Key key, @required this.titre}) : super(key: key);
  final String titre;
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Container(
          child: Column(
        children: [
          Hero(
              tag: widget.titre,
              child: Image.asset(
                widget.titre,
                height: Get.height * .3,
                width: Get.width,
                fit: BoxFit.cover,
              )),
        ],
      )),
    );
  }
}
