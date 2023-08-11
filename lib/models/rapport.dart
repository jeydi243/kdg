import 'package:cloud_firestore/cloud_firestore.dart';

class Rapport implements Type {
  String _id;
  String _mois;
  int _heures;
  int _etudes;
  int _annee;
  int _visites;
  int _publications;
  String get mois => _mois;
  String get id => _id;
  int get annee => _annee;

  Rapport(this._id, this._heures, this._mois, this._etudes, this._annee,
      this._publications, this._visites);

  Rapport.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : _id = snapshot.id,
        _mois = snapshot['mois'] ?? '',
        _heures = snapshot['heures'] ?? '',
        _annee = snapshot['annee'] ?? '',
        _etudes = snapshot['etudes'] ?? '',
        _publications = snapshot['publications'] ?? '',
        _visites = snapshot['visites'] ?? '';

  Map<String, dynamic> toMap() {
    return {
      "annee": _annee,
      "mois": _mois,
      "etudes": _etudes,
      "heures": _heures,
      "visites": _visites,
      "publications": _publications,
      'id': _id,
    };
  }
}
