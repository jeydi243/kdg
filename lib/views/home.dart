import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:kdg/animations/fadein.dart';
import 'package:kdg/animations/flipIn.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:kdg/services/service.dart';
import 'package:kdg/views/details.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);
    Service service = Provider.of<Service>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                    'https://randomuser.me/api/?gender=female'),
              ),
            )
          ],
        ),
        body: SafeArea(
            child: Container(
                height: Get.height,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: FadeIn(
                          dur: .2,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      hintText: ("Rechercher une information"),
                                      isDense: true,
                                      focusedBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.all(8),
                                    ),
                                  ),
                                )
                              ]),
                        ),
                      ),
                      ...service.tabs.entries
                          .map(
                            (entry) => Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: GestureDetector(
                                onTap: () => Get.to(Details(
                                  cle: entry,
                                )),
                                child: FadeIn(
                                  dur: 0.1,
                                  child: Material(
                                    type: MaterialType.canvas,
                                    shadowColor: Colors.blueAccent,
                                    elevation: 5,
                                    child: Container(
                                      height: Get.height / 5,
                                      width: Get.width,
                                      child: ClipRRect(
                                        child: Hero(
                                          tag: entry.key,
                                          child: Image.asset(
                                            service.tabs[entry.key]['img'],
                                            gaplessPlayback: true,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),

                      // FadeIn(
                      //   dur: .6,
                      //   child: Container(
                      //     height: Get.height / 5,
                      //     width: Get.width,
                      //     child: ClipRRect(
                      //       child: Image.asset(
                      //         'assets/dix.jpg',
                      //         fit: BoxFit.cover,
                      //       ),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //   ),
                      // ),
                      // FadeIn(
                      //   dur: .8,
                      //   child: Container(
                      //     height: Get.height / 5,
                      //     width: Get.width,
                      //     child: ClipRRect(
                      //       child: Image.asset(
                      //         'assets/cinq.jpg',
                      //         fit: BoxFit.cover,
                      //       ),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //   ),
                      // ),
                      // FadeIn(
                      //   dur: 1,
                      //   child: Container(
                      //     height: Get.height / 5,
                      //     width: Get.width,
                      //     child: ClipRRect(
                      //       child: Image.asset(
                      //         'assets/deux.jpg',
                      //         fit: BoxFit.fitWidth,
                      //       ),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //   ),
                      // ),
                      // FadeIn(
                      //   dur: 1.2,
                      //   child: Container(
                      //     height: Get.height / 5,
                      //     width: Get.width,
                      //     child: ClipRRect(
                      //       child: Image.asset(
                      //         'assets/un.jpg',
                      //         fit: BoxFit.fitWidth,
                      //       ),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ))));
  }
}
