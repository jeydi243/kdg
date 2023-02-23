// Import the generated file
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kdg/utils/circle_trans.dart';
import 'package:kdg/views/home.dart';
import 'package:kdg/views/user/profile.dart';
import 'package:local_auth/local_auth.dart';
import 'package:secure_application/secure_application.dart';
import 'components/viewerpdf.dart';
import 'constantes/values.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kdg/services/car_service.dart';
import 'package:get/get.dart';
import 'package:kdg/services/user_service.dart';


void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) => Material(
        child: Container(
            child: Center(
                child: Text('Error: ${details.exceptionAsString}',
                    style: GoogleFonts.k2d(fontSize: 25)))),
      );
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await Hive.initFlutter();
    FirebaseMessaging.instance.setAutoInitEnabled(true);
    Get.put<CarService>(CarService());
    Get.put<UserService>(UserService());
    runApp(Kdg());
  } on FirebaseException catch (e, stack) {
    FirebaseCrashlytics.instance.recordError(e, stack);
  }
}

class Kdg extends StatelessWidget {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(Get.isDarkMode
        ? SystemUiOverlayStyle.dark
        : SystemUiOverlayStyle.light);

    return GetMaterialApp(
      title: 'Kdg',
      initialRoute: '/home',
      routes: {
        '/profile': (context) => Profile(),
        '/home': (context) => Home(),
        '/viewerPDF': (context) => ViewerPDF(),
      },
      darkTheme: KDGTheme.dark(context),
      theme: KDGTheme.light(context),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => SecureApplication(
          nativeRemoveDelay: 900,
          onNeedUnlock: (secure) async {
            final controller = Get.find<UserService>();
            secure?.lockIfSecured();
            if (controller.wasAuthLocally.value) {
              secure?.authSuccess(unlock: true);
            } else {
              secure?.authFailed(unlock: true);
              secure?.open();
            }

            return null;
          },
          onAuthenticationFailed: () async {
            print('auth failed');
          },
          onAuthenticationSucceed: () async {
            print('auth success');
          },
          child: child ??
              Container(
                child: Center(child: Text('Did you bind Widget ?')),
              )),
      customTransition: CircleTrans(),
    );
  }
}

/*
Je VIENS DE TROUVER UNE IDEE GENIALISSIME CARREMENT JE VAIS GARDER LES ANCIENS documents dans une sous collection et
a chaque fois garder le current doc

ex:
 Assurance: {
		debut:...
		fin:...
		dile:...
}

Sous collection oldDocument qui contiendras les anciennes entrées.

 */
