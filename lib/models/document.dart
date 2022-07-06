import 'package:cloud_firestore/cloud_firestore.dart';

class Document {
  String? id;
  late String name;
  late DateTime startValidity;
  late DateTime endValidity;
  late String description;
  late String linkFile;
  String? idCar;

  Document(
    this.name,
    this.startValidity,
  );
  Document.fromMap(QueryDocumentSnapshot snapshot, this.id) {
    startValidity = snapshot['startValidity'] ?? null;
    endValidity = snapshot['endValidity'] ?? null;
    description = snapshot['description'] ?? '';
    linkFile = snapshot['linkFile'] ?? '';
    idCar = snapshot['idCar'];
    name = snapshot.get('name') ?? '';
    id = id;
  }
  Document.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    id = snapshot.id;
    name = snapshot.get('name') ?? '';
    idCar = snapshot.get('idCar') ?? '';
    linkFile = snapshot['linkFile'] ?? '';
    endValidity = snapshot['endValidity'] ?? null;
    description = snapshot['description'] ?? '';
    startValidity = snapshot['startValidity'] ?? null;
  }

  toFirestore() {
    return {
      "startValidity": startValidity,
      "endValidity": endValidity,
      "description": description,
      "linkFile": linkFile,
      "idCar": idCar,
      "name": name,
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
