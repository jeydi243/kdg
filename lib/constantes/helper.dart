import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kdg/constantes/values.dart';
import 'package:kdg/utils/utils.dart';

class Helper {
  static Widget divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 30,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 2,
                color: HexColor.fromHex("#1CBFE2"),
              ),
            ),
          ),
          Text(
            'ou',
            style: TextStyle(
                color: AppColors.second, fontSize: AppSizes.textFontSize),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 2,
                color: HexColor.fromHex("#1CBFE2"),
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
        ],
      ),
    );
  }

  static Widget topCardWidget(String imagePath) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Gros con',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            //SizedBox(height: 15),
            Text(
              'The Rock',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
        SizedBox(height: 15),
        Text(
          'He asks, what your name is. But!',
          style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  static Widget bottomCardWidget() {
    return Text(
      'It doesn\'t matter \nwhat your name is.',
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.center,
    );
  }

  static void showSnack(
      {required String title,
      required String message,
      Duration? duration,
      String? to,
      TextButton? main}) {
    Get.snackbar(title, message,
        borderRadius: 10,
        snackStyle: SnackStyle.FLOATING,
        colorText: AppColors.text,
        backgroundColor: AppColors.black,
        duration: duration ?? 3.seconds,
        onTap: (snack) {},
        mainButton: main);
  }

  static Future<bool> isInternetAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
