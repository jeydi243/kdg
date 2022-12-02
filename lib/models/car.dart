import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  String model;
  String nom;
  String type_carburant;
  String color;
  String year;
  String brand;
  Map<String, dynamic> price;

  late String id;
  late Map<String, dynamic> assurance;
  late Map<String, dynamic> stationnement;
  late Map<String, dynamic> vignette;
  late Map<String, dynamic> controle;

  String get typeCarburant => type_carburant;
  String get Nom => nom;
  int? dayLeft(String docname) {
    var now = DateTime.now();
    print("FIN: ${documents[docname]!['fin']}");
    if (documents[docname]!['fin'] != null) {
      Timestamp fin = documents[docname]!['fin'] is Timestamp
          ? documents[docname]!['fin']
          : Timestamp.fromDate(DateTime.parse(documents[docname]!['fin']));
      var diffDt = fin.toDate().difference(now);
      return diffDt.inDays;
    }
    return 0;
  }

  String linkDoc(String docname) {
    return documents[docname]!['file'];
  }

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
        year = snapshot['year'],
        model = snapshot['model'],
        brand = snapshot['brand'],
        price = snapshot['price'],
        color = snapshot['color'],
        controle = Map<String, dynamic>.from(snapshot['controle_technique']),
        vignette = Map<String, dynamic>.from(snapshot['vignette']),
        assurance = Map<String, dynamic>.from(snapshot['assurance']),
        stationnement = Map<String, dynamic>.from(snapshot['stationnement']),
        type_carburant = snapshot['type_carburant'] ?? '';

  Car.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : id = snapshot.id,
        nom = snapshot.get('nom'),
        year = snapshot.get('year'),
        model = snapshot.get("model"),
        color = snapshot.get('color'),
        price = snapshot.get('price'),
        brand = snapshot.get('brand'),
        type_carburant = snapshot.get("type_carburant"),
        controle =
            Map<String, dynamic>.from(snapshot.get("controle_technique")),
        vignette = Map<String, dynamic>.from(snapshot.get('vignette')),
        assurance = Map<String, dynamic>.from(snapshot.get('assurance')),
        stationnement =
            Map<String, dynamic>.from(snapshot.get('stationnement'));

  toFirestore() {
    return {
      'name': model,
      'model': model,
      'typeCarburant': type_carburant,
      'assurance': assurance,
      'controle_technique': controle,
      'stationnement': stationnement,
      'vignette': vignette
    };
  }
}
