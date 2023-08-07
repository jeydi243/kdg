import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kdg/models/user.dart';
import 'package:kdg/services/log.dart';
import '../models/document.dart';
import '../models/house.dart';

class HouseService extends GetxController {
  static HouseService houseservice = Get.find();

  late FirebaseStorage storage;
  late FirebaseFirestore firestore;
  late CollectionReference<House> housesRef;
  late CollectionReference<Document> docsRef;
  Rx<User?> firebaseUser = Rx<User?>(null);
  Rx<DocumentReference?> userDoc = Rx<DocumentReference?>(null);
  Rx<List<House>> _houses = Rx<List<House>>(<House>[]);
  Rx<House?> currentHouse = Rx<House?>(null);
  Rx<QuerySnapshot<House>?> qsnaphouse = Rx<QuerySnapshot<House>?>(null);
  Rx<DocumentReference<House>?> currentHouseRef =
      Rx<DocumentReference<House>?>(null);

  Rx<InternetConnectionStatus> connectionStatus =
      Rx<InternetConnectionStatus>(InternetConnectionStatus.connected);
  Rx<QuerySnapshot?> documentsSnapshot = Rx<QuerySnapshot?>(null);
  late Log log;
  late UserKDG? _user;
  Rx<String?> token = "".obs;
  UserKDG? get user => _user;

  @override
  void onInit() {
    super.onInit();
    storage = FirebaseStorage.instance;
    firestore = FirebaseFirestore.instance;
    docsRef = firestore.collection('documents').withConverter<Document>(
          fromFirestore: Document.fromFirestore,
          toFirestore: (Document doc, _) => doc.toFirestore(),
        );
    housesRef = firestore.collection('houses').withConverter<House>(
          fromFirestore: House.fromFirestore,
          toFirestore: (House h, _) => h.toFirestore(),
        );

    qsnaphouse.bindStream(housesRef.snapshots());
    connectionStatus.bindStream(InternetConnectionChecker().onStatusChange);
    documentsSnapshot.bindStream(docsRef.snapshots());
  }

  List<House> get houses => _houses.value;

  @override
  void onReady() {}

  onHouseChanged() {
    log = Log();
  }

  void watchme(String idHouse) {
    currentHouseRef.value = housesRef.doc(idHouse);
    currentHouse.bindStream(
        housesRef.doc(idHouse).snapshots().map((event) => event.data()));
    update();
  }

  notifyMe() {
    Get.snackbar("Notifications",
        "Vous recevrez une notification à l'approche de l'écheance",
        barBlur: 3, colorText: Colors.white, overlayBlur: 5);
  }
}
