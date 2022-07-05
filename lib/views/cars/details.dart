import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdg/models/car.dart';
import 'package:kdg/services/user_service.dart';
import 'package:kdg/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DetailsCar extends StatefulWidget {
  DetailsCar(this.car, this.action, {Key? key}) : super(key: key);
  final Car car;
  VoidCallback action;
  @override
  _DetailsCarState createState() => _DetailsCarState();
}

class _DetailsCarState extends State<DetailsCar> {
  late List<Map<String, dynamic>> list;
//map for car info
  Map<String, dynamic> infos = {
    "Color": "Brown",
    "Brand": "Audi Q5",
    "Model": "Quatttro 2.0",
    "Year": "2009",
    "Price": "\$\$\$",
    "Description": "La description de la audi"
  };
  List<Map<String, dynamic>> messages = [
    {
      "sender": "KDG19",
      "comment": "Hello, how are you?",
      "date": DateTime.now()
    },
    {
      "sender": "Jeydi243",
      "comment": "Hello, how are you?",
      "date": DateTime.now()
    },
    {
      "sender": "Logan Bowen",
      "comment": "Hello, how are you?",
      "date": DateTime.now()
    },
    {
      "sender": "Randall Harris",
      "comment": "Hello, how are you?",
      "date": DateTime.now()
    },
    {
      "sender": "Sadie Dean",
      "comment": "Hello, how are you?",
      "date": DateTime.now()
    },
    {
      "sender": "Tony Jones",
      "comment": "Hello, how are you?",
      "date": DateTime.now()
    },
    {
      "sender": "Violet Atkins",
      "comment": "Hello, how are you?",
      "date": DateTime.now()
    },
    {
      "sender": "Olivia Daniel",
      "comment": "Hello, how are you?",
      "date": DateTime.now()
    },
    {
      "sender": "Bernard Ingram",
      "comment": "Hello, how are you?",
      "date": DateTime.now()
    },
    {
      "sender": "Mildred Marshall",
      "comment": "Hello, how are you?",
      "date": DateTime.now()
    },
    {
      "sender": "Josephine Foster",
      "comment": "Hello, how are you?",
      "date": DateTime.now()
    },
    {
      "sender": "Adelaide Turner",
      "comment": "Hello, how are you?",
      "date": DateTime.now()
    },
    {
      "sender": "Charlie Thomas",
      "comment": "Hello, how are you?",
      "date": DateTime.now()
    },
    {
      "sender": "Jerry Griffith",
      "comment": "Hello, how are you?",
      "date": DateTime.now()
    }
  ];
  Widget chat(String sender, String comment, DateTime date) {
    return Container(
      width: Get.width,
      height: 50,
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
                      color: Color.fromARGB(255, 0, 43, 64)),
                ),
                Text("${date.toLocal().hour}:${date.toLocal().minute}",
                    style: GoogleFonts.courgette(
                        color: Color.fromARGB(255, 0, 43, 64))),
              ],
            ),
            Container(
                padding: EdgeInsets.only(left: 10),
                color: Colors.grey[50],
                width: Get.width,
                child: Text(comment))
          ]),
    );
  }

  @override
  void initState() {
    super.initState();
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

  Widget actions(BuildContext ctx, String link) {
    UserService userService = Get.find();
    return Container(
        height: Get.height * .3,
        width: Get.width * .9,
        // padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text(
              'Actions',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text("Activer les notifications d'echéance")),
                  TextButton(onPressed: () {}, child: Text('Voir le document')),
                  TextButton(
                      onPressed: () {
                        Get.dialog(
                          connaissance(context),
                          transitionDuration: 500.milliseconds,
                          useSafeArea: true,
                        );
                      },
                      child: Text('Ajouter une connaissance')),
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

  PanelController _pc = new PanelController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
        panel: ListView(
          physics: BouncingScrollPhysics(),
          cacheExtent: 150,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            Text("This is the sliding Widget"),
            ...messages
                .map<Widget>((e) => chat(e['sender'], e['comment'], e['date']))
                .toList()
          ],
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Hero(
                tag: widget.car.id,
                child: Image.asset(
                  "assets/epa.jpg",
                  fit: BoxFit.cover,
                  height: Get.height * .3,
                  width: Get.width,
                )),
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
                        color: index % 2 == 0 ? Colors.white : Colors.blue[50],
                        child: InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // Text('$index'),
                              Text(entry.key),
                              Text(entry.value)
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                )),
            ExpansionPanelList(
              animationDuration: Duration(milliseconds: 1000),
              dividerColor: HexColor.fromHex("#000"),
              children: [
                ...list
                    .map((e) => ExpansionPanel(
                          isExpanded: e["isExpanded"],
                          body: actions(context, e['value']["file"]! as String),
                          backgroundColor:
                              e["isExpanded"] ? Colors.blue[50] : Colors.white,
                          headerBuilder: (ctx, bool isExpanded) => ListTile(
                            enableFeedback: true,
                            iconColor: Colors.blue,
                            tileColor: e["isExpanded"]
                                ? Colors.blue[50]
                                : Colors.white,
                            onTap: () {
                              setState(() {
                                e["isExpanded"] = !e["isExpanded"];
                              });
                            },
                            title:
                                Text("${(e['doc'] as String).capitalizeFirst}"),
                          ),
                        ))
                    .toList(),
              ],
              expansionCallback: (int item, bool status) {
                setState(() {
                  print('LE monde est beau');
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
