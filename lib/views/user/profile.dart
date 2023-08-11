import 'package:animated_loading_border/animated_loading_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:kdg/constantes/values.dart';
import 'package:kdg/models/rapport.dart';
import 'package:kdg/services/user_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:supercharged/supercharged.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserService userservice = Get.find();
  List<String> items = ['Modifier le Profil', "Deconnexion"];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          foregroundColor: Colors.transparent,
          actions: [
            // DropdownButton(items: items, onChanged: onChanged),
            // Padding(
            //   padding: const EdgeInsets.only(right: 10),
            //   child: DropdownButton(
            //     alignment: Alignment.bottomLeft,
            //     enableFeedback: true,
            //     icon: Icon(Icons.more_vert_outlined, color: Colors.black),
            //     items: items.map<DropdownMenuItem<String>>((String value) {
            //       return DropdownMenuItem<String>(
            //         value: value,
            //         child: value == "Deconnexion"
            //             ? Text(
            //                 value,
            //                 style: TextStyle(color: Colors.red),
            //               )
            //             : Text(value),
            //       );
            //     }).toList(),
            //     onChanged: (String? value) {
            //       if (value == "Deconnexion") {
            //         Future.delayed(2.seconds, (() => userservice.signOut()));
            //       }
            //     },
            //   ),
            // ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              color: AppColors.backgroundDark,
              height: Get.height * .3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: "Profil",
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/epa.jpg"),
                      radius: 50,
                      // child: DropdownButton(
                      //     items: ['Modifier le Profil']
                      //         .map<DropdownMenuItem<String>>((String value) {
                      //   return DropdownMenuItem<String>(
                      //     value: value,
                      //     child: Text(value),
                      //   );
                      // }).toList()),
                    ),
                  ),
                  Text(
                    'Kadiongo ilunga',
                    style: Get.textTheme.titleLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '@_.jeydi',
                    style: Get.textTheme.bodyLarge,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                          elevation: 0,
                          padding: EdgeInsets.only(top: 10),
                          color: Colors.blue,
                          onPressed: () {},
                          child: Text('Modifier le Profil'))
                    ],
                  ),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       Get.toNamed('/budget');
                  //     },
                  //     child: Text('Click')),
                ],
              ),
            ),
            TabBar(tabs: [
              Tab(child: Text('Rapports')),
              Tab(child: Text('Rapports')),
              Tab(child: Text('Rapports'))
            ]),
            Expanded(
              child: TabBarView(children: [
                AnimationLimiter(
                  child: ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: userservice.rapports.length,
                    itemBuilder: (BuildContext context, int index) {
                      Rapport currentRapport = userservice.rapports[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 750),
                        child: SlideAnimation(
                          // verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: ListTile(
                                onTap: () {
                                  showRapportDetails(currentRapport);
                                },
                                tileColor: Color.fromARGB(255, 1, 48, 105),
                                focusColor: Colors.amber,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: .5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      // showActionsDialog(e);
                                    },
                                    icon: Icon(
                                      MdiIcons.dotsVertical,
                                      color: Colors.white,
                                      size: 16,
                                    )),
                                // subtitle: Text('Subtitle... '),
                                title: Text('${currentRapport.mois}'),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  color: Colors.black,
                ),
                Container(
                  color: Colors.red,
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }

  void showRapportDetails(Rapport rapport) async {
    print("On arrive ici");
    await showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      axis: Axis.horizontal,
      alignment: Alignment.center,
      builder: (BuildContext context) {
        return Container(
          alignment: Alignment.center,
          child: FractionallySizedBox(
            heightFactor: 0.5,
            widthFactor: .7,
            alignment: Alignment.bottomCenter,
            child: AnimatedLoadingBorder(
              borderColor: Colors.amber,
              startWithRandomPosition: true,
              borderWidth: 3,
              cornerRadius: 10,
              isTrailingTransparent: false,
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.backgroundDark,
                child: ListView(
                  children: [
                    ...rapport
                        .toMap()
                        .entries
                        .filter(
                          (element) => element.key != 'id',
                        )
                        .map<Widget>((e) => Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${e.key.capitalizeFirst}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text('${e.value}')
                                ],
                              ),
                            )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
      duration: 1.seconds,
    );
  }
}
