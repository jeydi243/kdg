import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/services/auth.dart';
import 'package:kdg/views/home.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Kdg());
}

class Kdg extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
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
            builder: (context,constraints) {
              return FutureBuilder(
                future: _initialization,
                builder: (context, snap) {
                  if (snap.hasData) {
                    return Home();
                  } else {
                    return Home();
                  }
                },
              );
            },
          )),
    );
  }
}
