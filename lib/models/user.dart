import 'package:cloud_firestore/cloud_firestore.dart';
import 'rapport.dart';

class UserKDG {
  String _id;
  String _name;
  String _email;
  String _telephone;
  String _provider;
  String _imgsrc;
  var _creation;

//getters
  String get nom => _name;
  String get id => _id;
  String get imgsrc => _imgsrc;
  String get provider => _provider;
  String get email => _email;
  String get telephone => _telephone;
  get creation => _creation;

//setters
  set setImage(String url) {
    _imgsrc = url;
  }

  set telephone(String telephone) {
    _telephone = telephone;
  }

  // ignore: unnecessary_getters_setters
  set nom(String nom) {
    _name = nom;
  }

  @override
  String toString() {
    return "$nom,$email,$imgsrc,$creation, $provider, ID:$id";
  }

  UserKDG.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _name = map['name'];
    _imgsrc = map['imgsrc'];
    _email = map['email'];
    _telephone = map['telephone'];
    _provider = map['provider'];
    _creation = map['creation'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': nom,
      'imgsrc': imgsrc,
    };
  }
}
