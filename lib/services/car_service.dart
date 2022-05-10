import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/models/car.dart';
import 'package:kdg/models/document.dart';
import 'package:logger/logger.dart';
import 'package:palette_generator/palette_generator.dart';

class CarService extends GetxController {
  static CarService carservice = Get.find();

  late FirebaseAuth _auth;
  late FirebaseFirestore firestore;
  late CollectionReference docsRef;
  late CollectionReference carsRef;
  late CollectionReference housesRef;

  Rx<List<Car>> _cars = Rx<List<Car>>(<Car>[]);
  Rx<List<Document>> listDocuments = Rx<List<Document>>(<Document>[]);
  Rx<QuerySnapshot?> listDocumentsSnapshot = Rx<QuerySnapshot?>(null);
  List<Map<String, dynamic>> listBdd = <Map<String, dynamic>>[];
  CarService() {
    _auth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
    listenCar();
    listenBdd();
  }

  @override
  void onInit() async {
    super.onInit();

    docsRef = firestore.collection('documents');
    carsRef = firestore.collection('vehicules');
    housesRef = firestore.collection('houses');
    listDocumentsSnapshot.bindStream(docsRef.snapshots());
  }

  List<Car> get cars => _cars.value;

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
      cars.addAll(event);
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

  Future<List<Document>?> getCarDocs({required String id}) async {
    List<Document> cardocs = <Document>[];
    try {
      QuerySnapshot<Map<String, dynamic>> f = await firestore
          .collection('documents')
          .where('carid', isEqualTo: id)
          .get();
      for (QueryDocumentSnapshot doc in f.docs) {
        cardocs.add(new Document.fromMap(doc, doc.id));
      }
      return cardocs;
    } catch (e) {
      return null;
    }
  }

// Calculate dominant color from ImageProvider
  Future<Color> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor!.color;
  }


}
