import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kdg/models/car.dart';
import 'package:kdg/services/log.dart';

class Service extends ChangeNotifier {
  Map<String, dynamic> _tabs = <String, dynamic>{};
  List<Car> _cars = <Car>[];
  Log log;
  FirebaseFirestore firestore;
  Service() {
    firestore = FirebaseFirestore.instance;
    log = Log();
    _tabs = {
      "vehicule": {'img': 'assets/un.jpg', 'text': "Vehicules"},
      "res": {'img': 'assets/deux.jpg', 'text': "Real estate"},
      "rapport": {'img': 'assets/trois.jpg', 'text': "Rapport"},
      "bdd": {'img': 'assets/quatre.jpg', 'text': "Base de conaissance"},
    };
    watchCollection();
  }
  Map<String, dynamic> get tabs => _tabs;
  List<Car> get cars => _cars;

  watchCollection() {
    List<Car> mycars = <Car>[];
    firestore.collection('cars').snapshots().map((event) {
      for (QueryDocumentSnapshot item in event.docs) {
        mycars.add(Car.from({'id': item.id, ...item.data()}));
      }
      return mycars;
    }).listen((event) {
      log.i("New cars go in ${event.length}");
      _cars = event;
      notifyListeners();
    });
  }
}
