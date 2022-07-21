import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/models/car.dart';
import 'package:kdg/models/document.dart';
import 'package:palette_generator/palette_generator.dart';
import '../models/maison.dart';

class CarService extends GetxController {
  static CarService carservice = Get.find();

  late FirebaseAuth _auth;
  late FirebaseFirestore firestore;
  late final CollectionReference<Document> docsRef;
  late final CollectionReference<Car> carsRef;
  late final CollectionReference<Maison> housesRef;

  Rx<List<Car>> _cars = Rx<List<Car>>(<Car>[]);
  Rx<List<Document>> listDocuments = Rx<List<Document>>(<Document>[]);
  Rx<QuerySnapshot?> listDocumentsSnapshot = Rx<QuerySnapshot?>(null);
  List<Map<String, dynamic>> listBdd = <Map<String, dynamic>>[];
  RxBool isLoadingDocument = RxBool(true);
  final start_date = TextEditingController().obs;
  final end_date = TextEditingController().obs;
  final file = Rx<File>;
  @override
  void onReady() {
    carservice.getCars().then((value) => null);
    super.onReady();
  }

  @override
  void onInit() async {
    _auth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;

    docsRef = firestore.collection('documents').withConverter<Document>(
          fromFirestore: Document.fromFirestore,
          toFirestore: (Document doc, _) => doc.toFirestore(),
        );
    carsRef = firestore.collection('cars').withConverter<Car>(
          fromFirestore: Car.fromFirestore,
          toFirestore: (Car car, _) => car.toFirestore(),
        );
    housesRef = firestore.collection('houses').withConverter<Maison>(
          fromFirestore: Maison.fromFirestore,
          toFirestore: (Maison house, _) => house.toFirestore(),
        );

    listDocumentsSnapshot.bindStream(docsRef.snapshots());
    super.onInit();
  }

  List<Car> get cars => _cars.value;

  set endDate(DateTime? value) {
    end_date.value.text = value!.toLocal().toIso8601String();
    update();
  }

  set startDate(DateTime? value) {
    start_date.value.text = value!.toLocal().toIso8601String();
    update();
  }

  Future<List<Document>?> getCarDocs({required String id}) async {
    List<Document> cardocs = <Document>[];
    try {
      QuerySnapshot f = await docsRef
          .where('idCar', isEqualTo: id)
          .where("start_date", isLessThanOrEqualTo: DateTime.now())
          .get();
      for (QueryDocumentSnapshot doc in f.docs) {
        cardocs.add(new Document.fromMap(doc, doc.id));
      }
      return cardocs;
    } catch (e) {
      return null;
    }
  }

  Future<void> getCars() async {
    try {
      QuerySnapshot f = await carsRef.get();
      for (var i = 0; i < f.size; i++) {
        _cars.value.add(f.docs[i].data() as Car);
      }
    } catch (e, s) {
      Get.snackbar("CARS", "Can't retrive car $e: $s");
    }
  }

// Calculate dominant color from ImageProvider
  Future<Color> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor!.color;
  }

  void onDocumentLoadFailed(String description) {
    Get.snackbar("File", description);
    update();
  }

  void stopLoading() {
    isLoadingDocument.value = false;
    update();
  }

  void reset() {
    start_date.value.text = "";
    end_date.value.text = "";
  }

  void updateCarDocument() {}
}
