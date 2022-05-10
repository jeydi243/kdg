import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/utils/utils.dart';
import 'package:kdg/views/houses/details.dart';

class IndexHouse extends StatefulWidget {
  IndexHouse({Key? key, required this.item}) : super(key: key);
  final Map<String, dynamic> item;
  @override
  _IndexHouseState createState() => _IndexHouseState();
}

class _IndexHouseState extends State<IndexHouse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#EEF2F6'),
// floatingActionButton: ,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: Get.height * .4,
            actions: [
              IconButton(onPressed: () => 1, icon: Icon(Icons.more_vert))
            ],
            stretch: true,
            collapsedHeight: Get.height * .35,
            onStretchTrigger: () async {
              print("onStretchTrigger... ");
            },
            stretchTriggerOffset: 92,
            backgroundColor: HexColor.fromHex("FDF8F8"),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                  "${(widget.item['collection'] as String).capitalizeFirst}"),
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
                return OpenContainer(
                  transitionDuration: 900.milliseconds,
                  openBuilder: (context, action) {
                    return DetailsHouse(widget.item);
                  },
                  closedBuilder: (context, void Function() action) {
                    return InkWell(
                      onTap: action,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5),
                        width: Get.width * .95,
                        height: 45,
                        child: Text('Details Maisons $index'),
                      ),
                    );
                  },
                );
              },
              childCount: 15,
            ),
          )
        ],
      ),
    );
  }
}