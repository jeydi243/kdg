import 'package:cloud_firestore/cloud_firestore.dart';

class Rapport implements Type {
  String _id;
  String _mois;
  int _heures;
  int _etudes;
  int _visites;
  int _publications;

  Rapport(this._id, this._heures, this._mois, this._etudes, this._publications,
      this._visites);

  Rapport.fromMap(Map<String, dynamic> snapshot)
      : _id = snapshot['id'] ?? '',
        _mois = snapshot['mois'] ?? '',
        _heures = snapshot['heures'] ?? '',
        _etudes = snapshot['etudes'] ?? '',
        _publications = snapshot['publications'] ?? '',
        _visites = snapshot['visites'] ?? '';

  Rapport.fromFirebase(QueryDocumentSnapshot snapshot) 
      : _id = snapshot['id'] ?? '',
        _mois = snapshot['mois'] ?? '',
        _heures = snapshot['heures'] ?? '',
        _etudes = snapshot['etudes'] ?? '',
        _publications = snapshot['publications'] ?? '',
        _visites = snapshot['visites'] ?? '';

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      "etudes": _etudes,
      "heures": _heures,
      "mois": _mois,
      "publications": _publications,
      "visites": _visites,
    };
  }
}
