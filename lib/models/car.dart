import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kdg/models/document.dart';

class Car {
  String model;
  String nom;
  String type_carburant;
  Document? assurance;
  Document? controle_technique;
  Document? stationnement;
  Document? vignette;

  late String id;
  late String defaultControle;
  late String defaultAssurance;
  late String defaultStationnement;
  late String defaultVignette;

  List<Document?> get listDocuments =>
      [assurance, controle_technique, stationnement, vignette];
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
        defaultControle = snapshot['controle_technique'],
        defaultVignette = snapshot['vignette'],
        defaultAssurance = snapshot['assurance'] ?? "",
        defaultStationnement = snapshot['stationnement'] ?? <String, dynamic>{};

  Car.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : nom = snapshot.data()?["nom"],
        id = snapshot.id,
        model = snapshot.data()?["model"],
        type_carburant = snapshot.data()?["type_carburant"],
        defaultControle = snapshot.get("controle_technique"),
        defaultVignette = snapshot.get('vignette'),
        defaultAssurance = snapshot.get('assurance'),
        defaultStationnement = snapshot.get('stationnement');

  toFirestore() {
    return {
      'name': model,
      'model': model,
      'typeCarburant': type_carburant,
      'assurance': defaultAssurance,
      'controle_technique': defaultControle,
      'stationnement': defaultStationnement,
      'vignette': defaultVignette
    };
  }
}
