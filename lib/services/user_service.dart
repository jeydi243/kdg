import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kdg/models/user.dart';
import 'package:kdg/services/log.dart';
import 'package:kdg/views/user/login.dart';
import 'package:palette_generator/palette_generator.dart';
import '../models/car.dart';
import '../models/rapport.dart';
import '../views/home.dart';

class UserService extends GetxController {
  static UserService userservice = Get.find();

  late Log log;
  late FirebaseAuth _auth;
  late FirebaseMessaging _fcm;
  late FirebaseFirestore firestore;
  GoogleSignIn? gsign;
  FirebaseStorage? storage;
  FirebaseFunctions? functions;

  Rx<String?> token = "".obs;
  Rx<User?> firebaseUser = Rx<User?>(null);
  Rx<List<Rapport>> _rapports = Rx<List<Rapport>>(<Rapport>[]);
  Rx<DocumentReference?> userDocRef = Rx<DocumentReference?>(null);

  UserKDG? _user;

  @override
  void onInit() {
    super.onInit();
    _fcm = FirebaseMessaging.instance;
    _auth = FirebaseAuth.instance;
    gsign = GoogleSignIn();
    storage = FirebaseStorage.instance;
    functions = FirebaseFunctions.instance;
    firestore = FirebaseFirestore.instance;
    log = Log();
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  List<Rapport> get rapports => _rapports.value;
  @override
  void onReady() {
    userDocRef.value = firestore.collection('users').doc(currentUser?.uid);
    ever(firebaseUser, onUserChange);
  }

  Future<Map<String, dynamic>> signup(
      String email, String password, String nom) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return {'message': "L'utilisateur a bien été enregistré", "state": true};
    } on FirebaseException catch (e, r) {
      return catchException(e, r);
    }
  }

  onUserChange(User? user) async {
    if (user != null) {
      log.i("There is user");
      await setUserKDG();
      await getDeviceToken();
      Get.offAll(Home());
    } else {
      log.i("No user, redirect to Login");
      Get.offAll(Login());
    }
  }

  Future<Map<String, dynamic>?> signOut() async {
    try {
      await gsign?.signOut();
      await _auth.signOut();
    } on FirebaseException catch (e, r) {
      return catchException(e, r);
    } finally {
      update();
    }
  }

  User? get currentUser => firebaseUser.value;
  UserKDG? get userKDG => _user;
  FirebaseAuth get auth => _auth;

  Future<Map<String, dynamic>?> setUserKDG() async {
    try {
      DocumentSnapshot user = await userDocRef.value!.get();
      _user = UserKDG.fromFirebase2(user, user.id);
    } on FirebaseException catch (e, r) {
      return catchException(e, r);
    } finally {
      update();
    }
  }

  Map<String, dynamic> catchException(e, r) {
    log.e("${e.code} : ${e.message}: $r");
    switch (e.code) {
      case "user-not-found":
        showSnackBar("Authentification",
            message: "L'utilisateur n'existe pas ou a été supprimé");
        return {
          "state": false,
          "message": "L'utilisateur n'existe pas ou a été supprimé"
        };

      case "wrong-password":
        showSnackBar("Authentification",
            message: "Le mot de passe est incorrect");
        return {"state": false, "message": "Le mot de passe est incorrect"};
      case "requires-recent-login":
        showSnackBar("Authentification",
            message:
                "Vous devez vous reconnecter avant d'effectuer cette action");
        return {
          "state": false,
          "message":
              "Vous devez vous reconnecter avant d'effectuer cette action"
        };
      case "invalid-email":
        showSnackBar("Authentification", message: "L'email est invalide");
        return {"state": false, "message": "L'email est invalide"};
      case "email-already-in-use":
        showSnackBar("Authentification",
            message: "Cette email est deja utilisé");
        return {"state": false, "message": "Cette email est deja utilisé"};
      case "operation-not-allowed":
        showSnackBar("Authentification",
            message: "La méthode de connexion n'est pas permise");
        return {
          "state": false,
          "message": "La méthode de connexion n'est pas permise"
        };
      case "weak-password":
        showSnackBar("Authentification",
            message: "Le mot de passe n'est pas suffisament fort");
        return {
          "state": false,
          "message": "Le mot de passe n'est pas suffisament fort"
        };
      default:
        showSnackBar("Authentification",
            message: "Une erreur inconnue est survenu");
        return {"state": false, "message": "Une erreur inconnue est survenu"};
    }
  }

  Future<Map<String, dynamic>?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e, r) {
      return catchException(e, r);
    } finally {
      update();
    }
  }

  ff() async {
    final ref = firestore.collection("cities").doc("LA").withConverter(
          fromFirestore: Car.fromFirestore,
          toFirestore: (Car car, _) => car.toFirestore(),
        );
  }

  void showSnackBar(String title, {required String message}) {
    Get.snackbar(
      title,
      message,
      borderWidth: 2,
    );
    log.w(message);
  }

  Future<Map<String, dynamic>?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await gsign!.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
    } on PlatformException catch (e, r) {
      return catchException(e, r);
    } on FirebaseException catch (e, r) {
      return catchException(e, r);
    }
  }

  Future<Map<String, dynamic>?> deleteMe() async {
    try {
      await currentUser?.delete();
      return {"state": true, "message": "L'utilisateur a bien été supprimé"};
    } on FirebaseException catch (e, r) {
      return catchException(e, r);
    } finally {
      update();
    }
  }

  Future<Map<String, dynamic>?> getDeviceToken() async {
    try {
      token.value = await _fcm.getToken();
      await userDocRef.value!.update({'token': token});
    } on FirebaseException catch (e, r) {
      return catchException(e, r);
    } finally {
      update();
    }
  }

  Future<Map<String, dynamic>?> addUserToFirestore(String provider) async {
    User? user = currentUser;
    try {
      var snap = await userDocRef.value!.get();
      if (snap.exists == false) {
        await firestore.collection('users').doc(user!.uid).set({
          'name': user.displayName,
          'email': user.email,
          'creationTimestamp': user.metadata.creationTime,
          'isEmailVerified': user.emailVerified,
          'imgsrc': user.photoURL,
          'uid': user.uid,
          'telephone': user.phoneNumber,
          "adresse": {
            "numero": "0",
            "avenue": "",
            "commune": "",
            "ville": "",
            "quartier": ""
          },
          'token': token
        });
      }
    } on FirebaseException catch (e, r) {
      return catchException(e, r);
    } finally {
      update();
    }
  }

  Future<Map<String, dynamic>?> resetPassByEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseException catch (e, r) {
      return catchException(e, r);
    } finally {
      update();
    }
  }

  Future<Map<String, dynamic>> updatePassword(String newPassword) async {
    try {
      await currentUser?.updatePassword(newPassword);
      return {
        'state': true,
        'message': "Le mot de passe a été modifié avec succes!",
        'shouldBack': true
      };
    } on FirebaseException catch (e, r) {
      return catchException(e, r);
    }
  }

  Future<Color> domColor(String path) async {
    var paletteGenerator = await PaletteGenerator.fromImageProvider(
      Image.asset(path).image,
    );
    return paletteGenerator.dominantColor!.color;
  }

  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> form) async {
    try {
      var userRef = firestore.collection("users").doc(currentUser!.uid);
      var user = await userRef.get();
      String email = user.get('email').toString();
      String displayName = user.get('name').toString();
      String phoneNumber = user.get('telephone').toString();

      if (form['email'].isEmail && form['email'] != email) {
        await currentUser?.updateEmail(email);
      }
      if (displayName != form['nom'] && form['nom'] != "") {
        // await _auth.currentUser.updateProfile(displayName: form['nom']);
        await userRef.update({'name': form['nom']});
        // _user.nom = form['nom'];
      }
      if (phoneNumber != form['telephone'] && form['telephone'] != null) {
        await userRef.update({'telephone': form['telephone']});
        // _user.telephone = form['telephone'];
      }

      if (form['img'] != null) {
        final ref = storage?.ref();
        var extension = form['img']!.path.split('/').last.split('.').last;
        Reference imgref = ref!
            .child("users")
            .child(currentUser!.uid)
            .child("${currentUser?.uid}.$extension");
        UploadTask task = imgref.putFile(form['img']);
        task
            .then((val) => val.ref.getDownloadURL())
            .then((value) => userRef.update({'imgsrc': value}));
        // await currentUser!.updatePhotoURL(imgsrc);
      }
      return {
        'state': true,
        'message': 'Votre profil a été mis à jour',
        'shouldBack': true
      };
    } on FirebaseException catch (e, stack) {
      return catchException(e, stack);
    } finally {
      update();
    }
  }
}
