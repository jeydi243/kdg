class Rapport implements Type {
	late String id;
	String mois;
	late int heures;
	late int etudes;
	int visites;
	int publications;

	Rapport({
		required this.id,
		required this.heures,
		required this.mois,
		required this.etudes,
		required this.publications,
		required this.visites
	});

	Rapport.fromMap(Map<String,dynamic> snapshot):
		id = snapshot['id'] ?? '',
		mois = snapshot['mois'] ?? '',
		heures = snapshot['heures'] ?? '',
		etudes = snapshot['etudes'] ?? '',
		publications = snapshot['publications'] ?? '',
		visites = snapshot['visites'] ?? '';

	toJson() {
		return {
			"etudes": etudes,
			"heures": heures,
			"mois": mois,
			"publications": publications,
			"visites": visites,
		};
	}
}