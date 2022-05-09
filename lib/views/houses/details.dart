import 'package:flutter/material.dart';
import 'package:swipe_deck/swipe_deck.dart';

class DetailsHouse extends StatefulWidget {
  DetailsHouse({Key? key}) : super(key: key);

  @override
  State<DetailsHouse> createState() => _DetailsHouseState();
}

class _DetailsHouseState extends State<DetailsHouse> {
  List<String> images = ["assets/deux.jpg", "assets/cinq.jpg"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Column(children: [
        SwipeDeck(
          aspectRatio: 16 / 9,
          widgets: [
            ...images
                .map<Widget>((name) => ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(name)))
                .toList()
          ],
        )
      ]),
    );
  }
}
