import 'dart:io';
import 'package:get/get.dart';
import '../models/maison.dart';
import 'package:uuid/uuid.dart';
import 'package:kdg/models/car.dart';
import 'package:flutter/material.dart';
import 'package:kdg/models/document.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CarService extends GetxController {
  late FirebaseFirestore firestore;
  late CollectionReference<Document> docsRef;
  late CollectionReference<Car> carsRef;
  late CollectionReference<Maison> housesRef;
  Box? carBox;
  final start_date = TextEditingController().obs;
  final end_date = TextEditingController().obs;
  final uploadProgress = 0.0.obs;
  final uploadState = false.obs;
  final downloadurl = "".obs;
  final file = Rx<File>;
  final storageRef = FirebaseStorage.instance.ref();
  RxBool filepicked = RxBool(false);
  RxBool isLoadingDocument = RxBool(true);
  Rx<Car?> currentCar = Rx<Car?>(null);
  Rx<TaskSnapshot?> tasksnap = Rx(null);
  Rx<DocumentReference<Car>?> currentCarRef = Rx<DocumentReference<Car>?>(null);
  Rx<String> currentCarId = Rx<String>("");
  Rx<List<Car>> _cars = Rx<List<Car>>(<Car>[]);
  Rx<PlatformFile?> fileg = Rx<PlatformFile?>(null);
  Rx<List<Document>> listDocuments = Rx<List<Document>>(<Document>[]);
  Rx<QuerySnapshot<Car>?> qsnapcars = Rx<QuerySnapshot<Car>?>(null);
  Rx<QuerySnapshot?> documentsSnapshot = Rx<QuerySnapshot?>(null);
  Rx<FirebaseException?> exception = Rx<FirebaseException?>(null);
  Rx<DocumentReference?> ref_ref = Rx<DocumentReference?>(null);
  Rx<Map<String, Object?>> updatedCar = Rx<Map<String, Object?>>({});
  Rx<Map<String, dynamic>> ADD_CAR = Rx<Map<String, dynamic>>({});
  List<Map<String, dynamic>> listBdd = <Map<String, dynamic>>[];
  RefreshController refreshc = RefreshController(initialRefresh: false);
  RefreshController refreshc2 = RefreshController(initialRefresh: false);
  Rx<InternetConnectionStatus> connectionStatus =
      Rx<InternetConnectionStatus>(InternetConnectionStatus.connected);
  List<Map<String, dynamic>> list = [];
  var uuid;

  @override
  void onReady() {
    super.onReady();
    uuid = Uuid();
    ever(tasksnap, onUploadTask);
    ever(qsnapcars, onCarsChange);
    ever(exception, onFirebaseException);
    ever(currentCar, onCarChange);
    ever(downloadurl, updateCarStep2);
    ever(currentCarId, watchme);
    ever(connectionStatus, onConnectionChange);
    ever(uploadState, (bool value) {
      if (value && Get.isDialogOpen == true) Get.back();
    });
  }

  onConnectionChange(InternetConnectionStatus value) {
    if (value == InternetConnectionStatus.disconnected) {
      Get.snackbar(
        "Pas de connexion internet",
        "Veuillez vérifier votre connexion internet",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 10,
        borderColor: Colors.red,
        borderWidth: .5,
        margin: EdgeInsets.all(10),
        duration: 2.seconds,
      );
    }
  }

  onCarChange(Car? car) async {
    if (car != null) {
      list = [
        {"doc_name": 'assurance', "isExpanded": false},
        {"doc_name": 'controle_technique', "isExpanded": false},
        {"doc_name": 'vignette', "isExpanded": false},
        {"doc_name": 'stationnement', "isExpanded": false},
      ];
      update();
    }
  }

  onCarsChange(QuerySnapshot<Car>? qs) {
    if (qs != null) {
      print("${qs.docChanges.length} docs changed");
      qs.docChanges.forEach((el) {
        if (el.type == DocumentChangeType.modified && el.doc.exists) {
          changeCardAt(el.doc.id, el.doc.data());
        } else if (el.type == DocumentChangeType.added && el.doc.exists) {
          _cars.value.addAll([el.doc.data()].whereType<Car>().toList());
        } else if (el.type == DocumentChangeType.removed) {
          _cars.value.removeWhere((car) => car.id == el.doc.id);
        }
        update();
      });
    }
  }

  @override
  void onInit() async {
    // _auth = FirebaseAuth.instance;
    firestore = FirebaseFirestore.instance;
    carBox = await Hive.openBox('Car');
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
    qsnapcars.bindStream(carsRef.snapshots());
    connectionStatus.bindStream(InternetConnectionChecker().onStatusChange);
    documentsSnapshot.bindStream(docsRef.snapshots());
    super.onInit();
  }

  List<Car> get cars => _cars.value;
  double get progress => uploadProgress.value;
  bool get isFilePicked => filepicked.value;

  set setCurrentCarId(String id) {
    currentCarId.value = id;
    update();
  }

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

  // void prepareUpdateCar() {
  //   updatedCar.value['start_date'] = start_date.value.text;
  //   updatedCar.value['end_date'] = end_date.value.text;
  //   if (fileg.value != null) {
  //     updatedCar.value['file'] = File(fileg.value!.path ?? "");
  //   }
  //   update();
  // }

  void onLoadFailed(String description) {
    Get.snackbar("File failed to load", description);
    update();
  }

  void stopLoading() {
    isLoadingDocument.value = false;
    update();
  }

  void resetForm() {
    start_date.value.text = "";
    end_date.value.text = "";
    filepicked.value = false;
    fileg.value = null;
    updatedCar.value = {};
    update();
  }

  void storefile(Map<String, dynamic> updatedDoc) async {
    String carid = currentCarId.value;
    File file = File((updatedDoc['file'] as PlatformFile).path ?? '');
    updatedDoc.remove("file");
    carBox!.put("car", updatedDoc);
    Reference cardoc =
        storageRef.child('cars').child(currentCarId.value).child('documents');
    try {
      UploadTask upta = cardoc
          .child("${carid.substring(1, 4)}${file.path.split('/').last}")
          .putFile(File(file.path));

      tasksnap.bindStream(upta.snapshotEvents);
    } on FirebaseException catch (e) {
      exception.value = e;
    }
  }

  // Stream<Map<String, dynamic>> changeStream(
  //     Stream<TaskSnapshot> st, Map<String, dynamic> map) {
  //   return st.map((event) => {'event': event, ...map});
  // }

  onUploadTask(TaskSnapshot? snapshot) async {
    String errorMessage = "Erreur lors de la mise à jour de la vignette";
    String cancelMessage = "La mise à jour de la vignette a été annulé";
    // String successMessage = "Erreur lors de la mise à jour de la vignette";

    switch (snapshot!.state) {
      case TaskState.running:
        uploadProgress.value =
            (100 * (snapshot.bytesTransferred / snapshot.totalBytes));
        print("Upload is ${uploadProgress.value} % complete.");
        break;
      case TaskState.paused:
        Get.snackbar('Mise à jour', "Mise à jour en pause");

        break;
      case TaskState.success:
        uploadState.value = true;
        downloadurl.value = await snapshot.ref.getDownloadURL();
        break;
      case TaskState.canceled:
        Get.snackbar('Misa à jour', cancelMessage);
        break;
      case TaskState.error:
        Get.snackbar('Misa à jour ', errorMessage);
        break;
    }
    update();
  }

  onRefresh() async {
    await Future.delayed(1.seconds);
    // getCars();
    if (connectionStatus.value == InternetConnectionStatus.disconnected) {
      refreshc.refreshFailed();
    } else {
      refreshc.refreshCompleted();
    }
  }

  onRefreshDetails() async {
    await Future.delayed(1.seconds);
    // updateCar();
    if (connectionStatus.value == InternetConnectionStatus.disconnected) {
      refreshc2.refreshFailed();
    } else {
      refreshc2.refreshCompleted();
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

  watchme(String idCar) {
    currentCarRef.value = carsRef.doc(idCar);
    currentCar.bindStream(
        carsRef.doc(idCar).snapshots().map((event) => event.data()));
    update();
  }

  onLoading() {
    print('On loading');
  }

  changeCardAt(String idcar, Car? newcar) {
    int index = _cars.value.indexWhere((car) => car.id == idcar);
    if (newcar != null) {
      print('Index for change is found: $index ${newcar.type_carburant}');
      _cars.value[index] = newcar;
      update();
    }
  }

  onLoadingDetails() {
    print('On loading details of car');
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
    } on StateError catch (e) {
      Get.snackbar("State Error", e.message);
      return null;
    }
  }

  Future<Color> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor!.color;
  }

  Stream<List<Car>> wacthCars() {
    return carsRef.snapshots().map<List<Car>>((event) {
      return event.docs.map((e) => e.data()).toList();
    });
  }

  getCars() async {
    try {
      QuerySnapshot f = await carsRef.get();
      _cars.value = [];
      for (var i = 0; i < f.size; i++) {
        _cars.value.add(f.docs[i].data() as Car);
      }
    } catch (e, s) {
      Get.snackbar("CARS", "Can't retrive car $e: $s", duration: 50.seconds);
    }
  }

  Future<void> updateCarStep1(Map<String, dynamic> updatedDoc) async {
    try {
      if (updatedDoc.containsKey("file")) {
        storefile(updatedDoc);
      }

      DocumentSnapshot<Car> gf = await currentCarRef.value!.get();
      List<Map<String, dynamic>> currentDocList =
          List<Map<String, dynamic>>.from(gf.get(updatedDoc['doc_name']));
      carBox!.put("currentDocList", currentDocList);
      int i = currentDocList.indexWhere((el) => el['id'] == updatedDoc['id']);
      if (i != -1) {
        currentDocList[i] = updatedDoc;
      }
      //Si il y a un fichier on l'enregistre d'abord dans le bucket

      await currentCarRef.value!
          .update({"${updatedDoc['doc_name']}": currentDocList});

      update();
    } on FirebaseException catch (e) {
      exception.value = e;
      return;
    }
  }

  Future<bool> updateCarStep2(String? downloadURL) async {
    Get.snackbar(
        "Download", "Le telechargement est terminé, tu peux now continuer");
    try {
      dynamic box = await carBox!.get("car");
      dynamic box2 = await carBox!.get("currentDocList");
      List<Map<String, dynamic>> docList =
          List<Map<String, dynamic>>.from(box2);
      Map<String, dynamic> updatedDoc = Map<String, dynamic>.from(box);
      updatedDoc['file'] = downloadURL;
      int indexw = docList.indexWhere((el) => el['id'] = updatedDoc['id']);
      docList[indexw] = updatedDoc;
      await currentCarRef.value!.update({"${updatedDoc['doc_name']}": docList});
      Get.snackbar("Update Car", "Car document at id ${currentCarId.value}");
      resetForm();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
