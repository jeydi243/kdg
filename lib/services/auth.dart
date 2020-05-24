import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
	Future < String > signIn(String email, String password);
	Future < String > signUp(String email, String password, String nom);
	Future < String > currentUser();
	Future < void > signOut();

}
class Auth implements BaseAuth {
	FirebaseAuth _fbAuth;
	Auth() {
		_fbAuth  = FirebaseAuth.instance;
	}
	Future < String > signIn(String email, String password) async {
		FirebaseUser user = (await _fbAuth.signInWithEmailAndPassword(email: email, password: password)).user;
		return user.uid;
	}
	Future < String > signUp(String email, String password, String nom) async {
		FirebaseUser user = (await _fbAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
		return user.uid;
	}
	Future < void > signOut() async {
		return _fbAuth.signOut();
	}
	Future < String > currentUser() async {
		FirebaseUser user = await _fbAuth.currentUser();
		return user?.uid;
	}

}