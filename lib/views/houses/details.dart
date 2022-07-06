import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:get/get.dart';
import 'package:swipe_deck/swipe_deck.dart';

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
              cardSpreadInDegrees: 10,
              emptyIndicator: Container(),
              aspectRatio: 1,
              widgets: [
                ...images
                    .map<Widget>((name) => ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: SizedBox(
                          height: 200,
                          width: 70,
                          child: Image.asset(
                            name,
                            fit: BoxFit.cover,
                            height: 200,
                            width: 70,
                          ),
                        )))
                    .toList()
              ],
            ),
            Table(
              border: TableBorder(right: BorderSide(color: Colors.black26)),
              children: [
                TableRow(children: [
                  TableCell(child: Text('Locataire')),
                  TableCell(child: Text('Le mondes'))
                ]),
                TableRow(children: [
                  TableCell(child: Text('Last payed')),
                  TableCell(child: Text('Janvier'))
                ]),
                TableRow(children: [
                  TableCell(child: Text('Adresse')),
                  TableCell(child: Text('Le mondes'))
                ]),
                TableRow(children: [
                  TableCell(child: Text('Facts')),
                  TableCell(child: Text('Le mondes'))
                ]),
              ],
            )
          ]),
    );
  }
}
