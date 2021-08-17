import 'package:flutter/material.dart';

class Vehicule {
  String model;
  String id;
  String nom;
  Map<String, String> assurance;
  Map<String, String> controle;
  Map<String, String> stationnement;
  Map<String, String> vignette;
  List<Map<String, String>> get listDocuments =>
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
  Vehicule.fromMap(Map snapshot)
      : id = snapshot['id'] ?? '',
        nom = snapshot['nom'] ?? '',
        assurance = snapshot['assurance'] ?? '',
        controle = snapshot['controle'] ?? '',
        stationnement = snapshot['stationnement'] ?? '',
        vignette = snapshot['vignette'] ?? '';
}
