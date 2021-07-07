class Car {
  String _model;
  String _nom;
  List<String> _imgsrc;
  String _id;
  String _stationnement;
  String _controleTechnique;

  List<String> get imgsrc => _imgsrc;
  String get nom => nom;
  String get model => _model;

  Car.from(Map<String, dynamic> map) {
    _nom = map["nom"];
    _id = map["id"];
    _nom = map["nom"];
    _stationnement = map["nom"];
    _controleTechnique = map["nom"];
    dynamic test1 = map['imgsrc'];
    _imgsrc = List<String>.from(test1);
  }
}
