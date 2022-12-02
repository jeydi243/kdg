import 'package:cloud_firestore/cloud_firestore.dart';

class Document {
  String? id;
  late String name;
  late DateTime startDate;
  late DateTime endDate;
  late String description;
  late String file;
  String? idCar;

  Document(
    this.name,
    this.startDate,
  );
  Document.fromMap(QueryDocumentSnapshot snapshot, this.id) {
    startDate = snapshot['startDate'] ?? null;
    endDate = snapshot['endDate'] ?? null;
    description = snapshot['description'] ?? '';
    file = snapshot['file'] ?? '';
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
    file = snapshot['file'] ?? '';
    endDate = snapshot['endDate'] ?? null;
    description = snapshot['description'] ?? '';
    startDate = snapshot['startDate'] ?? null;
  }

  toFirestore() {
    return {
      "startDate": startDate,
      "endDate": endDate,
      "description": description,
      "file": file,
      "idCar": idCar,
      "name": name,
    };
  }

  bool isValid() {
    if (endDate.isAfter(DateTime.now()) ||
        endDate.isAtSameMomentAs(DateTime.now())) {
      return true;
    }
    return false;
  }

  int timeRemaining() {
    if (endDate.isAfter(DateTime.now()) ||
        endDate.isAtSameMomentAs(DateTime.now())) {
      return endDate.difference(DateTime.now()).inDays;
    }
    return 0;
  }
}
