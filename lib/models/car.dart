import 'package:cloud_firestore/cloud_firestore.dart';

class Car {
  String model;
  String name;
  String owner;
  String carburant;
  String color;
  int year;
  String brand;
  Map<String, dynamic> price;

  late String id;
  late Map<String, dynamic> assurance;
  late Map<String, dynamic> stationnement;
  late Map<String, dynamic> vignette;
  late Map<String, dynamic> controle;

  String get typeCarburant => carburant;
  String get Nom => name;
  String get Owner => owner;
  (String, int) dayLeft(String docname) {
    var now = DateTime.now();
    print("FIN: ${documents[docname]!['fin']}");
    if (documents[docname]!.containsKey('year')) {
      return ("Valide", 1);
    } else if (documents[docname]!['fin'] != null) {
      Timestamp fin = documents[docname]!['fin'] is Timestamp
          ? documents[docname]!['fin']
          : Timestamp.fromDate(DateTime.parse(documents[docname]!['fin']));
      var diffDt = fin.toDate().difference(now);
      return diffDt.inDays > 0
          ? ("Il reste ${diffDt.inDays} jours avant expiration", diffDt.inDays)
          : ('Expiré depuis ${diffDt.inDays * -1} jours', diffDt.inDays);
    }
    return ("Expire Aujourd'hui", 0);
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

  Map<String, dynamic> get infos => {
        "model": model,
        "year": year,
        "color": color,
        "carburant": carburant,
        "price": price['montant']
      };

  Car({
    required this.model,
    required this.brand,
    required this.price,
    required this.year,
    required this.name,
    required this.owner,
    required this.color,
    required this.id,
    required this.carburant,
  });
  Car.fromMap(Map<String, dynamic> snapshot)
      : id = snapshot['id'] ?? '',
        name = snapshot['name'] ?? '',
        owner = snapshot['owner'] ?? '',
        year = snapshot['year'],
        model = snapshot['model'],
        brand = snapshot['brand'],
        price = snapshot['price'],
        color = snapshot['color'],
        controle = Map<String, dynamic>.from(snapshot['controle_technique']),
        vignette = Map<String, dynamic>.from(snapshot['vignette']),
        assurance = Map<String, dynamic>.from(snapshot['assurance']),
        stationnement = Map<String, dynamic>.from(snapshot['stationnement']),
        carburant = snapshot['carburant'] ?? '';

  Car.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : id = snapshot.id,
        name = snapshot.get('name'),
        owner = snapshot.get('owner'),
        year = snapshot.get('year'),
        model = snapshot.get("model"),
        color = snapshot.get('color'),
        price = snapshot.get('price'),
        brand = snapshot.get('brand'),
        carburant = snapshot.get("carburant"),
        controle =
            Map<String, dynamic>.from(snapshot.get("controle_technique")),
        vignette = Map<String, dynamic>.from(snapshot.get('vignette')),
        assurance = Map<String, dynamic>.from(snapshot.get('assurance')),
        stationnement =
            Map<String, dynamic>.from(snapshot.get('stationnement'));

  toFirestore() {
    return {
      'name': name,
      'owner': owner,
      'model': model,
      'typeCarburant': carburant,
      'assurance': assurance,
      'controle_technique': controle,
      'stationnement': stationnement,
      'vignette': vignette
    };
  }
}
