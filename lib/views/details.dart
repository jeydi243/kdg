import 'package:animations/animations.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/services/user_service.dart';
import 'package:kdg/services/vehicule_service.dart';
import 'package:kdg/utils/utils.dart';
import 'package:kdg/views/cars/item.dart';
import 'package:pigment/pigment.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  Details({Key key, this.imgsrc, this.collection}) : super(key: key);
  final String imgsrc;
  final String collection;
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    VehiculeService vehiculeService = Provider.of<VehiculeService>(context);
    return Scaffold(
      backgroundColor: HexColor.fromHex('#EEF2F6'),
      body: StreamBuilder<List>(
          stream: vehiculeService.get(streamOn: widget.collection),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: Get.height * .4,
                    actions: [
                      IconButton(
                          onPressed: () => 1, icon: Icon(Icons.more_vert))
                    ],
                    stretch: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(widget.collection),
                      stretchModes: [
                        StretchMode.blurBackground,
                        StretchMode.fadeTitle
                      ],
                      background: GestureDetector(
                        onVerticalDragEnd: (gf) {
                          Navigator.pop(context);
                        },
                        child: Stack(children: [
                          SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Hero(
                                tag: widget.imgsrc,
                                child: Image.asset(
                                  widget.imgsrc,
                                  fit: BoxFit.cover,
                                ),
                              )),
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
                    delegate: SliverChildBuilderDelegate((ctx, index) {
                      return CarItem(item: snapshot.data[index]);
                    }, childCount: snapshot.data.length,),
                  )
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              );
            }
            return Container();
          }),
    );
  }
}
