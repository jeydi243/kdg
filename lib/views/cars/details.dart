import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdg/components/pageV.dart';
import 'package:kdg/constantes/values.dart';
import 'package:kdg/models/car.dart';
import 'package:kdg/services/car_service.dart';
import 'package:kdg/services/user_service.dart';
import 'package:kdg/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DetailsCar extends StatefulWidget {
  DetailsCar(this.car, this.action, {Key? key}) : super(key: key);
  final Car car;
  VoidCallback action;
  @override
  _DetailsCarState createState() => _DetailsCarState();
}

class _DetailsCarState extends State<DetailsCar> {
  CarService carservice = Get.find();
  late List<Map<String, dynamic>> list;
	TextEditingController start_date = TextEditingController();
	TextEditingController end_date = TextEditingController();
  late ScrollController _sc;
  late PdfViewerController _pdfcontroller;
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
  PanelController _pc = new PanelController();
  List<Map> actionsDialog = [
    {'text': "Modifier", 'icon': Icons.edit},
    {'text': "Supprimer", 'icon': Icons.voicemail_rounded},
    {'text': "Voir", 'icon': Icons.edit},
    {'text': "Supprimer", 'icon': Icons.delete},
  ];
  Map<String, dynamic> infos = {
    "Color": "Brown",
    "Brand": "Audi Q5",
    "Model": "Quattro 2.0",
    "Year": "2009",
    "Type carburant": "Essence",
    "Price": "\$\$\$",
  };

  List<types.Message> messages = [
    // {
    //   "sender": "KDG19",
    //   "comment": "Hello, how are you?",
    //   "date": DateTime.now()
    // },
    // {
    //   "sender": "Jeydi243",
    //   "comment":
    //       "Hello, how are you? Nostrud dolor adipisicing fugiat ut officia laboris tempor aliqua pariatur ex ea nostrud ipsum irure.",
    //   "date": DateTime.now()
    // },
    // {
    //   "sender": "Logan Bowen",
    //   "comment": "Hello, how are you?",
    //   "date": DateTime.now(),
    //   "img": null
    // },
    // {
    //   "sender": "Randall Harris",
    //   "comment": "Hello, how are you?",
    //   "date": DateTime.now()
    // },
    // {
    //   "sender": "Sadie Dean",
    //   "comment": "Hello, how are you?",
    //   "date": DateTime.now(),
    //   "link": "http://gesal.no/kufufhet"
    // },
    // {
    //   "sender": "Tony Jones",
    //   "comment": "Hello, how are you?",
    //   "img": "assets/rapport.jpg",
    //   "date": DateTime.now()
    // },
    // {
    //   "sender": "Violet Atkins",
    //   "comment": "Hello, how are you?",
    //   "date": DateTime.now()
    // },
    // {
    //   "sender": "Olivia Daniel",
    //   "comment": "Hello, how are you?",
    //   "date": DateTime.now()
    // },
    // {
    //   "sender": "Bernard Ingram",
    //   "comment": "Hello, how are you?",
    //   "date": DateTime.now()
    // },
    // {
    //   "sender": "Mildred Marshall",
    //   "comment": "Hello, how are you?",
    //   "date": DateTime.now()
    // },
    // {
    //   "sender": "Josephine Foster",
    //   "comment": "Hello, how are you?",
    //   "date": DateTime.now()
    // },
    // {
    //   "sender": "Adelaide Turner",
    //   "comment": "Hello, how are you?",
    //   "date": DateTime.now()
    // },
    // {
    //   "sender": "Charlie Thomas",
    //   "comment": "Hello, how are you?",
    //   "date": DateTime.now()
    // },
    // {
    //   "sender": "Jerry Griffith",
    //   "comment": "Hello, how are you?",
    //   "date": DateTime.now()
    // }
  ];
  Widget chat(String sender, String comment, DateTime date,
      {String? img, String? link}) {
    return Container(
      width: Get.width,
      height: img == null ? 60 : 160,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sender,
                  style: GoogleFonts.courgette(
                      color: Color.fromARGB(255, 0, 156, 57)),
                ),
                Text("${date.toLocal().hour}:${date.toLocal().minute}",
                    style: GoogleFonts.courgette(
                        fontSize: 12, color: Color.fromARGB(255, 0, 43, 64))),
              ],
            ),
            Container(
                margin: EdgeInsets.only(left: 5),
                width: Get.width,
                padding: EdgeInsets.only(left: 5),
                height: 35,
                child: Column(
                  children: [
                    Text(comment),
                  ],
                ))
          ]),
    );
  }

  Widget actions(BuildContext ctx, String link) {
    UserService userService = Get.find();
    return Container(
        height: Get.height * .3,
        width: Get.width * .9,
        // padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text("Activer les notifications d'echéance")),
                  TextButton(
                      onPressed: () {
                        showGeneralDialog(
                            context: context,
                            barrierDismissible: true,
                            transitionDuration: 1.seconds,
                            barrierLabel: "Okay",
                            pageBuilder: (g, n, j) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: FractionallySizedBox(
                                  alignment: Alignment.center,
                                  widthFactor: .8,
                                  heightFactor: .8,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: SfPdfViewer.network(
                                          'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
                                          canShowScrollStatus: true,
                                          currentSearchTextHighlightColor:
                                              Color.fromARGB(
                                                  255, 252, 248, 249),
                                          onDocumentLoaded: (detailsLoaded) {},
                                          onDocumentLoadFailed: (details) {
                                            carservice.onDocumentLoadFailed(
                                                details.description);
                                          },
                                          controller: _pdfcontroller,
                                          canShowPasswordDialog: true,
                                          enableDoubleTapZooming: true,
                                        ),
                                      ),
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
                      onPressed: () {
                        showGeneralDialog(
                            context: context,
                            barrierDismissible: true,
                            transitionDuration: 1.seconds,
                            barrierLabel: "Okay",
                            pageBuilder: (g, n, j) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: FractionallySizedBox(
                                  alignment: Alignment.center,
                                  widthFactor: .8,
                                  heightFactor: .8,
                                  child: Form(
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: start_date,
                                          decoration: InputDecoration(
                                              label: Text("Debut de l")),
                                        ),
                                        TextFormField(
                                          controller: end_date,
                                          decoration: InputDecoration(
                                              label: Text("Nom")),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Text('Mettre à jour le document')),
                ],
              ),
            ),
          ],
        ));
  }

  Widget connaissance(
    BuildContext ctx,
  ) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(vertical: Get.height / 4),
      content: Container(
        child: Form(
            child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: "Dite quelque chose"),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Ajouter'),
            )
          ],
        )),
      ),
    );
  }

  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  @override
  void initState() {
    super.initState();
    _sc = ScrollController();
    _pdfcontroller = PdfViewerController();
    _sc.addListener(() {
      if (1 == 1) {}
      if (_sc.position.pixels == 0) {
        print("top");
      } else {
        print("bottom");
      }
    });
    Car car = widget.car;
    list = [
      {"doc": 'assurance', "value": car.defaultAssurance, "isExpanded": false},
      {
        "doc": 'controle technique',
        "value": car.defaultControle,
        "isExpanded": false
      },
      {"doc": 'vignette', "value": car.defaultVignette, "isExpanded": false},
      {
        "doc": 'stationnement',
        "value": car.defaultStationnement,
        "isExpanded": false
      },
    ];
  }

  handlechange() {
    if (_sc.position.maxScrollExtent > _sc.position.pixels) {
      _sc.animateTo(
        _sc.position.maxScrollExtent,
        duration: 1.seconds,
        curve: Curves.easeOutBack,
      );
    }
  }

  void _addMessage(types.Message message) {
    setState(() {
      messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    _addMessage(textMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '${widget.car.Nom.capitalizeFirst}',
          style: TextStyle(fontSize: 25),
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
        panel: Chat(
          hideBackgroundOnEmojiMessages: true,
          messages: messages,
          onSendPressed: _handleSendPressed,
          user: _user,
        ),
        body: ListView(
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
            SizedBox(width: Get.width, height: Get.height * .4, child: PageV()),
            Container(
                // color: Colors.blue,
                height: 250,
                width: 150,
                child: Column(
                  children: [
                    ...infos.entries
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                entry.key,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: index % 2 != 0
                                        ? AppColors.textDark
                                        : Colors.blue[50],
                                    fontSize: 15),
                              ),
                              Text(
                                entry.value,
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
                    }),
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
                            body:
                                actions(context, e['value']["file"]! as String),
                            headerBuilder: (ctx, bool isExpanded) => ListTile(
                              tileColor: isExpanded
                                  ? Color.fromARGB(255, 1, 67, 148)
                                  : Color.fromARGB(255, 1, 48, 105),
                              onTap: () {
                                handlechange();
                                setState(() {
                                  e["isExpanded"] = !e["isExpanded"];
                                });
                              },
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${(e['doc'] as String).capitalizeFirst}",
                                    style: Get.textTheme.headline4!
                                        .copyWith(color: AppColors.accent),
                                  ),
                                  Text(
                                    'Expire dans : ${20 + i} jours',
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
    );
  }
}
