import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:swipe_deck/swipe_deck.dart';
import 'package:vector_math/vector_math.dart' as math;

class DetailsHouse extends StatefulWidget {
  DetailsHouse(
    this.item, {
    Key? key,
  }) : super(key: key);
  final Map<String, dynamic> item;
  @override
  State<DetailsHouse> createState() => _DetailsHouseState();
}

class _DetailsHouseState extends State<DetailsHouse> {
  List<String> images = ["assets/deux.jpg", "assets/quatre.jpg"];

  @override
  Widget build(BuildContext context) {
    BoxDecoration _rowsdecoration = BoxDecoration(
        border: Border(right: BorderSide(color: Colors.amber, width: 2)));
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAnimatedDialog(
            context: context,
            barrierDismissible: true,
            axis: Axis.vertical,
            alignment: Alignment.center,
            builder: (BuildContext context) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Image.asset(
                          "assets/deux.jpg",
                          height: 200,
                          width: Get.width * .8,
                        ))
                  ],
                ),
              );
              return ClassicGeneralDialogWidget(
                titleText: 'Title',
                contentText: 'content',
                onPositiveClick: () {
                  Navigator.of(context).pop();
                },
                onNegativeClick: () {
                  Navigator.of(context).pop();
                },
              );
            },
            animationType: DialogTransitionType.size,
            curve: Curves.fastOutSlowIn,
            duration: Duration(seconds: 1),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SwipeDeck(
              // aspectRatio: 16 / 9,
              widgets: [
                ...images
                    .map<Widget>((name) => ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          name,
                          fit: BoxFit.fill,
                          height: 200,
                          width: 100,
                        )))
                    .toList()
              ],
            ),
            Table(
              children: [
                TableRow(
                    decoration: _rowsdecoration,
                    children: [Text('Locataire actuel'), Text('Le mondes')]),
                TableRow(
                    decoration: _rowsdecoration,
                    children: [Text('Dernier loyé payé'), Text('Janvier')]),
                TableRow(
                    decoration: _rowsdecoration,
                    children: [Text('Adresse'), Text('Le mondes')]),
                TableRow(
                    decoration: _rowsdecoration,
                    children: [Text('Facts'), Text('Le mondes')]),
              ],
            )
          ]),
    );
  }
}
