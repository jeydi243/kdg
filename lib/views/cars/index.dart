import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/services/car_service.dart';
import 'package:kdg/utils/utils.dart';
import 'package:kdg/views/cars/item.dart';
import 'package:logger/logger.dart';

class IndexCar extends StatefulWidget {
  IndexCar({Key? key, required this.item}) : super(key: key);
  final Map<String, dynamic> item;
  @override
  _IndexCarState createState() => _IndexCarState();
}

class _IndexCarState extends State<IndexCar> with TickerProviderStateMixin {
  late AnimationController controller;

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
    CarService carservice = Get.find();
    return Scaffold(
      backgroundColor: HexColor.fromHex("FDF8F8"),
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
                  child: Text(widget.item['collection'],
                      style: TextStyle(fontSize: 25, color: Colors.white))),
              stretchModes: [StretchMode.blurBackground, StretchMode.fadeTitle],
              background: GestureDetector(
                onVerticalDragEnd: (gf) {
                  Logger().i(gf);
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
            initialItemCount: carservice.cars.length,
            itemBuilder: (BuildContext context, int i, Animation<double> an) {
              return CarItem(
                item: carservice.cars[i],
              );
            },
          )
        ],
      ),
    );
  }
}
