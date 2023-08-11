import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInLeft(
                Text(
                  "Hi, ${us.userKDG?.nom ?? 'Kadiongo Ilunga'}",
                ),
                delay: .3,
              ),
              FadeInLeft(
                Text(
                  us.currentUser?.email ?? 'ilungakadiongo@gmail.com',
                ),
                delay: .6,
              )
            ],
          ),
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Hero(
                tag: "Profil",
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed('/profile');
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/epa.jpg"),
                    radius: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: CustomGrid());
  }
}
