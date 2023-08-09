import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/constantes/values.dart';
import 'package:kdg/services/car_service.dart';
import 'package:kdg/views/cars/add_car.dart';
import 'package:kdg/views/cars/item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:supercharged/supercharged.dart';

class IndexCar extends StatefulWidget {
  IndexCar({Key? key, required this.item}) : super(key: key);
  final Map<String, dynamic> item;
  @override
  _IndexCarState createState() => _IndexCarState();
}

class _IndexCarState extends State<IndexCar> with TickerProviderStateMixin {
  late AnimationController controller;
  late PanelController _pc;
  bool isPanelOpen = false;
  @override
  void initState() {
    _pc = new PanelController();
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
    CarService controller = Get.find();

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (isPanelOpen) {
            _pc.close();
            setState(() {
              isPanelOpen = false;
            });
          } else {
            _pc.open();
            setState(() {
              isPanelOpen = true;
            });
          }
        },
      ),
      body: SlidingUpPanel(
        controller: _pc,
        // parallaxOffset: .5,
        backdropOpacity: .5,
        backdropColor: AppColors.transparentDark,
        borderRadius: BorderRadius.circular(20),
        defaultPanelState: PanelState.CLOSED,
        backdropTapClosesPanel: true,
        collapsed: Container(),
        header: Container(),
        parallaxEnabled: true,
        isDraggable: true,
        minHeight: 0,
        backdropEnabled: true,
        panel: Container(
          color: AppColors.backgroundDark,
          child: ListView(padding: EdgeInsets.all(0), children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ajouter un véhicule',
                      style: Get.textTheme.displaySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          _pc.close();
                        },
                        icon: Icon(Icons.close))
                  ]),
            ),
            AddCar()
          ]),
        ),
        body: SmartRefresher(
          enablePullDown: true,
          header: WaterDropHeader(
              waterDropColor: AppColors.accent,
              complete: Text('Updated...'),
              failed: Container(
                color: Colors.red,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.close, color: Colors.red),
                    Text(
                      "Failed to update",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )),
              ),
              completeDuration: 2.seconds),
          controller: controller.refreshc,
          onRefresh: controller.onRefreshListCar,
          onLoading: controller.onLoadingListCar,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: Get.height * .3,
                toolbarHeight: Get.height * .04,
                actions: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
                ],
                stretch: true,
                collapsedHeight: Get.height * .05,
                backgroundColor: AppColors.backgroundDark,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.parallax,
                  title: Hero(
                      transitionOnUserGestures: true,
                      tag: "title${widget.item['text']}",
                      child: Text(
                          "${(widget.item['collection'] as String).capitalizeFirst}",
                          style: TextStyle(fontSize: 25, color: Colors.white))),
                  stretchModes: [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                    StretchMode.fadeTitle
                  ],
                  background: GestureDetector(
                    onVerticalDragEnd: (gf) {
                      Navigator.pop(context);
                    },
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(10)),
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
                                  AppColors.transparent
                                ])),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
              SliverAnimatedList(
                initialItemCount: controller.cars.length,
                itemBuilder: (ctx, int i, Animation<double> an) {
                  return CarItem(i);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
