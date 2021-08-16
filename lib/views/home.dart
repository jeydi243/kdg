import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:kdg/animations/fadein.dart';
import 'package:kdg/views/sections1.dart';
import 'package:kdg/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'details.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final searchTextController = new TextEditingController();
  String query = "";
  List<Map<String, String>> list = <Map<String, String>>[
    {"imgsrc": "assets/vehicules.webp", "text": "Vehicules"},
    {"imgsrc": "assets/maisons.webp", "text": "Maisons"},
    {"imgsrc": "assets/vehicules.webp", "text": "Vehicules"},
    {"imgsrc": "assets/familles.webp", "text": "Familles"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                child: Image.asset("assets/epa.jpg"),
                // minRadius: 10,
                radius: 10,
              ),
            )
          ],
        ),
        body: SafeArea(
            child: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 10),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Hero(
                  tag: list[index]['imgsrc'],
                  child: GestureDetector(
                    onTap: () {
                      Get.to(Details(imgsrc: list[index]['imgsrc']));
                    },
                    child: Image.asset(
                      list[index]['imgsrc'],
                      fit: BoxFit.cover,
                      height: Get.height * .2,
                      width: Get.height * .9,
                    ),
                  ),
                ),
              ),
            );
          },
        )));
  }
}
