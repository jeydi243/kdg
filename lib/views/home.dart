import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:kdg/animations/fadein.dart';
import 'package:kdg/views/sections1.dart';
import 'package:kdg/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final searchTextController = new TextEditingController();
  String query = "";
  List<String> mymap = <String>[];
  @override
  void initState() {
    super.initState();
    mymap = [
      'assets/un.jpg',
      'assets/deux.jpg',
      'assets/trois.jpg',
      'assets/quatre.jpg',
      'assets/cinq.jpg',
    ];
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SafeArea(
            child: NotificationListener<ScrollNotification>(
                onNotification: (notif) {
                  print(notif);
                  return true;
                },
                child: Container(
                    height: Get.height,
                    child: SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: FadeIn(
                              dur: .2,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: searchTextController,
                                        onChanged: (value) {
                                          setState(() {
                                            query = value;
                                            print(value);
                                          });
                                        },
                                        cursorColor: Colors.amber,
                                        style: TextStyle(
                                          color: Colors.amber[300],
                                        ),
                                        decoration: InputDecoration(
                                          border: null,
                                          prefix: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 8),
                                            child: Icon(FontAwesomeIcons.search,
                                                size: 17),
                                          ),
                                          hintText:
                                              ("Rechercher une information"),
                                          isDense: true,
                                          focusedBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.all(8),
                                        ),
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                          ...mymap.map(
                            (e) => FadeIn(
                              dur: 0.2,
                              child: Material(
                                type: MaterialType.transparency,
                                elevation: 10,
                                child: Container(
                                  height: Get.height / 5,
                                  width: Get.width,
                                  child: ClipRRect(
                                    child: Image.asset(
                                      e,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FadeIn(
                            dur: .6,
                            child: Container(
                              height: Get.height / 5,
                              width: Get.width,
                              child: ClipRRect(
                                child: Image.asset(
                                  'assets/dix.jpg',
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          FadeIn(
                            dur: .8,
                            child: Container(
                              height: Get.height / 5,
                              width: Get.width,
                              child: ClipRRect(
                                child: Image.asset(
                                  'assets/cinq.jpg',
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          FadeIn(
                            dur: 1,
                            child: Container(
                              height: Get.height / 5,
                              width: Get.width,
                              child: ClipRRect(
                                child: Image.asset(
                                  'assets/deux.jpg',
                                  fit: BoxFit.fitWidth,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          FadeIn(
                            dur: 1.2,
                            child: Container(
                              height: Get.height / 5,
                              width: Get.width,
                              child: ClipRRect(
                                child: Image.asset(
                                  'assets/un.jpg',
                                  fit: BoxFit.fitWidth,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )))));
  }
}
