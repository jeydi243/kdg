// Import the generated file
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdg/services/vehicule_service.dart';
import 'package:kdg/utils/utils.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
import 'package:kdg/services/user_service.dart';
import 'package:kdg/views/home.dart';
import 'package:kdg/views/splash_screen.dart';
import 'package:kdg/views/login.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(Kdg());
  } on FirebaseException catch (e) {
    Logger().w(e.toString());
  }
}

class Kdg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserService>(
          create: (_) => UserService(),
          lazy: false,
        ),
        ChangeNotifierProvider<VehiculeService>(
          create: (_) => VehiculeService(),
          lazy: false,
        ),
      ],
      child: GetMaterialApp(
          title: 'Kdg',
          theme: ThemeData(
              textTheme: GoogleFonts.k2dTextTheme(),
              backgroundColor: HexColor.fromHex("#FDF8F8"),
              dialogBackgroundColor: HexColor.fromHex("#FDF8F8"),
              dialogTheme: DialogTheme(
                  backgroundColor: HexColor.fromHex("#FDF8F8"),
                  titleTextStyle: Theme.of(context).textTheme.bodyText2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              inputDecorationTheme: InputDecorationTheme(),
              textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(0)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.blue[100]!.withOpacity(0.2)),
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(Get.width * .9, Get.height * .05))),
              )),
          debugShowCheckedModeBanner: false,
          // customTransition: CircleTrans(),
          home: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxHeight == Get.height) {
                return StreamBuilder<FirebaseUser>(
                  stream: FirebaseAuth.instance.onAuthStateChanged,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data is FirebaseUser) {
                      return SplashScreen(
                        nextPage: Home(),
                      );
                    } else {
                      return SplashScreen(
                        nextPage: Login(title: '55',),
                      );
                    }
                  },
                );
              }
              return StreamBuilder<FirebaseUser>(
                stream: FirebaseAuth.instance.onAuthStateChanged,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data is FirebaseUser) {
                    return Home();
                  } else {
                    return Login(title: '52',);
                  }
                },
              );
            },
          )),
    );
  }
}
