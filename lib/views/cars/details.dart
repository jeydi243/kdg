import 'package:animations/animations.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/components/custom_image.dart';
import 'package:kdg/models/vehicule.dart';
import 'package:kdg/services/user_service.dart';
import 'package:kdg/services/vehicule_service.dart';
import 'package:kdg/utils/utils.dart';
import 'package:kdg/views/cars/item.dart';
import 'package:logger/logger.dart';
import 'package:pigment/pigment.dart';
import 'package:provider/provider.dart';

class DetailsCar extends StatefulWidget {
  DetailsCar({Key key, this.item}) : super(key: key);
  final Map<String, dynamic> item;
  @override
  _DetailsCarState createState() => _DetailsCarState();
}

class _DetailsCarState extends State<DetailsCar> with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: 1.seconds);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Vehicule> listVehicules = Provider.of<List<Vehicule>>(context);
    return Scaffold(
      backgroundColor: HexColor.fromHex("FDF8F8"),
      body: SafeArea(
        child: CustomScrollView(
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
                stretchModes: [
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle
                ],
                background: GestureDetector(
                  onVerticalDragEnd: (gf) {
                    Logger().i(gf);
                    Navigator.pop(context);
                  },
                  child: Stack(children: [
                    CustomImage(
                      imgsrc: widget.item['imgsrc'],
                    ),
                    Align(
                      alignment: Alignment(0, 1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment(0, 1),
                                    end: Alignment(0, -1),
                                    colors: [
                                  HexColor.fromHex("FDF8F8").withOpacity(.3),
                                  Colors.transparent
                                ]))),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            SliverAnimatedList(
              // delegate: SliverChildBuilderDelegate(
              //   (ctx, index) {
              //     print(listVehicules);
              //     return CarItem(item: listVehicules[index]);
              //   },
              //   childCount: listVehicules.length,
              // ),
              initialItemCount: listVehicules.length,
              itemBuilder: (BuildContext context, int index,
                  Animation<double> animation) {
                Logger().e('eeeeeeeeeeeeeeeeeeee');
                return CarItem(item: listVehicules[index]);
              },
            )
          ],
        ),
      ),
    );
  }
}
