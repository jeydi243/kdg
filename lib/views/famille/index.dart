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
    List<Map<String, dynamic>> map = <Map<String, dynamic>>[];
    return Scaffold(
      backgroundColor: HexColor.fromHex("FDF8F8"),
      body: SafeArea(
        child: CustomScrollView(
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
                title: Text(
                    "${(widget.item['collection'] as String).capitalizeFirst}"),
                stretchModes: [
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle
                ],
                background: GestureDetector(
                  onVerticalDragEnd: (gf) {
                    Logger().i(gf);
                    Navigator.pop(context);
                  },
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(20)),
                      child: Hero(
                        tag: widget.item['imgsrc'],
                        child: Image.asset(
                          widget.item['imgsrc'],
                          fit: BoxFit.cover,
                          height: Get.height * .45,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment(0, 1),
                                    end: Alignment(0, -1),
                                    colors: [
                                  HexColor.fromHex("FDF8F8").withOpacity(.3),
                                  Colors.transparent
                                ]))),
                      ),
                    ),
                  ]),
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
              itemBuilder: (BuildContext context, int index,
                  Animation<double> animation) {
                return Text("Details familles");
              },
            )
          ],
        ),
      ),
    );
  }
}
