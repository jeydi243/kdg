class Rapport {
  String id;
  String mois;
  String heures;
  String etudes;

  Rapport({this.id, this.heures, this.mois,this.etudes});

  Rapport.fromMap(Map snapshot,String id) :
        id = id ?? '',
        mois = snapshot['mois'] ?? '',
        heures = snapshot['heures'] ?? '',
        etudes = snapshot['etudes'] ?? '';

  toJson() {
    return {
      "etudes": etudes,
      "heures": heures,
      "mois": mois,
    };
  }
}