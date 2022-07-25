// Import the generated file
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdg/utils/circle_trans.dart';
import 'package:kdg/views/user/login.dart';
import 'package:kdg/views/user/profile.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  ErrorWidget.builder = (FlutterErrorDetails details) => Material(
        child: Container(
            child: Center(
                child: Text('Error: ${details.exceptionAsString}',
                    style: GoogleFonts.k2d(fontSize: 25)))),
      );
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
  final LocalAuthentication auth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
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
      home: Login(),
      customTransition: CircleTrans(),
    );
  }
}
