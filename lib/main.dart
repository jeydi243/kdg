import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kdg/services/auth.dart';
import 'package:kdg/services/photo.dart';
import 'package:kdg/services/service.dart';
import 'package:kdg/views/home.dart';
import 'package:provider/provider.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    FirebaseFirestore.instance.settings =
        Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
    runApp(Kdg());
  } on FirebaseException catch (e) {
    print(e.toString());
  }
}

class Kdg extends StatelessWidget {
  // This widget is the root of your application.
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Auth>(
          create: (_) => Auth(),
          lazy: false,
        ),
        ChangeNotifierProvider<Service>(
          create: (_) => Service(),
          lazy: false,
        ),
        ChangeNotifierProvider<PhotoService>(
          create: (_) => PhotoService(),
          lazy: false,
        ),
      ],
      child: GetMaterialApp(
          title: 'Kdg',
          debugShowCheckedModeBanner: false,
          home: LayoutBuilder(
            builder: (context, constraints) {
              return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snap) {
                  if (snap.hasData && snap.data is User) {
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
