import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';
import 'package:kdg/services/auth.dart';
import 'package:kdg/views/home.dart';
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
        Provider<Auth>(
          create: (_) => Auth(),
          lazy: false,
        )
      ],
      child: GetMaterialApp(
          title: 'Kdg',
          debugShowCheckedModeBanner: false,
          home: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxHeight == Get.height) {
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
