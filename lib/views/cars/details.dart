import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kdg/components/preview.dart';
import 'package:kdg/models/vehicule.dart';
import 'package:kdg/services/user_service.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class DetailsCar extends StatefulWidget {
  DetailsCar(this.car, {Key key}) : super(key: key);
  final Vehicule car;
  @override
  _DetailsCarState createState() => _DetailsCarState();
}

class _DetailsCarState extends State<DetailsCar> {
  List<Map<String, dynamic>> list;
  _showDialogAction(BuildContext ctx) {}

  @override
  void initState() {
    super.initState();
    Vehicule car = widget.car;
    list = [
      {"doc": 'assurance', "value": car.assurance},
      {"doc": 'controle', "value": car.assurance},
      {"doc": 'vignette', "value": car.assurance},
      {"doc": 'stationnement', "value": car.assurance},
    ];
  }

  Widget actions(BuildContext ctx, String link) {
    UserService userService = Provider.of<UserService>(context, listen: false);
    return Dialog(
      insetAnimationDuration: 500.milliseconds,
      elevation: 10,
      child: Container(
          height: Get.height / 2,
          width: Get.width * .9,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    userService.notifyMe();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FaIcon(FontAwesomeIcons.bell),
                      Text("Activer les notifications d'echéance"),
                    ],
                  )),
              TextButton(
                  onPressed: () {
                    Get.dialog(
                      PreviewDoc(linkToDoc: link),
                      transitionDuration: 500.milliseconds,
                      useSafeArea: true,
                    );
                  },
                  child: Text('Voir le document')),
              TextButton(
                  onPressed: () {}, child: Text('Ajouter une connaissance')),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Hero(
                tag: widget.car.id,
                child: Image.asset(
                  "assets/epa.jpg",
                  fit: BoxFit.cover,
                  height: Get.height * .3,
                  width: Get.width,
                )),
            ...list
                .map((e) => ListTile(
                      onTap: () {
                        String linkToDoc = e['value']["file"] as String;
                        Get.dialog(
                          actions(context, linkToDoc),
                          transitionDuration: 500.milliseconds,
                          useSafeArea: true,
                        );
                      },
                      title: Text("${(e['doc'] as String).capitalizeFirst}"),
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
