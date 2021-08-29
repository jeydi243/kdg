import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/components/custom_image.dart';
import 'package:kdg/models/maison.dart';
import 'package:kdg/utils/utils.dart';
import 'package:provider/provider.dart';

class DetailsHouse extends StatefulWidget {
  DetailsHouse({Key key, this.item}) : super(key: key);
  final Map<String, dynamic> item;
  @override
  _DetailsHouseState createState() => _DetailsHouseState();
}

class _DetailsHouseState extends State<DetailsHouse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex('#EEF2F6'),
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
              title: Text(widget.item['collection']),
              stretchModes: [StretchMode.blurBackground, StretchMode.fadeTitle],
              background: GestureDetector(
                onVerticalDragEnd: (gf) {
                  Navigator.pop(context);
                },
                child: Stack(children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20)),
                    child: Hero(
                      tag: widget.item['imgsrc'],
                      child: Image.asset(
                        widget.item['imgsrc'],
                        fit: BoxFit.cover,
                        height: Get.height * .45,
                        width: double.infinity,
                      ),
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, index) {
                return Text('Details Maisons');
              },
              childCount: 5,
            ),
          )
        ],
      ),
    );
  }
}
