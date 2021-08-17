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
import 'package:palette_generator/palette_generator.dart';

class VehiculeService extends ChangeNotifier {
  FirebaseAuth _auth;
  firebase_storage.FirebaseStorage storage;
  FirebaseFirestore firestore;
  List<Vehicule> listVehicules;
  List<Rapport> listRapports;
  List<Maison> listMaisons;
  VehiculeService() {
    _auth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
  }
  void setListener() {
    firestore
        .collection('cars')
        .snapshots(includeMetadataChanges: true)
        .map<List<Vehicule>>(converter)
        .listen((event) {});
    firestore
        .collection('house')
        .snapshots(includeMetadataChanges: true)
        .map<List<Maison>>(converter);
    firestore
        .collection('rapport')
        .snapshots(includeMetadataChanges: true)
        .map<List<Vehicule>>(converter);
    firestore
        .collection("bdd")
        .snapshots(includeMetadataChanges: true)
        .map<dynamic>(converter);
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
    List<T> miniList = <T>[];
    if (T.runtimeType == Vehicule) {
      snap.docChanges
          .map((e) => Vehicule.fromMap({...e.doc.data(), 'id': e.doc.id}));
    } else if (T.runtimeType == Rapport) {
      snap.docChanges
          .map((e) => Rapport.fromMap({...e.doc.data(), 'id': e.doc.id}));
    } else if (T.runtimeType == Maison) {
      snap.docChanges
          .map((e) => Maison.fromMap({...e.doc.data(), 'id': e.doc.id}));
    }
  }
}
