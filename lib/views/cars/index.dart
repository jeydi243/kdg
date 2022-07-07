import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/components/viewerpdf.dart';
import 'package:kdg/constantes/values.dart';
import 'package:kdg/services/car_service.dart';
import 'package:kdg/utils/utils.dart';
import 'package:kdg/views/cars/item.dart';
import 'package:logger/logger.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:supercharged/supercharged.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class IndexCar extends StatefulWidget {
  IndexCar({Key? key, required this.item}) : super(key: key);
  final Map<String, dynamic> item;
  @override
  _IndexCarState createState() => _IndexCarState();
}

class _IndexCarState extends State<IndexCar> with TickerProviderStateMixin {
  late AnimationController controller;
  late PanelController _pc;
  CarService carservice = Get.find();
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
    return Scaffold(
      backgroundColor: HexColor.fromHex("FDF8F8"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_pc.isPanelOpen) {
            _pc.close();
          } else {
            _pc.open();
          }
        },
      ),
      body: SlidingUpPanel(
        controller: _pc,
        // parallaxOffset: .5,
        backdropOpacity: .5,
        backdropColor: Colors.white,
        borderRadius: BorderRadius.circular(20),
        defaultPanelState: PanelState.CLOSED,
        backdropTapClosesPanel: true,
        collapsed: Container(),
        header: Container(),
        parallaxEnabled: true,
        isDraggable: true,
        minHeight: 0,
        backdropEnabled: true,
        panel: SafeArea(
          child: Container(
            color: AppColors.backgroundDark,
            child: ListView(padding: EdgeInsets.all(0), children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ajouter un véhicule',
                        style: Get.textTheme.headline3!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          onPressed: () {
                            _pc.close();
                          },
                          icon: Icon(Icons.close))
                    ]),
              ),
              Form(
                  child: Column(
                children: [
                  Container(
                    width: Get.width * .95,
                    padding: EdgeInsets.only(bottom: 5),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nom',
                      ),
                      onChanged: (value) {
                        var e = value;
                      },
                    ),
                  ),
                  Container(
                    width: Get.width * .95,
                    padding: EdgeInsets.only(bottom: 5),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Model',
                      ),
                      onChanged: (value) {
                        var e = value;
                      },
                    ),
                  ),
                  Container(
                    width: Get.width * .95,
                    padding: EdgeInsets.only(bottom: 5),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Type de carburant',
                      ),
                      onChanged: (value) {
                        var e = value;
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      DateTime? echeanceAssurance = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(Duration(days: 60)),
                          lastDate: DateTime.now().add(Duration(days: 365)));
                    },
                    child: Container(
                      width: Get.width * .95,
                      padding: EdgeInsets.only(bottom: 5),
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_month),
                          labelText: 'Date echance Assurance',
                        ),
                        onChanged: (value) {
                          var e = value;
                        },
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      DateTime? echeanceControleTech = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(Duration(days: 60)),
                          lastDate: DateTime.now().add(Duration(days: 365)));
                    },
                    child: Container(
                      width: Get.width * .95,
                      padding: EdgeInsets.only(bottom: 5),
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_month),
                          labelText: 'Date echance Controle Technique',
                        ),
                        onChanged: (value) {
                          var e = value;
                        },
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      DateTime? echeanceControleTech = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(Duration(days: 60)),
                          lastDate: DateTime.now().add(Duration(days: 365)));
                    },
                    child: Container(
                      width: Get.width * .95,
                      padding: EdgeInsets.only(bottom: 5),
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_month),
                          labelText: 'Date echéance Stationnement',
                        ),
                        onChanged: (value) {
                          var e = value;
                        },
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      DateTime? echeanceVignette = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(Duration(days: 60)),
                          lastDate: DateTime.now().add(Duration(days: 365)));
                    },
                    child: Container(
                      width: Get.width * .95,
                      padding: EdgeInsets.only(bottom: 5),
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.calendar_month),
                          labelText: 'Date echéance Vignette',
                        ),
                        onChanged: (value) {
                          var e = value;
                        },
                      ),
                    ),
                  ),
                  // SfDateRangePicker()
                ],
              ))
            ]),
          ),
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: Get.height * .35,
              toolbarHeight: Get.height * .04,
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
                stretchModes: [
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle
                ],
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
                          height: Get.height * .40,
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
      ),
    );
  }
}
