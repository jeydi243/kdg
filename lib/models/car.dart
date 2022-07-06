import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kdg/models/document.dart';

class Car {
  String model;
  String nom;
  String type_carburant;
  late String id;
  Document? assurance;
  Document? controle;
  Document? stationnement;
  Document? vignette;

  late Map<String, dynamic> defaultControle;
  late Map<String, dynamic> defaultAssurance;
  late Map<String, dynamic> defaultStationnement;
  late Map<String, dynamic> defaultVignette;

  List<Document?> get listDocuments =>
      [assurance, controle, stationnement, vignette];
  String get Nom => nom;
  Car({
    required this.model,
    required this.nom,
    required this.id,
    required this.defaultAssurance,
    required this.defaultControle,
    required this.defaultStationnement,
    required this.defaultVignette,
    required this.type_carburant,
  });
  Car.fromMap(Map<String, dynamic> snapshot)
      : id = snapshot['id'] ?? '',
        nom = snapshot['name'] ?? '',
        type_carburant = snapshot['type_carburant'] ?? '',
        model = snapshot['model'] ?? '',
        defaultControle = snapshot['controle'] ?? <String, dynamic>{},
        defaultVignette = snapshot['vignette'] ?? <String, dynamic>{},
        defaultAssurance = snapshot['assurance'] ?? <String, dynamic>{},
        defaultStationnement = snapshot['stationnement'] ?? <String, dynamic>{};

  Car.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : nom = snapshot.data()?["nom"],
        type_carburant = snapshot.data()?["type_carburant"],
        id = snapshot.id,
        model = snapshot.data()?["model"],
        defaultControle = snapshot.data()?['controle'] ?? <String, dynamic>{},
        defaultVignette = snapshot.data()?['vignette'] ?? <String, dynamic>{},
        defaultAssurance = snapshot.data()?['assurance'] ?? <String, dynamic>{},
        defaultStationnement =
            snapshot.data()?['stationnement'] ?? <String, dynamic>{};

  toFirestore() {
    return {
      'name': model,
      'model': model,
      'typeCarburant': type_carburant,
      'assurance': defaultAssurance,
      'controle': defaultControle,
      'stationnement': defaultStationnement,
      'vignette': defaultVignette
    };
  }
}
