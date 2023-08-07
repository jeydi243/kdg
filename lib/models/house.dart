import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kdg/models/document.dart';
import 'package:kdg/models/user.dart';

class House {
  late String nom;
  late String id;
  late String location_gps;
  late UserKDG owner;
  late List<Document> documents;

  House(this.nom, this.id, this.location_gps, this.owner);

  House.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    id = snapshot.id;
    this.nom = snapshot.get('nom') ?? '';
    this.location_gps = snapshot.get('location_gps') ?? '';
    this.owner = snapshot.get('owner') ?? '';
  }
  Map<String, dynamic> get print {
    Map<String, dynamic> map = {};
    map['id'] = this.id;
    map['owner'] = this.owner.nom;
    map['nom'] = this.nom;
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
