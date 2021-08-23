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
import 'famille/details.dart';
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
  List<Map<String, dynamic>> list = <Map<String, dynamic>>[
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
      "imgsrc": "assets/rapport.jpg",
      "text": "Rapports",
      "collection": "rapports"
    },
    {
      "imgsrc": "assets/familles.webp",
      "text": "Familles",
      "collection": "familles"
    },
    {
      "imgsrc": "assets/paysage.webp",
      "text": "Base de connaissance",
      "collection": "bdd"
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Badge(
                badgeContent: Text(
                  '8',
                  // style: TextStyle(height: 5),
                ),
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
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: GestureDetector(
                      onTap: () {
                        switch (list[index]['collection']) {
                          case 'cars':
                            Get.to(DetailsCar(item: list[index]));
                            break;
                          case 'houses':
                            Get.to(DetailsHouse(item: list[index]));
                            break;
                          case 'rapports':
                            Get.to(DetailsRapport(item: list[index]));
                            break;
                          case 'bdd':
                            Get.to(DetailsFamille(item: list[index]));
                            break;
                          default:
                            Get.to(DetailsBdd(item: list[index]));
                            break;
                        }
                      },
                      child: Hero(
                        tag: list[index]['imgsrc'],
                        child: Image.asset(
                          list[index]['imgsrc'],
                          fit: BoxFit.cover,
                          height: Get.height * .2,
                          width: Get.height * .9,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(-1, 0.5),
                  child: Container(
                    child: Text(
                      list[index]['text'],
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    height: 50,
                  ),
                )
              ],
            );
          },
        )));
  }
}
