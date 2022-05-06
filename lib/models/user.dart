import 'package:cloud_firestore/cloud_firestore.dart';

class UserKDG implements Type {
  late String _id;
  late String _name;
  late String _email;
  late String _telephone;
  late String _provider;
  late String _imgsrc;
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
    return "$nom, $email, $imgsrc, $creation, $provider, ID:$id";
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

  UserKDG.fromFirebase(QueryDocumentSnapshot map,String id) {
    _id =id;
    _name = map['name'];
    _imgsrc = map['imgsrc'];
    _email = map['email'];
    _telephone = map['telephone'];
    _provider = map['provider'];
    _creation = map['creation'];
  }
  UserKDG.fromFirebase2(DocumentSnapshot map,String id) {
    _id =id;
    _name = map['name'];
    _imgsrc = map['imgsrc'];
    _email = map['email'];
    _telephone = map['telephone'];
    _provider = map['provider'];
    _creation = map['creation'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'name': nom,
      'email': _email,
      'imgsrc': imgsrc,
      'provider': _provider,
			'creation': _creation,
    };
  }
}
