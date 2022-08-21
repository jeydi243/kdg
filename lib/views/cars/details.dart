import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kdg/components/pageV.dart';
import 'package:kdg/constantes/values.dart';
import 'package:kdg/models/car.dart';
import 'package:kdg/services/car_service.dart';
import 'package:kdg/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'add_document.dart';

class DetailsCar extends GetView<CarService> {
  DetailsCar(this.car, this.car_id, this.action, {Key? key}) : super(key: key);
  final car_id;
  late List<Map<String, dynamic>> list;
  late ScrollController _sc;
  late PdfViewerController _pdfcontroller;
  VoidCallback action;
  CarService carservice = Get.find();
  Car car;
  PanelController _pc = new PanelController();
  List<Map> actionsDialog = [
    {'text': "Modifier", 'icon': Icons.edit},
    {'text': "Supprimer", 'icon': Icons.voicemail_rounded},
    {'text': "Voir", 'icon': Icons.edit},
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
                        print(carservice.currentCar.value?.documentsID ??
                            "File is null");
                        await showGeneralDialog(
                            context: ctx,
                            barrierDismissible: true,
                            transitionDuration: 500.milliseconds,
                            barrierLabel: "",
                            transitionBuilder: (ctx, anim1, anim2, child) =>
                                BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 4 * anim1.value,
                                      sigmaY: 4 * anim1.value),
                                  child: SizeTransition(
                                    sizeFactor: anim1,
                                    child: child,
                                  ),
                                ),
                            pageBuilder: (g, n, j) {
                              return Container(
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                                child: FractionallySizedBox(
                                  alignment: Alignment.center,
                                  widthFactor: .8,
                                  heightFactor: .8,
                                  child: Column(
                                    children: [
                                      Obx(() => Expanded(
                                            child: SfPdfViewer.network(
                                              carservice
                                                  .currentCar
                                                  .value!
                                                  .documents[e['doc_name']]!
                                                  .file,
                                              canShowScrollStatus: true,
                                              onDocumentLoadFailed: (details) {
                                                carservice.onDocumentLoadFailed(
                                                    details.description);
                                              },
                                              controller: _pdfcontroller,
                                              canShowPasswordDialog: true,
                                              enableDoubleTapZooming: true,
                                            ),
                                          )),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Share.share(
                                                      'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf');
                                                },
                                                child: Text("Partager")),
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.red)),
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: Text("Fermer")),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      child: Container(child: Text('Voir le document'))),
                  TextButton(
                      onPressed: () async {
                        await showGeneralDialog(
                            context: ctx,
                            barrierDismissible: false,
                            transitionDuration: 500.milliseconds,
                            transitionBuilder: (ctx, anim1, anim2, child) =>
                                BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: 4 * anim1.value,
                                      sigmaY: 4 * anim1.value),
                                  child: FadeTransition(
                                    child: child,
                                    opacity: anim1,
                                  ),
                                ),
                            pageBuilder: (g, n, j) {
                              return AddDocument(car.id, e);
                            });
                      },
                      child: Text('Mettre à jour le document')),
                ],
              ),
            ),
          ],
        ));
  }

  @override
  void onInit() {
    // super.onInit();
    _sc = ScrollController();
    _pdfcontroller = PdfViewerController();

    list = [
      {
        "doc_name": 'assurance',
        "doc_id": car.defaultAssurance,
        "isExpanded": false
      },
      {
        "doc_name": 'controle_technique',
        "doc_id": car.defaultControle,
        "isExpanded": false
      },
      {
        "doc_name": 'vignette',
        "doc_id": car.defaultVignette,
        "isExpanded": false
      },
      {
        "doc_name": 'stationnement',
        "doc_id": car.defaultStationnement,
        "isExpanded": false
      },
    ];
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
            tag: car.id,
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
          } else {
            _pc.open();
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
        body: SmartRefresher(
          header: WaterDropHeader(
              waterDropColor: AppColors.accent,
              complete: Text('Updated...'),
              failed: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.close, color: Colors.red),
                  Text("Failed to update")
                ],
              )),
              completeDuration: 2.seconds),
          controller: controller.refreshc2,
          onRefresh: controller.onRefreshDetails,
          onLoading: controller.onLoadingDetails,
          child: ListView(
            controller: _sc,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(bottom: 20),
            children: [
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
              SizedBox(
                  width: Get.width, height: Get.height * .3, child: PageV()),
              Container(
                  height: 250,
                  width: 150,
                  child: Column(
                    children: [
                      Builder(
                        builder: (context) {
                          if (controller.currentCar.value != null) {
                            return Column(
                              children: [
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
                                            "${entry.value?.capitalizeFirst}",
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
                              ],
                            );
                          }
                          return Container();
                        },
                      ),
                    ],
                  )),
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
              Container(
                padding: EdgeInsets.only(bottom: 200),
                child: ExpansionPanelList(
                  animationDuration: 1.seconds,
                  dividerColor: HexColor.fromHex("#000"),
                  expandedHeaderPadding: EdgeInsets.all(0),
                  elevation: 0,
                  children: [
                    ...list
                        .mapIndexed((i, e) => ExpansionPanel(
                              isExpanded: e["isExpanded"],
                              backgroundColor: Color.fromARGB(255, 1, 48, 105),
                              body: Actions(context, e),
                              headerBuilder: (ctx, bool isExpanded) => ListTile(
                                tileColor: isExpanded
                                    ? Color.fromARGB(255, 1, 67, 148)
                                    : Color.fromARGB(255, 1, 48, 105),
                                onTap: () {
                                  e["isExpanded"] = !e["isExpanded"];
                                  // setState(() {});
                                },
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${(e["doc_name"] as String).capitalizeFirst}",
                                      style: Get.textTheme.headline4!
                                          .copyWith(color: AppColors.accent),
                                    ),
                                    Text(
                                      'Expire dans ${20 + Random().nextInt(30)} jours',
                                      style: Get.textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ],
                  expansionCallback: (int item, bool status) {
                    // Get.snackbar("Title $item", "Message $status");
                    showAnimatedDialog(
                      context: context,
                      barrierDismissible: true,
                      axis: Axis.vertical,
                      alignment: Alignment.center,
                      builder: (BuildContext context) {
                        return Container(
                          width: Get.width,
                          color: AppColors.backgroundDark,
                          child: FractionallySizedBox(
                            heightFactor: 0.5,
                            widthFactor: .8,
                            alignment: Alignment.center,
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
                          ),
                        );
                      },
                      animationType: DialogTransitionType.size,
                      curve: Curves.fastOutSlowIn,
                      duration: Duration(seconds: 1),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
