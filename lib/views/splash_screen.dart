import 'dart:async';
import 'dart:ui';
import "package:animated_text_kit/animated_text_kit.dart";
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdg/utils/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/constantes/values.dart';

class SplashScreen extends StatefulWidget {
  final Widget nextPage;

  const SplashScreen({Key key, @required this.nextPage}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final colorizeColors = [
    Colors.purple,
    HexColor.fromHex("#2138DB"),
    Colors.pink,
  ];

  final colorizeTextStyle = TextStyle(
    fontSize: 260.0,
    fontFamily: 'K2D',
  );
  List<Map<String, dynamic>> list = <Map<String, dynamic>>[
    {
      "imgsrc": "assets/epa.jpg",
      "align": [0.0, -0.9]
    },
    {
      "imgsrc": "assets/epa.jpg",
      "align": [0.9, -0.4]
    },
    {
      "imgsrc": "assets/epa.jpg",
      "align": [0.60, 0.8]
    },
    {
      "imgsrc": "assets/epa.jpg",
      "align": [-0.60, 0.8]
    },
    {
      "imgsrc": "assets/epa.jpg",
      "align": [-0.9, -0.4]
    },
    {
      "imgsrc": "assets/epa.jpg",
      "align": [0.0, 0.0]
    },
  ];
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () => Get.offAll(widget.nextPage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue,
      body: SafeArea(
        child: Stack(
          children: [
            // SizedBox(
            //   height: Get.width,
            //   child: Stack(
            //     fit: StackFit.expand,
            //     children: <Widget>[
            //       Align(
            //           alignment: Alignment(0, 0),
            //           child: CircleAvatar(
            //               backgroundImage: AssetImage("assets/melissa.jpg"))),
            //       ...list.map((element) {
            //         return Align(
            //           alignment:
            //               Alignment(element['align'][0], element['align'][1]),
            //           child: PhysicalModel(
            //             color: Colors.transparent,
            //             shadowColor: Colors.pink,
            //             shape: BoxShape.circle,
            //             elevation: 8.0,
            //             child: CircleAvatar(
            //                 radius: 40,
            //                 backgroundImage: AssetImage(element["imgsrc"])),
            //           ),
            //         );
            //       }).toList(),
            //     ],
            //   ),
            // ),
            // Center(
            //   child: RotatedBox(
            //     quarterTurns: 1,
            //     child: AnimatedTextKit(
            //       repeatForever: true,
            //       animatedTexts: [
            //         ColorizeAnimatedText(
            //           'KDG',
            //           textStyle: colorizeTextStyle,
            //           speed: 3.seconds,
            //           colors: colorizeColors,
            //         ),
            //       ],
            //       isRepeatingAnimation: true,
            //       onTap: () {
            //         print("Tap Event");
            //       },
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: Get.height / 2,
            //   width: Get.width / 2,
            //   child: SvgPicture.asset("assets/logo.svg",
            //       semanticsLabel: 'Acme Logo', color: Colors.lightBlueAccent),
            // ),
            Center(
              child: SizedBox(
                height: Get.height / 2,
                width: Get.width / 2,
                child: Image.asset("assets/logo.png"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
