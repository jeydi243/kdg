import 'package:flutter/material.dart';
import 'package:kdg/models/vehicule.dart';

class DetailsCar extends StatefulWidget {
  DetailsCar(this.car, {Key key}) : super(key: key);
  final Vehicule car;
  @override
  _DetailsCarState createState() => _DetailsCarState();
}

class _DetailsCarState extends State<DetailsCar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Hero(tag: widget.car.id, child: Image.asset("assets/epa.jpg"))
          ],
        ),
      ),
    );
  }
}
