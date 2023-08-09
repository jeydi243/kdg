import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BudgetView extends StatefulWidget {
  const BudgetView({Key? key}) : super(key: key);

  @override
  _BudgetViewState createState() => _BudgetViewState();
}

class _BudgetViewState extends State<BudgetView> {
  AlignmentGeometry? alignment = Alignment.topCenter;
  AlignmentGeometry? alignment2 = Alignment.topCenter;
  AlignmentGeometry? alignment3 = Alignment.topCenter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 255, 175, 1),
      body: SafeArea(
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Monthly Spending",
              style: TextStyle(
                  color: Colors.black,
                  overflow: TextOverflow.clip,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.poppins().fontFamily),
            ),
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                textDirection: TextDirection.ltr,
                children: [
                  Align(
                    alignment: Alignment(0, -0.75),
                    child: AnimatedContainer(
                      duration: 1.seconds,
                      curve: Curves.fastEaseInToSlowEaseOut,
                      height: 150,
                      width: Get.width,
                      alignment: alignment,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            alignment = alignment == Alignment.center
                                ? Alignment.centerLeft
                                : Alignment.center;
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\$ 4 800",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 55,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: GoogleFonts.poppins().fontFamily),
                            ),
                            Text(
                              "Education",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: GoogleFonts.poppins().fontFamily),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, -0.40),
                    child: AnimatedContainer(
                      duration: 1.seconds,
                      curve: Curves.fastOutSlowIn,
                      height: 150,
                      width: Get.width,
                      alignment: alignment2,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            alignment2 = alignment2 == Alignment.center
                                ? Alignment.centerRight
                                : Alignment.center;
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\$ 2 300",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 55,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: GoogleFonts.poppins().fontFamily),
                            ),
                            Text(
                              "Food",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: GoogleFonts.poppins().fontFamily),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(244, 255, 175, 1),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, -0.05),
                    child: Container(
                      height: 150,
                      width: Get.width,
                      alignment: Alignment.topCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\$ 2 500",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 55,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily),
                          ),
                          Text(
                            "Transport",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.poppins().fontFamily),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                              topRight: Radius.circular(15))),
                    ),
                  ),
                ],
                alignment: Alignment.center,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Total \$',
                  style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: GoogleFonts.poppins().fontFamily),
                ),
                Text(
                  'Total \$',
                  style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: GoogleFonts.poppins().fontFamily),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
