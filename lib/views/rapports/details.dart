import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/components/custom_image.dart';
import 'package:kdg/services/user_service.dart';
import 'package:kdg/utils/utils.dart';

class DetailsRapport extends StatefulWidget {
  DetailsRapport({Key? key, required this.item}) : super(key: key);
  final Map<String, dynamic> item;
  @override
  _DetailsRapportState createState() => _DetailsRapportState();
}

class _DetailsRapportState extends State<DetailsRapport> {
  @override
  Widget build(BuildContext context) {
    UserService userservice = Get.find();
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
              title: Text(
                  "${(widget.item['collection'] as String).capitalizeFirst}"),
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
