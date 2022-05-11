import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/components/custom_image.dart';
import 'package:kdg/utils/utils.dart';
import 'package:logger/logger.dart';

class IndexFamille extends StatefulWidget {
  IndexFamille({Key? key, required this.item}) : super(key: key);
  final Map<String, dynamic> item;
  @override
  _IndexFamilleState createState() => _IndexFamilleState();
}

class _IndexFamilleState extends State<IndexFamille> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> map = <Map<String, dynamic>>[
      {
        'title': 'Famille',
      },
      {
        'title': 'Famille 1',
      },
    ];
    return Scaffold(
      backgroundColor: HexColor.fromHex("FDF8F8"),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: Get.height * .4,
            actions: [
              IconButton(onPressed: () => 1, icon: Icon(Icons.more_vert))
            ],
            stretch: true,
            backgroundColor: HexColor.fromHex("FDF8F8"),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Hero(
                transitionOnUserGestures: true,
                tag: "title${widget.item['text']}",
                child: Text(
                    "${(widget.item['collection'] as String).capitalizeFirst}"),
              ),
              stretchModes: [
                StretchMode.blurBackground,
                StretchMode.fadeTitle
              ],
              background: GestureDetector(
                onVerticalDragEnd: (gf) {
                  Logger().i(gf);
                  Navigator.pop(context);
                },
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(20)),
                  child: Stack(children: [
                    Hero(
                      tag: widget.item['imgsrc'],
                      child: Image.asset(
                        widget.item['imgsrc'],
                        fit: BoxFit.cover,
                        height: Get.height * .45,
                        width: double.infinity,
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 1),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment(0, 1),
                                end: Alignment(0, -1),
                                colors: [
                              Colors.blue.withOpacity(0.2),
                              Colors.transparent
                            ])),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
          SliverAnimatedList(
            // delegate: SliverChildBuilderDelegate(
            //   (ctx, index) {
            //     print(listVehicules);
            //     return CarItem(item: listVehicules[index]);
            //   },
            //   childCount: listVehicules.length,
            // ),
            initialItemCount: map.length,
            itemBuilder: (ctx, int index, Animation<double> animation) {
              return CardItem(
                animation: animation,
                item: index,
              );
            },
          )
        ],
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
    this.onTap,
    this.selected = false,
    required this.animation,
    required this.item,
  })  : assert(item >= 0),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback? onTap;
  final int item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 2.0,
        right: 2.0,
        top: 2.0,
      ),
      child: SizeTransition(
        sizeFactor: animation,
        child: GestureDetector(
          onTap: onTap,
          child: SizedBox(
            height: 80.0,
            child: Card(
              color: selected
                  ? Colors.black12
                  : Colors.primaries[item % Colors.primaries.length],
              child: Center(
                child: Text(
                  'Item $item',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
