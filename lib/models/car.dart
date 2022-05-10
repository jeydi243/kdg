import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kdg/models/document.dart';

class Car {
  String model;
  String name;
  late String id;
  late Document assurance;
  late Document controle;
  late Document stationnement;
  late Document vignette;
  List<Document> get listDocuments =>
      [assurance, controle, stationnement, vignette];
  String get Nom => name;
  Car({
    required this.model,
    required this.name,
    required this.assurance,
    required this.controle,
    required this.stationnement,
    required this.vignette,
  });
  Car.fromMap(Map<String, dynamic> snapshot)
      : id = snapshot['id'] ?? '',
        name = snapshot['name'] ?? '',
        model = snapshot['model'] ?? '',
        assurance = snapshot['assurance'] ?? <String, int>{},
        controle = snapshot['controle'] ?? <String, int>{},
        stationnement = snapshot['stationnement'] ?? <String, int>{},
        vignette = snapshot['vignette'] ?? <String, int>{};

  Car.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : name = snapshot.data()?["name"],
        model = snapshot.data()?["model"];

  toFirestore() {
    return {
      'name': model,
      'model': model,
      'assurance': assurance.id,
      'controle': controle.id,
      'stationnement': stationnement.id,
      'vignette': vignette.id
    };
  }
  
}
