class Maison {
  String nom;
  String id;
  Maison(this.nom);
  Maison.fromMap(Map<String, dynamic> snapshot)
      : nom = snapshot['id'] ?? '',
        id = snapshot['id'];
}
