class Maison{
  String nom;
  String id;
  Maison(this.nom);
  Maison.fromMap(Map<String, dynamic> snapshot)
      : id = snapshot['id'] ?? '',
        nom = snapshot['nom'];
}
