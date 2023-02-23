import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password, String nom);
  Future<String?> current();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  late FirebaseAuth _fbAuth;
  Auth() {
    _fbAuth = FirebaseAuth.instance;
  }
  Future<String> signIn(String email, String password) async {
    UserCredential usercred = await _fbAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return usercred.user!.uid;
  }

  Future<String> signUp(String email, String password, String nom) async {
    UserCredential usercred = await _fbAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return usercred.user!.uid;
  }

  Future<void> signOut() async {
    return _fbAuth.signOut();
  }

  String? currentUserUid() {
    User? user = _fbAuth.currentUser;
    return user?.uid;
  }

  FirebaseAuth get AuthState => _fbAuth;

  @override
  Future<String?> current() async {
    User? user = await _fbAuth.currentUser;
    return user?.uid;
  }
}
