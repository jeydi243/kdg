import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/services/user_service.dart';
import 'package:kdg/views/home.dart';
import 'package:kdg/views/user/ModifierPassword.dart';
import 'package:provider/provider.dart';
import 'user/signup.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bezierContainer.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPassword = false;

  @override
  Widget build(BuildContext context) {
    UserService userService = Provider.of<UserService>(context);

    return Scaffold(
        body: SafeArea(
      child: Container(
        height: Get.height,
       
      ),
    ));
  }
}
