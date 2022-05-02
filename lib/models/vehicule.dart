import 'package:flutter/material.dart';

class Vehicule {
  String model;
  late String id;
  String nom;
  Map<String, dynamic> assurance;
  Map<String, dynamic> controle;
  Map<String, dynamic> stationnement;
  Map<String, dynamic> vignette;
  List<Map<String, dynamic>> get listDocuments =>
      [assurance, controle, stationnement, vignette];
  String get Nom => nom;
  Vehicule({
    this.model,
    this.nom,
    this.assurance,
    this.controle,
    this.stationnement,
    this.vignette,
  });
  Vehicule.fromMap(Map<String, dynamic> snapshot)
      : id = snapshot['id'] ?? '',
        nom = snapshot['nom'] ?? '',
        model = snapshot['model'] ?? '',
        assurance = snapshot['assurance'] ?? <String, int>{},
        controle = snapshot['controle'] ?? <String, int>{},
        stationnement = snapshot['stationnement'] ?? <String, int>{},
        vignette = snapshot['vignette'] ?? <String, int>{};
}
