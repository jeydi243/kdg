import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:kdg/animations/fadein.dart';
import 'package:kdg/animations/fadein_fromleft.dart';
import 'package:kdg/components/custom_grid.dart';
import 'package:kdg/services/user_service.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    UserService us = Get.find();
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInLeft(
                Text("Hi, ${us.userKDG?.nom ?? 'Kadiongo Ilunga'}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                delay: 1,
              ),
              FadeInLeft(
                Text(us.currentUser?.email ?? 'ilungakadiongo@gmail.com',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.normal)),
                delay: 2,
              )
            ],
          ),
          elevation: 0,
          actions: [
            FadeInLeft(
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () => Get.toNamed('/profile'),
                    child: Hero(
                      tag: "Profil",
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/epa.jpg"),
                        radius: 20,
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
                  ),
                ),
                delay: 3)
          ],
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //     items: list
        //         .map<BottomNavigationBarItem>(
        //           (map) => BottomNavigationBarItem(
        //               label: "${map['text']}", icon: Icon(Icons.abc_outlined)),
        //         )
        //         .toList(),
        //     currentIndex: 0),
        body: CustomGrid());
  }
}
