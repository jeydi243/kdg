import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/models/vehicule.dart';
import 'package:kdg/services/user_service.dart';
import 'package:kdg/utils/utils.dart';
import 'package:provider/provider.dart';

class DetailsCar extends StatefulWidget {
  DetailsCar(this.car, {Key? key}) : super(key: key);
  final Vehicule car;
  @override
  _DetailsCarState createState() => _DetailsCarState();
}

class _DetailsCarState extends State<DetailsCar> {
  late List<Map<String, dynamic>> list;

  @override
  void initState() {
    super.initState();
    Vehicule car = widget.car;
    list = [
      {"doc": 'assurance', "value": car.assurance, "isExpanded": false},
      {
        "doc": 'controle technique',
        "value": car.assurance,
        "isExpanded": false
      },
      {"doc": 'vignette', "value": car.assurance, "isExpanded": false},
      {"doc": 'stationnement', "value": car.assurance, "isExpanded": false},
    ];
  }

  Widget actions(BuildContext ctx, String link) {
    UserService userService = Provider.of<UserService>(context, listen: false);
    return Container(
        height: Get.height * .3,
        width: Get.width * .9,
        // padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text(
              'Actions',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  TextButton(
                      onPressed: () {
                        userService.notifyMe();
                      },
                      child: Text("Activer les notifications d'echéance")),
                  TextButton(
                      onPressed: () {
                        
                      },
                      child: Text('Voir le document')),
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
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
            ExpansionPanelList(
              animationDuration: Duration(milliseconds: 1000),
              dividerColor: HexColor.fromHex("#000"),
              children: [
                ...list
                    .map((e) => ExpansionPanel(
                          isExpanded: e["isExpanded"],
                          body: actions(context, e['value']["file"] as String),
                          headerBuilder:
                              (BuildContext context, bool isExpanded) =>
                                  ListTile(
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
