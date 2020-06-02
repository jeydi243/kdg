class Rapport {
	String id;
	String mois;
	int heures;
	int etudes;
	int visites;
	int publications;

	Rapport({
		this.id,
		this.heures,
		this.mois,
		this.etudes,
		this.publications,
		this.visites
	});

	Rapport.fromMap(Map snapshot, String id):
		id = id ?? '',
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