import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kdg/models/document.dart';
import 'package:kdg/models/user.dart';

class House {
  late String nom;
  late String id;
  late String location_gps;
  late UserKDG owner;
  late List<Document> documents;
  late Map<String, dynamic> locataire;

  House(this.nom);

  House.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    id = snapshot.id;
    nom = snapshot.get('name') ?? '';
  }
  Map<String, dynamic> get print {
    Map<String, dynamic> map = {};
    map['id'] = this.id;
    map['owner'] = this.owner.nom;
    map['location_gps'] = this.id;
    return map;
  }

  toFirestore() {
    return {
      "nom": nom,
      "documents": documents.map((e) => e.id).toList(),
    };
  }
}
