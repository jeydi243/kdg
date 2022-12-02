import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kdg/models/document.dart';

class Maison {
  late String nom;
  late String id;
  late List<Document> documents;
  late Map<String, dynamic> locataire;

  Maison(this.nom);

  Maison.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    id = snapshot.id;
    nom = snapshot.get('name') ?? '';
  }

  toFirestore() {
    return {
      "nom": nom,
      "documents": documents.map((e) => e.id).toList(),
    };
  }
}
