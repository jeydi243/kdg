import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/animations/fadein_fromleft.dart';
import 'package:kdg/components/custom_grid.dart';
import 'package:kdg/services/user_service.dart';
import 'package:secure_application/secure_gate.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
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
            FadeInLeft(
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: InkWell(
                    onTap: () => Get.toNamed('/profile'),
                    child: Hero(
                      tag: "Profil",
                      child: CircleAvatar(
                        // backgroundImage: AssetImage("assets/epa.jpg"),
                        backgroundImage: CachedNetworkImageProvider(
                          us.firebaseUser.value!.photoURL ?? '',
                        ),
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
                delay: .9)
          ],
        ),
        body: SecureGate(
            blurr: 10,
            lockedBuilder: (context, secure) => Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      child: Text('UNLOCK'),
                      onPressed: () => secure?.authSuccess(unlock: true),
                    ),
                    ElevatedButton(
                      child: Text('FAIL AUTHENTICATION'),
                      onPressed: () => secure?.authFailed(unlock: true),
                    ),
                  ],
                )),
            child: CustomGrid()));
  }
}
