// Import the generated file
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kdg/views/user/login.dart';
import 'package:kdg/views/user/profile.dart';
import 'constantes/values.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kdg/services/car_service.dart';
import 'package:get/get.dart';
import 'package:kdg/services/user_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.instance.setAutoInitEnabled(true);
    Get.put<CarService>(CarService());
    Get.put<UserService>(UserService());
    runApp(Kdg());
  } on FirebaseException catch (e, stack) {
    FirebaseCrashlytics.instance.recordError(e, stack);
  }
}

class Kdg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kdg',
      routes: {
        '/profile': (context) => Profile(),
        // '/about': (context) => Profile(),
        // '/rapport': (context) => Profile(),
      },
      darkTheme: KDGTheme.dark(context),
      theme: KDGTheme.light(context),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: Login(),
      // customTransition: CircleTrans(),
      // home: LayoutBuilder(
      //   builder: (context, constraints) {
      //     if (constraints.maxHeight == Get.height) {
      //       return StreamBuilder<User>(
      //         stream: FirebaseAuth.instance.authStateChanges(),
      //         builder: (context, snapshot) {
      //           if (snapshot.hasData && snapshot.data is User) {
      //             return SplashScreen(
      //               nextPage: Home(),
      //             );
      //           } else {
      //             return SplashScreen(
      //               nextPage: Login(
      //                 title: '55',
      //               ),
      //             );
      //           }
      //         },
      //       );
      //     }
      //     return StreamBuilder<User>(
      //       stream: FirebaseAuth.instance.onAuthStateChanged,
      //       builder: (context, snapshot) {
      //         if (snapshot.hasData && snapshot.data is User) {
      //           return Home();
      //         } else {
      //           return Login(
      //             title: '52',
      //           );
      //         }
      //       },
      //     );
      //   },
      // )
    );
  }
}
