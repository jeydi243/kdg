// Import the generated file
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kdg/components/custom_grid.dart';
import 'package:kdg/utils/circle_trans.dart';
import 'package:kdg/views/home.dart';
import 'package:kdg/views/user/login.dart';
import 'package:kdg/views/user/profile.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:local_auth/local_auth.dart';
import 'package:secure_application/secure_application.dart';
import 'constantes/values.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kdg/services/car_service.dart';
import 'package:get/get.dart';
import 'package:kdg/services/user_service.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

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
    Get.put<UserService>(UserService());
    Get.put<CarService>(CarService());
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
      routes: {
        '/profile': (context) => Profile(),
      },
      darkTheme: KDGTheme.dark(context),
      theme: KDGTheme.light(context),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      builder: (context, child) => SecureApplication(
          nativeRemoveDelay: 800,
          onNeedUnlock: (secure) async {
            try {
              final bool didAuth = await auth.authenticate(
                  localizedReason: 'Please authenticate to ',
                  options: const AuthenticationOptions(
                    useErrorDialogs: false,
                  ),
                  authMessages: <AuthMessages>[
                    AndroidAuthMessages(
                      signInTitle: 'Oops! Biometric authentication required!',
                      cancelButton: 'No thanks',
                    ),
                    IOSAuthMessages(
                      cancelButton: 'No thanks',
                    ),
                  ]);
              if (didAuth) {
                secure?.authSuccess(unlock: true);
              } else {
                secure?.authFailed(unlock: true);
                secure?.open();
              }
            } on PlatformException catch (e) {
              print('$e');
              if (e.code == auth_error.notEnrolled) {
                // Add handling of no hardware here.
              } else if (e.code == auth_error.lockedOut ||
                  e.code == auth_error.permanentlyLockedOut) {
                // ...
              } else {
                // ...
              }
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
      // home: Login(),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("On es connecté ${snapshot.data}");
            return Home();
          } else if (snapshot.hasError) {
            return Container(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                child: Center(
                    child: CircularProgressIndicator(
              value: 12,
            )));
          } else {
            return Login();
          }
        },
      ),
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
