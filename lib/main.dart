import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kdg/models/maison.dart';
import 'package:kdg/models/rapport.dart';
import 'package:kdg/models/vehicule.dart';
import 'package:kdg/services/vehicule_service.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
import 'package:kdg/services/user_service.dart';
import 'package:kdg/views/home.dart';
import 'package:kdg/views/splash_screen.dart';
import 'package:kdg/utils/circle_trans.dart';
import 'package:kdg/views/login.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
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
        // ChangeNotifierProvider<VehiculeService>(
        //   create: (_) => VehiculeService(),
        //   lazy: false,
        // ),
        StreamProvider<List<Vehicule>>.value(
          // create: (_) => VehiculeService().listenCar,
          initialData: <Vehicule>[],
          lazy: false,
          value: VehiculeService().listenCar,
          catchError: (context, error) {
            Logger().e("Error lors du retrieve: $error ");
            return <Vehicule>[];
          },
        ),
        // StreamProvider<List<Maison>>.value(
        //   value: VehiculeService().listenHouse,
        //   initialData: <Maison>[],
        //   catchError: (context, error) {
        //     Logger().e("Error lors du retrieve: $error ");
        //     return <Maison>[];
        //   },
        //   lazy: false,
        // ),
        // StreamProvider<List<Rapport>>.value(
        //   value: VehiculeService().listenRapports,
        //   initialData: <Rapport>[],
        //   lazy: false,
        //   catchError: (context, error) {
        //     Logger().e("Error lors du retrieve: $error");
        //     return <Rapport>[];
        //   },
        // ),
        // StreamProvider<List<Map<String, dynamic>>>.value(
        //   value: VehiculeService().listenBdd,
        //   initialData: <Map<String, dynamic>>[],
        //   lazy: false,
        //   catchError: (context, error) {
        //     Logger().e("Error lors du retrieve: $error");
        //     return <Map<String, dynamic>>[];
        //   },
        // ),
      ],
      child: GetMaterialApp(
          title: 'Kdg',
          debugShowCheckedModeBanner: false,
          // customTransition: CircleTrans(),
          builder: BotToastInit(),
          home: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxHeight == Get.height) {
                return StreamBuilder<User>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SplashScreen(
                        nextPage: Home(),
                      );
                    } else {
                      return SplashScreen(
                        nextPage: Home(),
                      );
                    }
                  },
                );
              }
              return StreamBuilder<User>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Home();
                  } else {
                    return Login();
                  }
                },
              );
            },
          )),
    );
  }
}
