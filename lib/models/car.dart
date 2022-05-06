import 'package:kdg/models/document.dart';

class Car {
  String model;
  late String id;
  String nom;
  late Document assurance;
  late Document controle;
  late Document stationnement;
  late Document vignette;
  List<Document> get listDocuments =>
      [assurance, controle, stationnement, vignette];
  String get Nom => nom;
  Car({
    required this.model,
    required this.nom,
    required this.assurance,
    required this.controle,
    required this.stationnement,
    required this.vignette,
  });
  Car.fromMap(Map<String, dynamic> snapshot)
      : id = snapshot['id'] ?? '',
        nom = snapshot['nom'] ?? '',
        model = snapshot['model'] ?? '',
        assurance = snapshot['assurance'] ?? <String, int>{},
        controle = snapshot['controle'] ?? <String, int>{},
        stationnement = snapshot['stationnement'] ?? <String, int>{},
        vignette = snapshot['vignette'] ?? <String, int>{};
}
