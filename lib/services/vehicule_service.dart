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

class VehiculeService {
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
  Stream<List<Vehicule>> get listenCar {
    // Logger().i('Listen for cars');
    return firestore
        .collection('cars')
        .snapshots(includeMetadataChanges: true)
        .map<List<Vehicule>>((QuerySnapshot snap) {
      return snap.docChanges.map<Vehicule>((DocumentChange e) {
        // Logger().i('EPA: ${e.doc.data()}');
        return Vehicule.fromMap({...e.doc.data(), 'id': e.doc.id});
      }).toList();
    });
  }

  Stream<List<Maison>> get listenHouse {
    Logger().i('Listen for houses');
    return firestore
        .collection('houses')
        .snapshots(includeMetadataChanges: true)
        .map<List<Maison>>((snap) {
      return snap.docChanges
          .map<Maison>((e) => Maison.fromMap({...e.doc.data(), 'id': e.doc.id}))
          .toList();
    });
  }

  Stream<List<Rapport>> get listenRapports {
    Logger().i('Listen for rapports');
    return firestore
        .collection('rapports')
        .snapshots(includeMetadataChanges: true)
        .map<List<Rapport>>((snap) {
      return snap.docChanges
          .map<Rapport>(
              (e) => Rapport.fromMap({...e.doc.data(), 'id': e.doc.id}))
          .toList();
    });
  }

  // Stream<List<Map<String, dynamic>>> get listenBdd {
  //   Logger().i('Listen for bdd');
  //   return firestore
  //       .collection('bdd')
  //       .snapshots(includeMetadataChanges: true)
  //       .map<List<Map>>((snap) {
  //     return snap.docChanges
  //         .map<Map<String, dynamic>>((e) => {...e.doc.data(), 'id': e.doc.id})
  //         .toList();
  //   });
  // }

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
  }
}
