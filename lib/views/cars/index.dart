import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/components/viewerpdf.dart';
import 'package:kdg/services/car_service.dart';
import 'package:kdg/utils/utils.dart';
import 'package:kdg/views/cars/item.dart';
import 'package:logger/logger.dart';
import '../../models/car.dart';

class IndexCar extends StatefulWidget {
  IndexCar({Key? key, required this.item}) : super(key: key);
  final Map<String, dynamic> item;
  @override
  _IndexCarState createState() => _IndexCarState();
}

class _IndexCarState extends State<IndexCar> with TickerProviderStateMixin {
  late AnimationController controller;
  CarService carservice = Get.find();
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
    return Scaffold(
      backgroundColor: HexColor.fromHex("FDF8F8"),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Get.dialog(Center(
            //     child: SizedBox(
            //         height: 20,
            //         width: 20,
            //         child: CircularProgressIndicator(
            //           strokeWidth: 2,
            //         ))));
            Get.to(() => ViewerPDF());
          },
          child: Icon(Icons.add)),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: Get.height * .4,
            toolbarHeight: Get.height * .05,
            actions: [
              IconButton(onPressed: () => 1, icon: Icon(Icons.more_vert))
            ],
            stretch: true,
            collapsedHeight: Get.height * .05,
            backgroundColor: HexColor.fromHex("FDF8F8"),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Hero(
                  transitionOnUserGestures: true,
                  tag: "title${widget.item['text']}",
                  child: Text(
                      "${(widget.item['collection'] as String).capitalizeFirst}",
                      style: TextStyle(fontSize: 25, color: Colors.white))),
              stretchModes: [StretchMode.blurBackground, StretchMode.fadeTitle],
              background: GestureDetector(
                onVerticalDragEnd: (gf) {
                  Logger().i(gf);
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
          SliverAnimatedList(
            initialItemCount: carservice.cars.length,
            itemBuilder: (ctx, int i, Animation<double> an) {
              // if (10) {
              // return Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //   child: Container(
              //     width: Get.width * .8,
              //     height: 60,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color: Colors.accents[i % Colors.accents.length],
              //     ),
              //     child: Text('$i '),
              //   ),
              // );
              // }
              return CarItem(
                item: carservice.cars[i],
              );
            },
          ),
        ],
      ),
    );
  }
}
