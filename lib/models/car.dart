import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kdg/models/document.dart';

class Car {
  String model;
  String nom;
  String type_carburant;
  String color;
  String year;
  String brand;
  Map<String, dynamic> price;

  late String id;
  late List<Map<String, dynamic>> assurances;
  late List<Map<String, dynamic>> stationnements;
  late List<Map<String, dynamic>> vignettes;
  late List<Map<String, dynamic>> controles;

  String get typeCarburant => type_carburant;
  Map<String, dynamic> get assurance => assurances.firstWhere(
      (doc) =>
          (doc['debut'] as Timestamp).compareTo(
              Timestamp.fromMillisecondsSinceEpoch(
                  DateTime.now().millisecondsSinceEpoch)) >=
          1,
      orElse: () => {});
  Map<String, dynamic> get vignette => vignettes.firstWhere(
      (doc) =>
          (doc['debut'] as Timestamp).compareTo(
              Timestamp.fromMillisecondsSinceEpoch(
                  DateTime.now().millisecondsSinceEpoch)) >=
          1,
      orElse: () => {});
  Map<String, dynamic> get stationnement => stationnements.firstWhere(
      (doc) =>
          (doc['debut'] as Timestamp).compareTo(
              Timestamp.fromMillisecondsSinceEpoch(
                  DateTime.now().millisecondsSinceEpoch)) >=
          1,
      orElse: () => {});
  Map<String, dynamic> get controle => controles.firstWhere(
      (doc) =>
          (doc['debut'] as Timestamp).compareTo(
              Timestamp.fromMillisecondsSinceEpoch(
                  DateTime.now().millisecondsSinceEpoch)) >=
          1,
      orElse: () => {});

  List<Map<String, dynamic>?> get listDocuments =>
      [assurance, controle, stationnement, vignette];
  Map<String, Map<String, dynamic>?> get documents => {
        "controle_technique": controle,
        "vignette": vignette,
        "assurance": assurance,
        "stationnement": stationnement
      };

  Map<String, String> get infos => {
        "model": model,
        "year": year,
        "color": color,
        "type_carburant": type_carburant,
        "price": price['montant']
      };

  String get Nom => nom;
  Car({
    required this.model,
    required this.brand,
    required this.price,
    required this.year,
    required this.nom,
    required this.color,
    required this.id,
    required this.type_carburant,
  });
  Car.fromMap(Map<String, dynamic> snapshot)
      : id = snapshot['id'] ?? '',
        nom = snapshot['name'] ?? '',
        type_carburant = snapshot['type_carburant'] ?? '',
        model = snapshot['model'],
        brand = snapshot['brand'],
        year = snapshot['year'],
        price = snapshot['price'],
        color = snapshot['color'],
        controles =
            List<Map<String, dynamic>>.from(snapshot['controle_technique']),
        vignettes = List<Map<String, dynamic>>.from(snapshot['vignette']),
        assurances = List<Map<String, dynamic>>.from(snapshot['assurance']),
        stationnements =
            List<Map<String, dynamic>>.from(snapshot['stationnements']);

  Car.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : nom = snapshot.get('nom'),
        id = snapshot.id,
        model = snapshot.get("model"),
        color = snapshot.get('color'),
        year = snapshot.get('year'),
        price = snapshot.get('price'),
        brand = snapshot.get('brand'),
        type_carburant = snapshot.get("type_carburant"),
        controles =
            List<Map<String, dynamic>>.from(snapshot.get("controle_technique")),
        vignettes = List<Map<String, dynamic>>.from(snapshot.get('vignette')),
        assurances = List<Map<String, dynamic>>.from(snapshot.get('assurance')),
        stationnements =
            List<Map<String, dynamic>>.from(snapshot.get('stationnement'));

  toFirestore() {
    return {
      'name': model,
      'model': model,
      'typeCarburant': type_carburant,
      'assurance': assurance,
      'controle_technique': controles,
      'stationnement': stationnements,
      'vignette': vignettes
    };
  }
}
