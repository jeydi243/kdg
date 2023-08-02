import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/constantes/values.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
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
        color: Theme.of(context).scaffoldBackgroundColor,
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
        body: Container(
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: Get.height * .35,
                actions: [
                  IconButton(onPressed: () => 1, icon: Icon(Icons.more_vert))
                ],
                stretch: true,
                collapsedHeight: Get.height * .10,
                onStretchTrigger: () async {
                  print("onStretchTrigger... ");
                },
                stretchTriggerOffset: 52,
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
                      // closedColor: AppColors.backgroundDark,
                      closedColor: Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(.5),
                      openColor: Theme.of(context).scaffoldBackgroundColor,
                      openBuilder: (context, action) {
                        return DetailsHouse(widget.item);
                      },
                      closedBuilder: (context, void Function() action) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          width: Get.width * .70,
                          color: AppColors.backgroundDark.withOpacity(.5),
                          height: 75,
                          child: InkWell(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CTP-0012548 $index',
                                ),
                                Text(
                                  'Détails Houses $index',
                                  style: TextStyle(fontSize: 11),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
