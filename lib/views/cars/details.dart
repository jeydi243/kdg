import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kdg/components/pageV.dart';
import 'package:kdg/constantes/values.dart';
import 'package:kdg/services/car_service.dart';
import 'package:kdg/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../animations/fadein_fromleft.dart';
import '../../animations/fadein_fromright.dart';
import '../../components/viewerpdf.dart';
import 'add_document.dart';

class DetailsCar extends StatefulWidget {
  DetailsCar(this.action, {Key? key}) : super(key: key);
  VoidCallback action;
  @override
  _DetailsCarState createState() => _DetailsCarState();
}

class _DetailsCarState extends State<DetailsCar> {
  CarService carservice = Get.find();
  late List<Map<String, dynamic>> list;
  late ScrollController _sc;
  late PdfViewerController _pdfcontroller;
  PanelController _pc = new PanelController();
  List<Map> actionsDialog = [
    {'text': "Modifier", 'icon': Icons.edit},
    {'text': "Voir le document", 'icon': Icons.edit},
    {'text': "Supprimer", 'icon': Icons.delete},
  ];

  Widget Actions(BuildContext ctx, Map<String, dynamic> e) {
    return Container(
        height: Get.height * .3,
        width: Get.width * .9,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text("Activer les notifications d'echéance")),
                  TextButton(
                      onPressed: () async {
                        var link =
                            carservice.currentCar.value!.linkDoc(e['doc_name']);
                        Get.to(() => ViewerPDF(link));
                      },
                      child: Container(child: Text('Voir le document'))),
                  TextButton(
                      onPressed: () async {
                        Get.to(() =>
                            AddDocument(carservice.currentCar.value!.id, e));
                        // await showGeneralDialog(
                        //     context: context,
                        //     barrierDismissible: false,
                        //     transitionDuration: 500.milliseconds,
                        //     transitionBuilder: (ctx, anim1, anim2, child) =>
                        //         BackdropFilter(
                        //           filter: ImageFilter.blur(
                        //               sigmaX: 4 * anim1.value,
                        //               sigmaY: 4 * anim1.value),
                        //           child: FadeTransition(
                        //             child: child,
                        //             opacity: anim1,
                        //           ),
                        //         ),
                        //     pageBuilder: (g, n, j) {
                        //       return AddDocument(
                        //           carservice.currentCar.value!.id, e);
                        //     });
                      },
                      child: Text('Mettre à jour le document')),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    _sc = ScrollController();
    _pdfcontroller = PdfViewerController();
  }

  @override
  Widget build(BuildContext context) {
    CarService controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.bell, size: 20),
            onPressed: () {
              // showDialog(context: context, builder: (ctx) => connaissance(ctx));
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        title: Obx(
          () => Hero(
            tag: carservice.currentCarId.value,
            child: Text(
              '${controller.currentCar.value?.Nom.capitalizeFirst}',
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_pc.isPanelOpen) {
            _pc.close();
            setState(() {});
          } else {
            _pc.open();
            setState(() {});
          }
        },
      ),
      body: SlidingUpPanel(
        controller: _pc,
        parallaxOffset: .5,
        backdropOpacity: .5,
        backdropColor: Colors.black,
        borderRadius: BorderRadius.circular(20),
        defaultPanelState: PanelState.CLOSED,
        backdropTapClosesPanel: true,
        collapsed: Container(),
        header: Container(),
        parallaxEnabled: true,
        isDraggable: true,
        minHeight: 0,
        backdropEnabled: true,
        panel: Column(
          children: [
            Text("Ni mambo"),
          ],
        ),
        body: ListView(
          controller: _sc,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: 20),
          children: [
            FadeInLeft(
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Text(
                      "Gallerie",
                      style: TextStyle(
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            FadeInRight(
              SizedBox(
                  width: Get.width, height: Get.height * .3, child: PageV()),
            ),
            FadeInLeft(
              Container(
                  // color: Colors.blue,
                  height: 250,
                  width: 150,
                  child: Column(
                    children: [
                      Builder(builder: (context) {
                        if (controller.currentCar.value != null) {
                          return Column(children: <Widget>[
                            ...controller.currentCar.value!.infos.entries
                                .toList()
                                .mapIndexed<Widget>((index, entry) {
                              return Container(
                                height: 35,
                                color: index % 2 == 0
                                    ? Colors.transparent
                                    : Colors.blue[50],
                                child: InkWell(
                                  onTap: () {},
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        "${entry.key.capitalizeFirst}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: index % 2 != 0
                                                ? AppColors.textDark
                                                : Colors.blue[50],
                                            fontSize: 15),
                                      ),
                                      Text(
                                        "${entry.value.capitalizeFirst}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: index % 2 != 0
                                                ? AppColors.textDark
                                                : Colors.blue[50],
                                            fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            })
                          ]);
                        }
                        return Container();
                      }),
                    ],
                  )),
            ),
            FadeInRight(
              Container(
                padding: EdgeInsets.only(left: 10, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      "Documents",
                      style: TextStyle(
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            FadeInLeft(
              Container(
                padding: EdgeInsets.only(bottom: 200),
                child: ExpansionPanelList(
                  animationDuration: 1.seconds,
                  dividerColor: HexColor.fromHex("#000"),
                  expandedHeaderPadding: EdgeInsets.all(0),
                  elevation: 0,
                  children: [
                    ...controller.list
                        .mapIndexed((i, e) => ExpansionPanel(
                              isExpanded: e["isExpanded"],
                              backgroundColor: AppColors.dark2,
                              body: Actions(context, e),
                              headerBuilder: (ctx, isExp) {
                                print(e);
                                var dayLeft = carservice.currentCar.value!
                                    .dayLeft(e['doc_name']);
                                return ListTile(
                                  tileColor:
                                      isExp ? AppColors.dark1 : AppColors.dark2,
                                  onTap: () async {
                                    setState(() {
                                      e["isExpanded"] = !isExp;
                                    });
                                  },
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${(e["doc_name"] as String).capitalizeFirst}",
                                        style: Get.textTheme.headline4!
                                            .copyWith(color: AppColors.accent),
                                      ),
                                      Text(
                                        'Expire dans ${dayLeft} jours',
                                        style: Get.textTheme.bodyText2,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ))
                        .toList(),
                  ],
                  expansionCallback: (int item, bool status) async {
                    await showAnimatedDialog(
                      context: context,
                      barrierDismissible: true,
                      axis: Axis.vertical,
                      alignment: Alignment.centerRight,
                      builder: (BuildContext context) {
                        return FractionallySizedBox(
                          heightFactor: 0.4,
                          widthFactor: .8,
                          alignment: Alignment.centerRight,
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            child: ListView(
                              children: [
                                ...actionsDialog
                                    .map((e) => ListTile(
                                          onTap: () {
                                            print('Le ');
                                          },
                                          title: Text(e['text']),
                                        ))
                                    .toList()
                              ],
                            ),
                          ),
                        );
                      },
                      animationType: DialogTransitionType.size,
                      curve: Curves.fastOutSlowIn,
                      duration: Duration(seconds: 1),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
