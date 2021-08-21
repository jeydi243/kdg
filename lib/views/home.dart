import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:kdg/animations/fadein.dart';
import 'package:kdg/views/sections1.dart';
import 'package:kdg/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'bdd/details.dart';
import 'cars/details.dart';
import 'houses/details.dart';
import 'rapports/details.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final searchTextController = new TextEditingController();
  String query = "";
  List<Map<String, String>> list = <Map<String, String>>[
    {
      "imgsrc": "assets/vehicules.webp",
      "text": "Vehicules",
      "collection": "cars"
    },
    {
      "imgsrc": "assets/maisons.webp",
      "text": "Maisons",
      "collection": "houses"
    },
    {
      "imgsrc": "assets/paysage.webp",
      "text": "Paysage",
      "collection": "paysages"
    },
    {
      "imgsrc": "assets/familles.webp",
      "text": "Familles",
      "collection": "familles"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: InputChip(
            label: Text("Rechercher"),
          ),
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
              child: Badge(
                badgeContent: Text(
                  '8',
                  // style: TextStyle(height: 5),
                ),
                // borderRadius: BorderRadius.circular(3),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/epa.jpg"),
                  radius: 20,
                  child: DropdownButton(
                      items: ['Modifier le Profil']
                          .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList()),
                ),
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
                      switch (list[index]['collection']) {
                        case 'cars':
                          Get.to(DetailsCar(
                            imgsrc: list[index]['imgsrc'],
                            collection: list[index]['collection'],
                          ));
                          break;
                        case 'houses':
                          Get.to(DetailsHouse(
                            imgsrc: list[index]['imgsrc'],
                            collection: list[index]['collection'],
                          ));
                          break;
                        case 'rapports':
                          Get.to(DetailsRapport(
                            imgsrc: list[index]['imgsrc'],
                            collection: list[index]['collection'],
                          ));
                          break;
                        case 'bdd':
                          Get.to(DetailsBdd(
                            imgsrc: list[index]['imgsrc'],
                            collection: list[index]['collection'],
                          ));
                          break;
                        default:
                      }
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
