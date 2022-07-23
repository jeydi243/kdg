import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  late CollectionReference<Document> docsRef;
  late CollectionReference<Car> carsRef;
  late CollectionReference<Maison> housesRef;

  final start_date = TextEditingController().obs;
  final end_date = TextEditingController().obs;
  final file_upload_progress = 0.0.obs;
  final file_upload_state = false.obs;
  final downloadurl = "".obs;
  final file = Rx<File>;
  RxBool isLoadingDocument = RxBool(true);
  RxBool filepicked = false.obs;
  Rx<List<Car>> _cars = Rx<List<Car>>(<Car>[]);
  Rx<List<Document>> listDocuments = Rx<List<Document>>(<Document>[]);
  Rx<QuerySnapshot?> listDocumentsSnapshot = Rx<QuerySnapshot?>(null);
  List<Map<String, dynamic>> listBdd = <Map<String, dynamic>>[];
  Rx<FirebaseException?> exception = Rx<FirebaseException?>(null);
  Rx<PlatformFile?> fileg = Rx<PlatformFile?>(null);

  Rx<Map<String, Object?>> updatedCar = Rx<Map<String, Object?>>({});
  final storageRef = FirebaseStorage.instance.ref();

  @override
  void onReady() {
    carservice.getCars().then((value) => null);
    ever(file_upload_state, (bool value) {
      if (value && Get.isDialogOpen == true) Get.back();
    });
    ever(exception, onFirebaseException);
    ever(downloadurl, (String value) {
      if (value != "") {
        updateCarStep2(id, value);
      }
    });
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
  double get progress => file_upload_progress.value;
  set endDate(DateTime? value) {
    end_date.value.text = value!.toLocal().toIso8601String();
    update();
  }

  set setfile(PlatformFile file) {
    fileg.value = file;
    filepicked.value = true;
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

  getCars() async {
    try {
      QuerySnapshot f = await carsRef.get();
      for (var i = 0; i < f.size; i++) {
        _cars.value.add(f.docs[i].data() as Car);
      }
    } catch (e, s) {
      Get.snackbar("CARS", "Can't retrive car $e: $s");
    }
  }

  void prepareUpdateCar() {
    updatedCar.value['start_date'] = start_date.value.text;
    updatedCar.value['end_date'] = end_date.value.text;
    updatedCar.value['file'] = File(fileg.value!.path ?? "");
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
    filepicked.value = false;
    fileg.value = null;
    updatedCar.value = {};
  }

  void storefile(String namedoc, String carid, File file) async {
    Reference cardoc = storageRef.child('cars').child(carid).child('documents');
    try {
      UploadTask uptask = cardoc
          .child("${carid.substring(1, 4)}${file.path.split('/').last}")
          .putFile(File(file.path));

      uptask.snapshotEvents.listen((snapshot) {
        switch (snapshot.state) {
          case TaskState.running:
            file_upload_progress.value =
                (100 * (snapshot.bytesTransferred / snapshot.totalBytes));
            print("Upload is ${file_upload_progress.value} % complete.");
            update();
            break;
          case TaskState.paused:
            // ...
            break;
          case TaskState.success:
            file_upload_state.value = true;
            snapshot.ref.getDownloadURL().then((value) {
              downloadurl.value = value;
            });
            update();
            break;
          case TaskState.canceled:
            // ...
            break;
          case TaskState.error:
            // ...
            break;
        }
      });
      ;
    } on FirebaseException catch (e) {
      exception.value = e;
    }
  }

  onFirebaseException(FirebaseException? e) {
    Map<String, String> map = {
      "storage/unknown": "Une erreur inconnue est survenue.",
      "storage/object-not-found":
          "	Aucun objet n'existe à la référence souhaitée",
      "storage/bucket-not-found":
          "Aucun bucket n'est configuré pour Cloud Storage",
      "storage/project-not-found":
          "Aucun projet n'est configuré pour Cloud Storage",
      "storage/quota-exceeded":
          "Le quota de votre bucket Cloud Storage a été dépassé. ,Si vous êtes sur le niveau gratuit, passez à un plan payant. Si vous avez un forfait payant, contactez l'assistance Firebase.",
      "storage/unauthenticated":
          "L'utilisateur n'est pas authentifié, veuillez vous authentifier et réessayer.",
      "storage/unauthorized":
          "L'utilisateur n'est pas autorisé à effectuer l'action souhaitée, vérifiez vos règles de sécurité pour vous assurer qu'elles sont correctes.",
      "firebase_storage/unauthorized":
          "L'utilisateur n'est pas autorisé à effectuer l'action souhaitée, vérifiez vos règles de sécurité pour vous assurer qu'elles sont correctes.",
      "storage/retry-limit-exceeded":
          "Le délai maximum d'une opération (téléchargement, téléchargement, suppression, etc.) a été dépassé. Essayez de télécharger à nouveau.",
      "storage/invalid-checksum":
          "Le fichier sur le client ne correspond pas à la somme de contrôle du fichier reçu par le serveur. Essayez de télécharger à nouveau.",
      "storage/canceled": "L'utilisateur a annulé l'opération",
      "storage/invalid-event-name":
          "Nom d'événement fourni non valide. Doit être l'un des [ running , progress , pause ]",
      "storage/invalid-url":
          "URL non valide fournie à refFromURL() . Doit être au format : gs://bucket/object ou https://firebasestorage.googleapis.com/v0/b/bucket/o/object?token=<TOKEN>",
      "storage/invalid-argument":
          "L'argument passé à put() doit être File , Blob ou UInt8 Array. L'argument passé à putString() doit être une chaîne raw, Base64 ou Base64URL .",
      "storage/no-default-bucket":
          "Aucun compartiment n'a été défini dans la propriété storageBucket de votre configuration.",
      "storage/cannot-slice-blob":
          "Se produit généralement lorsque le fichier local a été modifié (supprimé, enregistré à nouveau, etc.). Réessayez de télécharger après avoir vérifié que le fichier n'a pas changé.",
      "storage/server-file-wrong-size":
          "Le fichier sur le client ne correspond pas à la taille du fichier reçu par le serveur. Essayez de télécharger à nouveau."
    };
    Get.snackbar("Firebase", "${map[e!.code]}");
  }

  Future<Color> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor!.color;
  }

  Future<void> updateCarStep1(String id, String namedoc) async {
    try {
      prepareUpdateCar();
      storefile(namedoc, id, updatedCar.value['file'] as File);
    } catch (e, s) {
      print("$e, $s");
      return;
    }
  }

  Future<bool> updateCarStep2(String id, String linktofile) async {
    try {
      await carsRef.doc(id).collection("documents").add(updatedCar.value);
      await carsRef.doc(id).update(updatedCar.value);
      return true;
    } catch (e) {
      return false;
    }
  }
}
