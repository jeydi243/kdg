import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/services/auth.dart';
import 'package:kdg/views/home.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    runApp(Kdg());
  }).catchError((err) {

  });
}

class Kdg extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Auth>(
          create: (context) => Auth(),
          lazy: false,
        )
      ],
      child: GetMaterialApp(
          title: 'Kdg', debugShowCheckedModeBanner: false, home: Home()),
    );
  }
}
