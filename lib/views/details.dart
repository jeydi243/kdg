import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/models/car.dart';
import 'package:kdg/services/auth.dart';
import 'package:kdg/services/service.dart';
import 'package:provider/provider.dart';
import 'package:auto_animated/auto_animated.dart';

class Details extends StatefulWidget {
  Details({Key key, this.cle}) : super(key: key);
  final MapEntry<String, dynamic> cle;
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool noData = false;
  ScrollController _scrollController;
  var datas = <Car>[];
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);
    Service service = Provider.of<Service>(context);
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.orangeAccent,
          forceElevated: true,
          centerTitle: false,
          // pinned: false,
          // snap: false,
          floating: true,
          stretch: true,
          expandedHeight: Get.height * .2,
          stretchTriggerOffset: 80,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            stretchModes: [
              StretchMode.zoomBackground,
              StretchMode.fadeTitle,
              StretchMode.blurBackground
            ],
            centerTitle: false,
            title: Text(
              service.tabs[widget.cle.key]['text'],
              textAlign: TextAlign.start,
            ),
            background: Hero(
                tag: widget.cle,
                child: Image.asset(
                  service.tabs[widget.cle.key]['img'],
                  fit: BoxFit.fill,
                )),
          ),
        ),
        // SliverAnimatedList(
        //   initialItemCount: service.tabs.length,
        //   itemBuilder: (context, index, animation) {
        //     var val = service.tabs.entries.toList()[index];
        //     return FadeTransition(
        //       opacity: animation,
        //       child: SlideTransition(
        //           position: Tween<Offset>(
        //             begin: Offset(0, 0.3),
        //             end: Offset.zero,
        //           ).animate(animation),
        //           child: ListTile(
        //             // leading: CachedNetworkImage(
        //             //   imageUrl: val.key as String,
        //             // ),
        //             title: Text("epa eap1"),
        //           )),
        //     );
        //   },
        // ),
        // SliverToBoxAdapter(
        //   child: StreamBuilder(
        //     stream: service.tabs,
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         return LiveList(
        //             itemBuilder: (context, index, animation) {
        //               return FadeTransition(
        //                 opacity: animation,
        //                 child: SlideTransition(
        //                     position: Tween<Offset>(
        //                       begin: Offset(0, 0.3),
        //                       end: Offset.zero,
        //                     ).animate(animation),
        //                     child: ListTile(
        //                       leading: CachedNetworkImage(
        //                         imageUrl: "",
        //                       ),
        //                       title: Text("epa eap"),
        //                     )),
        //               );
        //             },
        //             itemCount: 5);
        //       } else {}
        //     },
        //   ),
        // ),
        LiveSliverList(
          controller: _scrollController,
          itemCount: service.cars.length,
          delay: 1.seconds,
          showItemInterval: 0.5.seconds,
          itemBuilder: (context, index, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(animation),
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: service.cars[index].imgsrc[0],
                      height: 50,
                      width: 50,
                    ),
                    title: Text("epa eap"),
                  )),
            );
          },
        )
      ],
    ));
  }
}
