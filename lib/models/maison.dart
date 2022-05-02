class Maison{
  late String nom;
  late String id;
  Maison(this.nom);
  Maison.fromMap(Map<String, dynamic> snapshot)
      : id = snapshot['id'] ?? '',
        nom = snapshot['nom'];
}
