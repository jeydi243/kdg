import 'package:cloud_firestore/cloud_firestore.dart';

class Document {
  String? id;
  late String name;
  late DateTime startValidity;
  late DateTime endValidity;
  late String description;
  late String linkFile;

  Document(
    this.name,
    this.startValidity,
  );
  Document.fromMap(QueryDocumentSnapshot snapshot, this.id) {
    name = snapshot.get('name') ?? '';
    id = id;
    startValidity = snapshot['startValidity'] ?? null;
    endValidity = snapshot['endValidity'] ?? null;
    description = snapshot['description'] ?? '';
    linkFile = snapshot['linkFile'] ?? '';
  }
  Document.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    name = snapshot.get('name') ?? '';
    id = snapshot.id;
    startValidity = snapshot['startValidity'] ?? null;
    endValidity = snapshot['endValidity'] ?? null;
    description = snapshot['description'] ?? '';
    linkFile = snapshot['linkFile'] ?? '';
  }

  toFirestore() {
    return {
      "name": name,
      "startValidity": startValidity,
      "endValidity": endValidity,
      "description": description,
      "linkFile": linkFile
    };
  }

  bool isValid() {
    if (endValidity.isAfter(DateTime.now()) ||
        endValidity.isAtSameMomentAs(DateTime.now())) {
      return true;
    }
    return false;
  }

  int timeRemaining() {
    if (endValidity.isAfter(DateTime.now()) ||
        endValidity.isAtSameMomentAs(DateTime.now())) {
      return endValidity.difference(DateTime.now()).inDays;
    }
    return 0;
  }
}
