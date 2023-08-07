import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BudgetView extends StatefulWidget {
  const BudgetView({Key? key}) : super(key: key);

  @override
  _BudgetViewState createState() => _BudgetViewState();
}

class _BudgetViewState extends State<BudgetView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 255, 175, 1),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Monthly Spending",
            style: TextStyle(
                color: Colors.black,
                fontSize: 55,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.montserrat().fontFamily),
          ),
          Stack(
            fit: StackFit.expand,
            textDirection: TextDirection.ltr,
            children: [
              Align(
                alignment: Alignment(0, -0.55),
                child: Container(
                  height: 100,
                  width: Get.width,
                  alignment: Alignment.topCenter,
                  child: Text(
                    "\$ 2023.10",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.montserrat().fontFamily),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.3),
                child: Container(
                  height: 100,
                  width: Get.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(244, 255, 175, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                ),
              ),
            ],
            alignment: Alignment.center,
          ),
        ],
      )),
    );
  }
}
