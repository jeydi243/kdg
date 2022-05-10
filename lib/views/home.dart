import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:kdg/animations/fadein.dart';
import 'package:kdg/services/user_service.dart';
import 'bdd/details.dart';
import 'cars/index.dart';
import 'famille/index.dart';
import 'houses/index.dart';
import 'rapports/index.dart';

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
      "imgsrc": "assets/rapport.jpg",
      "text": "Rapports",
      "collection": "rapports"
    },
    {"imgsrc": "assets/vehicules.webp", "text": "Cars", "collection": "cars"},
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
    UserService us = Get.find();
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hi, ${us.userKDG?.nom ?? 'Kadiongo Ilunga'}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              Text(us.currentUser?.email ?? 'ilungakadiongo@gmail.com',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.normal))
            ],
          ),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () => Get.toNamed('/profile'),
                child: Hero(
                  tag: "Profil",
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
                ),
              ),
            )
          ],
        ),
        body: AnimationConfiguration.staggeredList(
          position: 5,
          delay: 1.seconds,
          duration: 1.seconds,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemCount: list.length,
            itemBuilder: (context, index) {
              return FadeIn(
                Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: GestureDetector(
                        onTap: () async {
                          await HapticFeedback.vibrate();
                          switch (list[index]['collection']) {
                            case 'cars':
                              Get.to(() => IndexCar(item: list[index]));
                              break;
                            case 'houses':
                              Get.to(() => IndexHouse(item: list[index]));
                              break;
                            case 'rapports':
                              Get.to(() => IndexRapport(item: list[index]));
                              break;
                            case 'familles':
                              Get.to(() => IndexFamille(item: list[index]));
                              break;
                            default:
                              Get.to(() => IndexBdd(item: list[index]));
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
                              alignment: Alignment.topCenter,
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
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        height: 50,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ));
  }
}
