import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/services/user_service.dart';
import 'package:pigment/pigment.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<String> items = ['Modifier le Profil', "Deconnexion"];
  UserService userservice = Get.find();
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
              height: Get.height * .40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: "Profil",
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/epa.jpg"),
                      radius: 60,
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
                    style: Get.textTheme.bodyText1,
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
