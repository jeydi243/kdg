import 'package:animations/animations.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kdg/constantes/values.dart';
import 'package:kdg/services/user_service.dart';
import 'package:kdg/utils/utils.dart';
import 'package:logger/logger.dart';

import '../../animations/fadein.dart';
import 'add_etude.dart';

class IndexRapport extends StatefulWidget {
  IndexRapport({Key? key, required this.item}) : super(key: key);
  final Map<String, dynamic> item;
  @override
  _IndexRapportState createState() => _IndexRapportState();
}

class _IndexRapportState extends State<IndexRapport> {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
 


  @override
  Widget build(BuildContext context) {
    UserService userservice = Get.find();
    return Scaffold(
      backgroundColor: HexColor.fromHex('#EEF2F6'),
      floatingActionButton: FabCircularMenu(
          key: fabKey,
          fabChild: Icon(Icons.add),
          ringWidth: 50,
          fabCloseIcon: Icon(Icons.close),
          fabColor: AppColors.backgroundDark,
          ringColor: AppColors.backgroundDark,
          ringDiameter: 250,
          onDisplayChange: (v) {
            print(v);
          },
          children: <Widget>[
            OpenContainer(
              transitionDuration: 900.milliseconds,
              closedColor: Colors.transparent,
              closedBuilder: (BuildContext context, void Function() action) {
                return IconButton(
                    icon: Icon(Icons.account_box),
                    onPressed: () {
                      fabKey.currentState!.close();
                      Get.to(() => AddEtude());
                    });
              },
              openBuilder: (BuildContext context,
                  void Function({Object? returnValue}) action) {
                return AddEtude();
              },
            ),
            IconButton(
                icon: Icon(FontAwesomeIcons.book),
                onPressed: () {
                  fabKey.currentState!.close();
                })
          ]),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: Get.height * .4,
            actions: [
              IconButton(onPressed: () => 1, icon: Icon(Icons.more_vert))
            ],
            stretch: true,
            backgroundColor: HexColor.fromHex("FDF8F8"),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Hero(
                transitionOnUserGestures: true,
                tag: "title${widget.item['text']}",
                child: Text(
                    "${(widget.item['collection'] as String).capitalizeFirst}"),
              ),
              stretchModes: [StretchMode.blurBackground, StretchMode.fadeTitle],
              background: GestureDetector(
                onVerticalDragEnd: (gf) {
                  Navigator.pop(context);
                },
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20)),
                  child: Stack(children: [
                    Hero(
                      tag: widget.item['imgsrc'],
                      child: Image.asset(
                        widget.item['imgsrc'],
                        fit: BoxFit.cover,
                        height: Get.height * .45,
                        width: double.infinity,
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 1),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment(0, 1),
                                end: Alignment(0, -1),
                                colors: [
                              Colors.blue.withOpacity(0.2),
                              Colors.transparent
                            ])),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, index) {
                return Text('Detail reapport');
              },
              childCount: userservice.rapports.length,
            ),
          )
        ],
      ),
    );
  }
}
