import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/models/vehicule.dart';
import 'package:kdg/utils/utils.dart';
import 'package:kdg/views/cars/details.dart';
import 'package:logger/logger.dart';

class CarItem extends StatefulWidget {
  CarItem({Key? key, required this.item}) : super(key: key);
  final Vehicule item;
  @override
  _CarItemState createState() => _CarItemState();
}

class _CarItemState extends State<CarItem> {
  late List<Map<String, dynamic>> list;
  @override
  void initState() {
    Vehicule car = widget.item;
    list = [
      {"doc": 'assurance', "value": car.assurance},
      {"doc": 'controle', "value": car.assurance},
      {"doc": 'vignette', "value": car.assurance},
      {"doc": 'stationnement', "value": car.assurance},
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Vehicule car = widget.item;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        // height: Get.height * .18,
        // width: Get.width * .8,
        child: ListTile(
          enableFeedback: true,
          contentPadding: EdgeInsets.all(0),
          leading: SizedBox(
            height: Get.height * .07,
            width: Get.height * .07,
            child: OpenContainer(
              transitionDuration: 1.seconds,
              closedBuilder: (context, action) {
                return Hero(
                  tag: car.id,
                  child: Image.asset(
                    "assets/epa.jpg",
                    fit: BoxFit.cover,
                  ),
                );
              },
              openBuilder: (context, action) {
                return DetailsCar(car);
              },
            ),
          ),
          title: Text(car.Nom.capitalizeFirst!),
          trailing: IconButton(onPressed: () => 1, icon: Icon(Icons.more_vert)),
        ),
        // padding: EdgeInsets.only(left: 10, top: 10),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            border: Border(left: BorderSide(color: Colors.amber, width: 2))),
      ),
    );
  }
}
