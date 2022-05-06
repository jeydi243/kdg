import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bdd/details.dart';
import 'cars/index.dart';
import 'famille/details.dart';
import 'houses/details.dart';
import 'rapports/details.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

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
      "imgsrc": "assets/familles.webp",
      "text": "Familles",
      "collection": "familles"
    },
    {
      "imgsrc": "assets/paysage.webp",
      "text": "Base de connaissance",
      "collection": "bdd"
    },
    {
      "imgsrc": "assets/rapport.jpg",
      "text": "Rapports",
      "collection": "rapports"
    },
  ];
  Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: toHeroContext.widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: InputChip(
            label: Text("Rechercher"),
            showCheckmark: true,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/epa.jpg"),
                radius: 20,
                // child: DropdownButton(
                //     items: ['Modifier le Profil']
                //         .map<DropdownMenuItem<String>>((String value) {
                //   return DropdownMenuItem<String>(
                //     value: value,
                //     child: Text(value),
                //   );
                // }).toList()),
              ),
            )
          ],
        ),
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 10),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
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
                        case 'familles':
                          Get.to(DetailsFamille(item: list[index]));
                          break;
                        default:
                          Get.to(DetailsBdd(item: list[index]));
                          break;
                      }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
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
                  alignment: Alignment(-0.9, 1.0),
                  child: Container(
                    child: Hero(
                      tag: "title${list[index]['text']}",
                      flightShuttleBuilder: _flightShuttleBuilder,
                      child: Text(
                        list[index]['text'],
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                    height: 50,
                  ),
                )
              ],
            );
          },
        ));
  }
}
