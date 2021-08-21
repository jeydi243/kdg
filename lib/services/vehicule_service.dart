import 'dart:developer';
import 'dart:ui';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kdg/models/vehicule.dart';
import 'package:kdg/models/maison.dart';
import 'package:kdg/models/rapport.dart';
import 'package:logger/logger.dart';
import 'package:palette_generator/palette_generator.dart';

class VehiculeService extends ChangeNotifier {
  FirebaseAuth _auth;
  firebase_storage.FirebaseStorage storage;
  FirebaseFirestore firestore;
  List<Vehicule> listVehicules = <Vehicule>[];
  List<Rapport> listRapports = <Rapport>[];
  List<Maison> listMaisons = <Maison>[];
  VehiculeService() {
    _auth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
  }
  Stream<List<Vehicule>> listenCar() {
    return firestore
        .collection('cars')
        .snapshots(includeMetadataChanges: true)
        .map<List<Vehicule>>(converter);
  }

  Stream<List<Maison>> listenHouse() {
    return firestore
        .collection('houses')
        .snapshots(includeMetadataChanges: true)
        .map<List<Maison>>(converter);
  }

  Stream<List<Rapport>> listenRapports() {
    return firestore
        .collection('rapports')
        .snapshots(includeMetadataChanges: true)
        .map<List<Rapport>>(converter);
  }

  Stream<List<Map>> listenBdd() {
    return firestore
        .collection('bdd')
        .snapshots(includeMetadataChanges: true)
        .map<List<Map>>(converter);
  }

  Stream<List> get({String streamOn}) {
    return firestore
        .collection(streamOn)
        .snapshots(includeMetadataChanges: true)
        .map((event) {
      return event.docs;
    });
  }

// Calculate dominant color from ImageProvider
  Future<Color> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor.color;
  }

  List<T> converter<T>(QuerySnapshot snap) {
    if (T.runtimeType == Vehicule) {
      return snap.docChanges
          .map<dynamic>(
              (e) => Vehicule.fromMap({...e.doc.data(), 'id': e.doc.id}))
          .toList();
    } else if (T.runtimeType == Rapport) {
      snap.docChanges
          .map<dynamic>(
              (e) => Rapport.fromMap({...e.doc.data(), 'id': e.doc.id}))
          .toList();
    } else if (T.runtimeType == Maison) {
      snap.docChanges
          .map<dynamic>(
              (e) => Maison.fromMap({...e.doc.data(), 'id': e.doc.id}))
          .toList();
    }
    Logger().i('Just call converter for ${T.runtimeType}');
  }

  genericListener(dynamic items) {
    Logger().i("${(items as List).length} items ajouté ");
    if (items[0] is Maison) {
      listMaisons.addAll(items);
    } else if (items[0] is Rapport) {
      listRapports.addAll(items);
    } else if (items[0] is Vehicule) {
      listVehicules.addAll(items);
    } else {
      Logger().e("Aucun de ces types n'a ete choisi ...");
    }
    notifyListeners();
  }
}
