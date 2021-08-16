import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Details extends StatefulWidget {
  Details({Key key, this.imgsrc}) : super(key: key);
  final String imgsrc;
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
          child: Container(
        child: Hero(tag: widget.imgsrc, child: Image.asset(widget.imgsrc)),
      )),
    );
  }
}
