import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdg/components/pageV.dart';
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
  late ScrollController _scrollController;
  PanelController _pc = new PanelController();
  Map<String, dynamic> infos = {
    "Color": "Brown",
    "Brand": "Audi Q5",
    "Model": "Quatttro 2.0",
    "Year": "2009",
    "Type carburant": "Essence",
    "Price": "\$\$\$",
  };
  List<Map<String, dynamic>> messages = [
    {
      "sender": "KDG19",
      "comment": "Hello, how are you?",
      "date": DateTime.now()
    },
    {
      "sender": "Jeydi243",
      "comment":
          "Hello, how are you? Nostrud dolor adipisicing fugiat ut officia laboris tempor aliqua pariatur ex ea nostrud ipsum irure.",
      "date": DateTime.now()
    },
    {
      "sender": "Logan Bowen",
      "comment": "Hello, how are you?",
      "date": DateTime.now(),
      "img": null
    },
    {
      "sender": "Randall Harris",
      "comment": "Hello, how are you?",
      "date": DateTime.now()
    },
    {
      "sender": "Sadie Dean",
      "comment": "Hello, how are you?",
      "date": DateTime.now(),
      "link": "http://gesal.no/kufufhet"
    },
    {
      "sender": "Tony Jones",
      "comment": "Hello, how are you?",
      "img": "assets/rapport.jpg",
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
  Widget chat(String sender, String comment, DateTime date,
      {String? img, String? link}) {
    return Container(
      width: Get.width,
      height: 60,
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
                decoration: BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage("assets/deux.jpg")),
                    borderRadius: BorderRadius.circular(5)),
                height: 35,
                child: Text(comment))
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

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (1 == 1) {}
      if (_scrollController.position.pixels == 0) {
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
    print(_scrollController.position.maxScrollExtent >
        _scrollController.position.pixels);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '${widget.car.Nom}',
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
          controller: _scrollController,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(bottom: 20),
          children: [
            SizedBox(width: Get.width, height: Get.height * .4, child: PageV()),
            // Hero(
            //     tag: widget.car.id,
            //     child: Image.asset(
            //       "assets/epa.jpg",
            //       fit: BoxFit.cover,
            //       height: Get.height * .3,
            //       width: Get.width,
            //     )),
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
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              // Text('$index'),
                              Container(
                                // color: Colors.red,
                                child: Center(
                                  child: Text(
                                    entry.key,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                              Text(entry.value)
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
            ExpansionPanelList(
              animationDuration: Duration(milliseconds: 1000),
              dividerColor: HexColor.fromHex("#000"),
              expandedHeaderPadding: EdgeInsets.all(0),
              elevation: 0,
              children: [
                ...list
                    .map((e) => ExpansionPanel(
                          isExpanded: e["isExpanded"],
                          canTapOnHeader: true,
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
                              handlechange();
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
                print('LE monde est beau');
              },
            )
          ],
        ),
      ),
    );
  }
}
