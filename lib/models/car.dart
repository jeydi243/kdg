import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kdg/models/document.dart';

class Car {
  String model;
  String nom;
  String type_carburant;
  String color;
  String year;
  String brand;
  Document? assurance;
  Document? controle_technique;
  Document? stationnement;
  Document? vignette;

  DocumentReference? assurance_ref;
  DocumentReference? controle_technique_ref;
  DocumentReference? stationnement_ref;
  DocumentReference? vignette_ref;
  Map<String, dynamic> price;

  late String id;

  String get typeCarburant => type_carburant;

  List<Document?> get listDocuments =>
      [assurance, controle_technique, stationnement, vignette];
  Map<String, Document?> get documents => {
        "controle_technique": controle_technique,
        "vignette": vignette,
        "assurance": assurance,
        "stationnement": stationnement
      };
  Map<String, String?> get documentsID => {
        "controle_technique": controle_technique?.id,
        "vignette": vignette?.id,
        "assurance": assurance?.id,
        "stationnement": stationnement?.id
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
        controle_technique_ref = snapshot['controle_technique'],
        vignette_ref = snapshot['vignette'],
        assurance_ref = snapshot['assurance'],
        stationnement_ref = snapshot['stationnement'];

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
        controle_technique_ref = snapshot.get("controle_technique"),
        vignette_ref = snapshot.get('vignette'),
        assurance_ref = snapshot.get('assurance'),
        stationnement_ref = snapshot.get('stationnement');

  toFirestore() {
    return {
      'name': model,
      'model': model,
      'typeCarburant': type_carburant,
      'assurance': assurance,
      'controle_technique': controle_technique,
      'stationnement': stationnement,
      'vignette': vignette
    };
  }
}
