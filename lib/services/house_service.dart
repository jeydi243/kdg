import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kdg/models/user.dart';
import 'package:kdg/services/log.dart';
import '../models/maison.dart';

class HouseService extends GetxController {
  static HouseService houseservice = Get.find();

  FirebaseStorage? storage;
  FirebaseFirestore? firestore;

  Rx<User?> firebaseUser = Rx<User?>(null);
  Rx<DocumentReference?> userDoc = Rx<DocumentReference?>(null);
  Rx<List<Maison>> _houses = Rx<List<Maison>>(<Maison>[]);

  late Log log;
  Rx<String?> token = "".obs;
  Rx<UserKDG?> _user = Rx<UserKDG?>(null);

  @override
  void onInit() {
    super.onInit();
    storage = FirebaseStorage.instance;
    firestore = FirebaseFirestore.instance;
  }

  List<Maison> get houses => _houses.value;

  @override
  void onReady() {}

  onHouseChanged() {
    log = Log();
  }

  notifyMe() {
    Get.snackbar("Notifications",
        "Vous recevrez une notification à l'approche de l'écheance",
        barBlur: 3, colorText: Colors.white, overlayBlur: 5);
  }
}
