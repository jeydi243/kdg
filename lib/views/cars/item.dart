import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/utils/utils.dart';

class CarItem extends StatefulWidget {
  CarItem({Key key, this.item}) : super(key: key);
  final dynamic item;
  @override
  _CarItemState createState() => _CarItemState();
}

class _CarItemState extends State<CarItem> {
  @override
  Widget build(BuildContext context) {
    QueryDocumentSnapshot er = widget.item;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        height: Get.height * .15,
        width: Get.width * .8,
        child: Column(
          children: [
            Text(
              "${(er.get('nom') as String).capitalizeFirst}",
              style: TextStyle(fontSize: 22, color: Colors.black),
            ),
            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(12),
              color: Colors.blue[900],
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Container(
                  height: Get.height * .03,
                  width: Get.width * .3,
                  color: Colors.white,
                  child: Center(child: Text('Stationnement')),
                ),
              ),
            )
          ],
        ),
        padding: EdgeInsets.only(left: 10, top: 10),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            border: Border(left: BorderSide(color: Colors.amber, width: 2))),
      ),
    );
  }
}
