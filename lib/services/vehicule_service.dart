import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/models/car.dart';
import 'package:kdg/models/maison.dart';
import 'package:kdg/models/rapport.dart';
import 'package:logger/logger.dart';
import 'package:palette_generator/palette_generator.dart';

class CarService extends GetxController {
  static CarService userservice = Get.find();

  late FirebaseAuth _auth;
  late FirebaseFirestore firestore;
  List<Car> listCars = <Car>[];
  List<Rapport> listRapports = <Rapport>[];
  List<Maison> listMaisons = <Maison>[];
  List<Map<String, dynamic>> listBdd = <Map<String, dynamic>>[];
  CarService() {
    _auth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
    listenCar();
    listenHouse();
    listenRapports();
    listenBdd();
  }
  void listenCar() {
    firestore
        .collection('cars')
        .snapshots(includeMetadataChanges: true)
        .map<List<Car>>((QuerySnapshot snap) {
      return snap.docChanges.map<Car>((DocumentChange e) {
        if (e.type == DocumentChangeType.added) {}
        return Car.fromMap({'id': e.doc.id});
      }).toList();
    }).listen((event) {
      Logger().i('Listen for cars');
      listCars.addAll(event);
    });
  }

  void listenHouse() {
    firestore
        .collection('houses')
        .snapshots(includeMetadataChanges: true)
        .map<List<Maison>>((snap) {
      return snap.docChanges
          .map<Maison>(
              (e) => Maison.fromMap({...?e.doc.data(), 'id': e.doc.id}))
          .toList();
    }).listen((event) {
      Logger().i('Listen for houses');
      listMaisons.addAll(event);
    });
  }

  void listenRapports() {
    firestore
        .collection('rapports')
        .snapshots(includeMetadataChanges: true)
        .map<List<Rapport>>((snap) {
      return snap.docChanges
          .map<Rapport>(
              (e) => Rapport.fromMap({...?e.doc.data(), 'id': e.doc.id}))
          .toList();
    }).listen((event) {
      Logger().i('Listen for rapports');
      listRapports.addAll(event);

    });
  }

  void listenBdd() {
    firestore
        .collection('bdd')
        .snapshots(includeMetadataChanges: true)
        .map<List<Map<String, dynamic>>>((snap) {
      return snap.docChanges
          .map<Map<String, dynamic>>((e) => {...?e.doc.data(), 'id': e.doc.id})
          .toList();
    }).listen((event) {
      Logger().i('Bdd change ...');
      listBdd.addAll(event);
    });
  }

// Calculate dominant color from ImageProvider
  Future<Color> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor!.color;
  }
}
