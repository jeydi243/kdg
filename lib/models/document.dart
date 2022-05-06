import 'package:cloud_firestore/cloud_firestore.dart';

class Document {
  String? name;
  String? id;
  DateTime? startValidity;
  DateTime? endValidity;
  late String description;
  late String linkFile;

  Document({
    this.name,
    this.startValidity,
  });
  Document.fromMap(QueryDocumentSnapshot snapshot, this.id) {
    name = snapshot.get('name') ?? '';
    id = id;
    startValidity = snapshot['startValidity'] ?? null;
    endValidity = snapshot['endValidity'] ?? null;
    description = snapshot['description'] ?? '';
    linkFile = snapshot['linkFile'] ?? '';
  }
}
