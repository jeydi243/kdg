import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../views/bdd/details.dart';
import '../views/cars/index.dart';
import '../views/famille/index.dart';
import '../views/houses/index.dart';
import '../views/projets/index.dart';
import '../views/rapports/index.dart';

class CustomGrid extends StatefulWidget {
  CustomGrid({Key? key}) : super(key: key);

  @override
  State<CustomGrid> createState() => _CustomGridState();
}

class _CustomGridState extends State<CustomGrid> {
  final searchTextController = new TextEditingController();
  ScrollController _controller = ScrollController();
  String query = "";
  List<Map<String, dynamic>> list = <Map<String, dynamic>>[
    {
      "imgsrc": "assets/rapport.jpg",
      "text": "Rapports",
      "collection": "rapports"
    },
    {"imgsrc": "assets/vehicules.webp", "text": "Cars", "collection": "cars"},
    {
      "imgsrc": "assets/maisons.webp", "text": "Houses",
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
    {"imgsrc": "assets/seize.jpg", "text": "Projets", "collection": "projets"},
  ];

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

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
    return AnimationLimiter(
      child: GridView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemCount: list.length,
        scrollDirection: Axis.vertical,
        dragStartBehavior: DragStartBehavior.start,
        shrinkWrap: true,
        controller: _controller,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10),
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            delay: .2.seconds,
            columnCount: list.length,
            child: SlideAnimation(
              verticalOffset: 10,
              curve: Curves.easeInOutExpo,
              child: FadeInAnimation(
                  duration: 1.seconds,
                  child: Stack(
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
                                case 'projets':
                                  Get.to(() => IndexProjet(item: list[index]));
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
                          )),
                      Align(
                        alignment: Alignment(-0.9, .8),
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
                          // height: 50,
                        ),
                      ),
                    ],
                  )),
            ),
          );
        },
      ),
    );
  }
}
