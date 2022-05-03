import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/components/custom_image.dart';
import 'package:kdg/utils/utils.dart';

class DetailsBdd extends StatefulWidget {
  DetailsBdd({Key? key, required this.item}) : super(key: key);
  final Map<String, dynamic> item;
  @override
  _DetailsBddState createState() => _DetailsBddState();
}

class _DetailsBddState extends State<DetailsBdd> {
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
                  CustomImage(
                    imgsrc: widget.item['imgsrc'],
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
                return Text('Details bdd');
              },
              childCount: 10,
            ),
          )
        ],
      ),
    );
  }
}
