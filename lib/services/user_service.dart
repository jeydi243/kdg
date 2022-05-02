import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:kdg/models/user.dart';
import 'package:kdg/services/log.dart';
import 'package:kdg/views/login.dart';

import '../views/home.dart';

class UserService extends GetxController {
  static UserService userservice = Get.find();

  FirebaseAuth? _auth;
  GoogleSignIn? gsign;
  FirebaseStorage? storage;
  FirebaseFirestore? firestore;
  FirebaseFunctions? functions;

  Rx<User?> firebaseUser = Rx<User?>(null);
  Rx<DocumentReference?> userDoc = Rx<DocumentReference?>(null);

  late Log log;
  Rx<String?> token = "".obs;
  FirebaseMessaging? _fcm;
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

    _fcm?.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    firebaseUser.bindStream(_auth!.authStateChanges());
  }

  @override
  void onReady() {
    userDoc.value = firestore?.collection('users').doc(currentUser?.uid);
    ever(firebaseUser, onUserChange);
  }

  UserService() {
    log = Log();
  }

  Future<Map<String, dynamic>> signup(
      String email, String password, String nom) async {
    try {
      await _auth!
          .createUserWithEmailAndPassword(email: email, password: password);
      return {'message': "L'utilisateur a bien été enregistré", "state": true};
    } on FirebaseException catch (e) {
      if (e.code == "email-already-in-use") {
        log.w("Un compte existe déja avec cette email");
        return {
          "state": false,
          "message": "Un compte existe déja avec cette email"
        };
      } else if (e.code == "invalid-email") {
        log.w("L'email est invalide");
        return {"state": false, "message": "L'email est invalide"};
      } else if (e.code == "operation-not-allowed") {
        log.w("La méthode de connexion n'est pas permise");
        return {
          "state": false,
          "message": "La méthode de connexion n'est pas permise"
        };
      } else if (e.code == "weak-password") {
        log.w("Le mot de passe n'est pas suffisament fort");
        return {
          "state": false,
          "message": "Le mot de passe n'est pas suffisament fort"
        };
      } else {
        log.w("Une erreur s'est produite ${e.message}");
        return {
          "state": false,
          "message":
              "Un probleme réseau est survenue. Vérifier l'état de votre connexion."
        };
      }
    }
  }

  onUserChange(User? user) {
    if (user != null) {
      log.i("There is user");
      setUserKDG();
      getDeviceToken();
      Get.offAll(Home());
    } else {
      log.i("No user, redirect to Login");
      Get.offAll(Login());
    }
  }

  Future<void> signOut() async {
    try {
      await gsign?.signOut();
      await _auth?.signOut();
    } on FirebaseException catch (e) {
      log.w("$e");
    }
    Get.to(Login());
  }

  User? get currentUser => firebaseUser.value;
  FirebaseAuth? get auth => _auth;
  UserKDG? get userKDG => _user;

  Future<void> setUserKDG() async {
    try {
      var userRef = firestore!.collection("users").doc(currentUser?.uid);
      var user = await userRef.get();
      _user = UserKDG.fromMap({"id": user.id, ...?user.data()});
    } catch (e) {
      log.i('Erreur dans user: $e');
    }
  }

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth?.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
      log.e("${e.code} : ${e.message}");
      switch (e.code) {
        case "invalid-email":
          showSnackBar(title: "Erreur", message: "L'email est incorrect");
          break;
        case "user-not-found":
          showSnackBar(
              title: "Erreur",
              message: "L'utilisateur n'existe pas ou a été supprimé");
          break;
        case "wrong-password":
          showSnackBar(
              title: "Erreur", message: "Le mot de passe est incorrect");
          break;
        case "invalid-email":
          break;
        default:
      }
      return null;
    }
  }

  void showSnackBar(
      {String title = "Authentification", required String message}) {
    Get.snackbar(
      title,
      message,
      borderWidth: 2,
    );
    log.w(message);
  }

  Future<void> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await gsign!.signIn();
      GoogleSignInAuthentication googleAuth =
          await googleSignInAccount!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth?.signInWithCredential(credential);
    } catch (e, r) {
      log.e('$e: $r');
    }
  }

  Future<void> deleteMe() async {
    try {
      await currentUser?.delete();
    } on FirebaseException catch (e) {
      if (e.code == 'requires-recent-login') {
        log.w(
            "L'utilisateur doit se ré-authentifier avant que cette opération puisse être exécutée.");
      } else {
        log.w('$e');
      }
    }
  }

  Future<void> getDeviceToken() async {
    try {
      token.value = await _fcm?.getToken();
      await userDoc.value!.update({'token': token});
    } catch (e) {
      log.e('$e');
    }
  }

  Future<void> addUserToFirestore({required String provider}) async {
    User? user = currentUser;
    try {
      var snap = await userDoc.value!.get();
      if (snap.exists == false) {
        return await firestore!.collection('users').doc(user!.uid).set({
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
    } catch (e, r) {
      log.w('$e : $r');
    }
  }

  Future<void> sendEmailPassReinitialisation({required String email}) async {
    _auth?.sendPasswordResetEmail(email: email).catchError((err) {
      print("**************$err");
      log.w(err);
    });
  }

  Future<Map<String, dynamic>> updatePassword(
      {required String newPassword}) async {
    try {
      await currentUser?.updatePassword(newPassword);
      return {
        'state': true,
        'message': "Le mot de passe a été modifié avec succes!",
        'shouldBack': true
      };
    } on FirebaseException catch (e) {
      if (e.code == "requires-recent-login") {
        return {
          "state": false,
          'shouldBack': false,
          "message":
              "Vous devez vous reconnecter avant de changer le mot de passe"
        };
      } else if (e.code == "weak-password") {
        return {
          'shouldBack': false,
          "state": false,
          "message": "Le mot de passe n'est pas suffisament fort"
        };
      } else {
        log.w("Une erreur s'est produite ${e.message}");
        return {
          'shouldBack': false,
          "state": false,
          "message":
              "Un probleme réseau est survenue. Vérifier l'état de votre connexion."
        };
      }
    }
  }

  Future<Map<String, dynamic>> updateProfile(
      {File? img, required Map<String, dynamic> form}) async {
    try {
      var userRef = firestore!.collection("users").doc(currentUser!.uid);
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

      if (img != null) {
        final ref = storage?.ref();
        var extension = img.path.split('/').last.split('.').last;
        Reference imgref = ref!
            .child("users")
            .child(currentUser!.uid)
            .child("${currentUser?.uid}.$extension");
        UploadTask task = imgref.putFile(img);
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
      log.w('Une erreur est survenue: ${e.message} :: $stack');
      if (e.code == "requires-recent-login") {
        return {
          "state": false,
          "message":
              "Vous devez vous reconnecter avant de changer le mot de passe"
        };
      } else if (e.code == "invalid-email") {
        return {
          "state": false,
          "message": "Le mot de passe n'est pas suffisament fort"
        };
      } else if (e.code == "email-already-in-use") {
        return {"state": false, "message": "Cette email est deja utilisé"};
      } else {
        log.w("Une erreur s'est produite ${e.message}");
        return {
          "state": false,
          "message":
              "Un probleme réseau est survenue. Vérifier l'état de votre connexion."
        };
      }
    }
  }

  notifyMe() {
    Get.snackbar("Notifications",
        "Vous recevrez une notification a l'approche de l'écheance",
        barBlur: 3, colorText: Colors.white, overlayBlur: 5);
  }
}
