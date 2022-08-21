import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kdg/models/car.dart';
import 'package:kdg/services/car_service.dart';
import 'package:kdg/views/cars/details.dart';

class CarItem extends StatefulWidget {
  CarItem(
      {Key? key,
      required this.index,
      this.color = const Color.fromARGB(255, 1, 48, 105)})
      : super(key: key);
  final int index;
  Color color;
  @override
  _CarItemState createState() => _CarItemState();
}

class _CarItemState extends State<CarItem> {
  CarService carservice = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Car car = carservice.cars[widget.index];
    // carservice.cars.firstWhere((car) => car.id == widget.car_id);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: OpenContainer(
        transitionDuration: 2.seconds,
        closedElevation: 0,
        transitionType: ContainerTransitionType.fade,
        middleColor: Color.fromARGB(255, 1, 48, 105),
        closedColor: Color.fromARGB(255, 1, 48, 105),
        openBuilder: (context, action) {
          return DetailsCar(car, car.id, action);
        },
        closedBuilder: (ctx, action) => ListTile(
          onLongPress: () async {
            await HapticFeedback.heavyImpact();
          },
          enableFeedback: true,
          contentPadding: EdgeInsets.only(left: 10),
          style: ListTileStyle.list,
          tileColor: widget.color,
          onTap: () {
            carservice.setCurrentCarId = car.id;
            action();
          },
          title: Hero(
            tag: car.id,
            child: Text(
              car.Nom.capitalizeFirst!,
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
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
            ],
          ),
        ),
      ),
    );
  }
}
