import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/utils/utils.dart';
import 'package:kdg/views/houses/details.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class IndexHouse extends StatefulWidget {
  IndexHouse({Key? key, required this.item}) : super(key: key);
  final Map<String, dynamic> item;
  @override
  _IndexHouseState createState() => _IndexHouseState();
}

class _IndexHouseState extends State<IndexHouse> {
  PanelController _pc = new PanelController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _pc.open(),
      ),
      body: SlidingUpPanel(
        controller: _pc,
        backdropOpacity: .5,
        backdropColor: Colors.black,
        borderRadius: BorderRadius.circular(10),
        defaultPanelState: PanelState.CLOSED,
        collapsed: Container(),
        header: Container(),
        parallaxEnabled: true,
        isDraggable: true,
        minHeight: 0,
        backdropEnabled: true,
        panel: Center(
          child: Text("This is the sliding Widget"),
        ),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: Get.height * .35,
              actions: [
                IconButton(onPressed: () => 1, icon: Icon(Icons.more_vert))
              ],
              stretch: true,
              collapsedHeight: Get.height * .30,
              onStretchTrigger: () async {
                print("onStretchTrigger... ");
              },
              stretchTriggerOffset: 52,
              backgroundColor: HexColor.fromHex("FDF8F8"),
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                expandedTitleScale: 2,
                centerTitle: true,
                title: Hero(
                  transitionOnUserGestures: true,
                  tag: "title${widget.item['text']}",
                  child: Text(
                      "${(widget.item['collection'] as String).capitalizeFirst}"),
                ),
                stretchModes: [
                  StretchMode.blurBackground,
                  StretchMode.zoomBackground
                ],
                background: GestureDetector(
                  onVerticalDragEnd: (gf) {
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, index) {
                  return OpenContainer(
                    transitionDuration: 900.milliseconds,
                    openElevation: 0,
                    closedElevation: 0,
                    openBuilder: (context, action) {
                      return DetailsHouse(widget.item);
                    },
                    closedBuilder: (context, void Function() action) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        width: Get.width * .70,
                        color: Colors.teal,
                        height: 45,
                        child: InkWell(
                          onTap: action,
                          child: Text('Détails Maisons $index'),
                        ),
                      );
                    },
                  );
                },
                childCount: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
