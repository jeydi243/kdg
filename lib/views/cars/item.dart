import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kdg/models/car.dart';
import 'package:kdg/views/cars/details.dart';

class CarItem extends StatefulWidget {
  CarItem({Key? key, required this.item, this.color = Colors.white})
      : super(key: key);
  final Car item;
  Color color;
  @override
  _CarItemState createState() => _CarItemState();
}

class _CarItemState extends State<CarItem> {
  late List<Map<String, dynamic>> list;
  @override
  void initState() {
    Car car = widget.item;
    list = [
      {"doc": 'assurance', "value": car.defaultAssurance},
      {"doc": 'controle', "value": car.defaultControle},
      {"doc": 'vignette', "value": car.defaultVignette},
      {"doc": 'stationnement', "value": car.defaultStationnement},
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Car car = widget.item;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: OpenContainer(
        transitionDuration: 1.seconds,
        closedElevation: 0,
        openBuilder: (context, action) {
          return DetailsCar(car, action);
          // return DetailsCar(car, action);
        },
        closedBuilder: (ctx, action) => ListTile(
          enableFeedback: true,
          contentPadding: EdgeInsets.only(left: 10),
          style: ListTileStyle.list,
          tileColor: widget.color,
          onTap: () {
            action();
          },
          // leading: SizedBox(
          //     height: Get.height * .07,
          //     width: Get.height * .07,
          //     child: Hero(
          //       tag: car.id,
          //       child: Image.asset(
          //         "assets/epa.jpg",
          //         fit: BoxFit.cover,
          //       ),
          //     )),
          title: Text(
            car.Nom.capitalizeFirst!,
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          subtitle: Text("Type carburant: ${car.type_carburant}"),
          trailing: Column(
            children: [
              IconButton(
                  onPressed: () => 1,
                  icon: Icon(
                    FontAwesomeIcons.check,
                    color: Colors.green,
                  )),
              // Text(
              //   'Ok',
              //   style: TextStyle(fontSize: 10),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
