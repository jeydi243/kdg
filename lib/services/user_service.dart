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
  Rx<FirebaseException?> exception = Rx<FirebaseException?>(null);
  Rx<PlatformException?> pl_exception = Rx<PlatformException?>(null);
  late CollectionReference usersRef;

  UserKDG? _user;
  User? get currentUser => firebaseUser.value;
  UserKDG? get userKDG => _user;
  FirebaseAuth get auth => _auth;

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
    usersRef = firestore.collection('users');
    ever(firebaseUser, onUserChange);
    ever(exception, onFirebaseException);
    ever(pl_exception, onPlatformException);
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
          "Le fichier sur le client ne correspond pas à la taille du fichier reçu par le serveur. Essayez de télécharger à nouveau.",
      "user-not-found": "L'utilisateur n'existe pas ou a été supprimé",
      "wrong-password": "Le mot de passe est incorrect",
      "requires-recent-login": "L'utilisateur doit se connecter récemment",
      "user-disabled": "L'utilisateur a été désactivé",
      "invalid-email": "L'adresse email est invalide",
      "email-already-in-use": "L'adresse email est déjà utilisée",
      "weak-password": "Le mot de passe est trop faible",
      "too-many-requests":
          "Trop de requêtes ont été envoyées. Essayez de nouveau dans quelques minutes.",
      "operation-not-allowed": "L'opération n'est pas autorisée pour ce compte",
    };
    Get.snackbar("Firebase", "${map[e!.code]}");
  }

  onPlatformException(PlatformException? e) {
    Get.snackbar("Erreur", "${e!.message}");
  }

  Future<Map<String, dynamic>?> signup(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return {'message': "L'utilisateur a bien été enregistré", "state": true};
    } on FirebaseException catch (e) {
      exception.value = e;
    }
  }

  onUserChange(User? user) async {
    if (user != null) {
      DocumentSnapshot v = await usersRef.doc(user.uid).get();
      if (v.exists) {
        await setUserKDG();
        Get.snackbar("Authentication", "Successfull login");
        await getDeviceToken();
      } else {}
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
    } on FirebaseException catch (e) {
      exception.value = e;
    } finally {
      update();
    }
  }

  Future<Map<String, dynamic>?> setUserKDG() async {
    try {
      DocumentSnapshot snap = await usersRef.doc(currentUser?.uid).get();
      _user = UserKDG.fromFirebase2(snap, snap.id);
    } on FirebaseException catch (e) {
      exception.value = e;
    } finally {
      update();
    }
  }

  Future<Map<String, dynamic>?> signInWithEmailAndPassword(Map info) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: info['email'], password: info['password']);
    } on FirebaseException catch (e) {
      exception.value = e;
    } on PlatformException catch (e) {
      pl_exception.value = e;
    } finally {
      update();
    }
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
    } on PlatformException catch (e) {
      pl_exception.value = e;
    } on FirebaseException catch (e) {
      exception.value = e;
    }
  }

  Future<Map<String, dynamic>?> deleteMe() async {
    try {
      await currentUser?.delete();
      return {"state": true, "message": "L'utilisateur a bien été supprimé"};
    } on FirebaseException catch (e, r) {
      exception.value = e;
    } finally {
      update();
    }
  }

  Future<Map<String, dynamic>?> getDeviceToken() async {
    try {
      token.value = await _fcm.getToken();
      await userDocRef.value!.update({'token': token});
    } on FirebaseException catch (e, r) {
      exception.value = e;
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
      exception.value = e;
    } finally {
      update();
    }
  }

  Future<Map<String, dynamic>?> resetPassByEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseException catch (e, r) {
      exception.value = e;
    } finally {
      update();
    }
  }

  Future<Map<String, dynamic>?> updatePassword(String newPassword) async {
    try {
      await currentUser?.updatePassword(newPassword);
      return {
        'state': true,
        'message': "Le mot de passe a été modifié avec succes!",
        'shouldBack': true
      };
    } on FirebaseException catch (e, r) {
      exception.value = e;
    }
  }

  Future<Color> domColor(String path) async {
    var paletteGenerator = await PaletteGenerator.fromImageProvider(
      Image.asset(path).image,
    );
    return paletteGenerator.dominantColor!.color;
  }

  Future<Map<String, dynamic>?> updateProfile(Map<String, dynamic> form) async {
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
      exception.value = e;
    } finally {
      update();
    }
  }
}
