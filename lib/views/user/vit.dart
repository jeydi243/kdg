import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Vit extends StatefulWidget {
  Vit({Key? key}) : super(key: key);

  @override
  State<Vit> createState() => _VitState();
}

class _VitState extends State<Vit> with SingleTickerProviderStateMixin {
  List<String>? someImages = ["assets/epa.jpg"];
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<AlignmentGeometry> _animation = Tween<AlignmentGeometry>(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ),
  );
  @override
  void initState() {
    super.initState();
    _initImages();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        height: Get.height * 2,
        child: Row(
          children: [
            Container(
              height: Get.height * 2,
              width: Get.width / 3,
              child: AlignTransition(
                alignment: _animation,
                child: ListView(children: [
                  ...someImages!.map((img) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            '$img',
                            fit: BoxFit.cover,
                            height: Get.height / 3,
                            width: Get.width / 3,
                          ),
                        ),
                      )),
                ]),
              ),
            ),
            Container(
              height: Get.height * 2,
              width: Get.width / 3,
              child: ListView(children: [
                SizedBox(height: 40),
                ...someImages!.reversed.toList().map((img) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          '$img',
                          fit: BoxFit.cover,
                          height: Get.height / 3,
                          width: Get.width / 3,
                        ),
                      ),
                    )),
              ]),
            ),
            Column(children: [
              // SizedBox(height: 80),
              ...someImages!.map((img) => Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        '$img',
                        fit: BoxFit.cover,
                        height: Get.height / 3,
                        width: Get.width / 3,
                      ),
                    ),
                  )),
            ]),
          ],
        ),
      ),
    );
  }

  Future _initImages() async {
    final manifestContent = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    print(manifestMap);
    final imagePaths =
        manifestMap.keys.where((String key) => key.contains('.jpg')).toList();

    setState(() {
      someImages = imagePaths;
      print({imagePaths});
    });
  }
}
