import 'package:flutter/material.dart';
import 'package:kdg/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdg/views/home.dart';

class Signup extends StatefulWidget {
	Signup({
		this.auth,
		this.move
	});
	final BaseAuth auth;
	final VoidCallback move;

	@override
	_SignupState createState() => _SignupState();
}

class _SignupState extends State < Signup > {
	final _formKey = GlobalKey < FormState > ();
	bool _canObscure = true;
	String _email;
	String _nom;
	String _password;

	Color _hexToColor(String code) {
		return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
	}
	Route _createRoute() {
		return PageRouteBuilder(
			pageBuilder: (context, animation, secondaryAnimation) => Home(),
			transitionsBuilder: (context, animation, secondaryAnimation, child) {
				var begin = Offset(0.0, 1.0);
				var end = Offset.zero;
				var tween = Tween(begin: begin, end: end);
				var offsetAnimation = animation.drive(tween);

				return SlideTransition(
					position: offsetAnimation,
					child: child,
				);
			},
		);
	}
	bool _validateandSave() {
		final form = _formKey.currentState;
		if (form.validate()) {
			form.save();
			print("le formulaire est pret");
			print('$_email et $_password');
			return true;
		} else {
			print("Erreur dans le formulaire");
			return false;
		}
	}
	void _submit() async {
		try {
			if (_validateandSave()) {
				String uid = await widget.auth.signUp(_email, _password, _nom);
				print("L'utilisateur s'est bien enregistré $uid");
				_formKey.currentState.reset();
				Navigator.of(context).push(_createRoute());
			}
		} catch (e) {
			print(e);
		}
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.white,
			body: Center(
				child: AnimatedContainer(
					duration: Duration(seconds: 1),
					curve: Curves.fastOutSlowIn,
					alignment: Alignment.center,
					decoration: BoxDecoration(
						color: Colors.white,
						borderRadius: BorderRadius.only(topRight: Radius.circular(10.0))
						// gradient: LinearGradient(
						// 	begin: Alignment.topCenter,
						// 	end: Alignment.bottomCenter,
						// 	colors: [Colors.white,Colors.white ,_hexToColor(fin)]),
					),
					padding: EdgeInsets.all(20.0),
					child: Center(
						child: Column(
							mainAxisAlignment: MainAxisAlignment.center,
							children: [
								Image.asset("images/conversation.png", fit: BoxFit.fill),
								Text("Rejoignez-nous!", softWrap: true,
									style: GoogleFonts.bubblegumSans(
										textStyle: TextStyle(
											color: Colors.yellow[800],
											fontSize: 35.0,
											letterSpacing: .5
										)
									),
								),
								new TextFormField(
									onSaved: (value) => _nom = value,
									validator: (value) => value.isEmpty ? "Le nom doit etre renseigné" : null,
									decoration: new InputDecoration(
										isDense: true,
										prefixIcon: Icon(Icons.account_circle, color: Colors.teal, ),
										labelText: "Nom",
										labelStyle: GoogleFonts.bubblegumSans(textStyle: TextStyle(
											color: Colors.teal,
										))
									),
								),
								new TextFormField(
									onSaved: (value) => _email = value,
									validator: (value) => value.isEmpty ? "L'email doit etre renseigné" : null,
									decoration: new InputDecoration(
										hoverColor: Colors.green,
										isDense: true,
										prefixIcon: Icon(Icons.email, color: Colors.teal, ),
										labelText: "Email",
										labelStyle: GoogleFonts.bubblegumSans(textStyle: TextStyle(
											color: Colors.teal,
										))
									),
								),
								new TextFormField(
									onSaved: (value) => _password = value,
									validator: (value) => value.isEmpty ? "Le mot de passe doit etre renseigné" : null,
									decoration: new InputDecoration(
										filled: true,
										isDense: true,
										prefixIcon: Icon(Icons.lock, color: Colors.teal),
										suffixIcon: FlatButton(
											child: _canObscure == true ? Text("SHOW") : Text("HIDE"),
											onPressed: () {
												setState(() {
													_canObscure = _canObscure ? false : true;
												});
											},
										),
										labelText: "Mot de passe",
										labelStyle: GoogleFonts.bubblegumSans(textStyle: TextStyle(
											color: Colors.teal,
										))
									),
									obscureText: _canObscure,
								),
								Row(
									children: < Widget > [
										Spacer(),
										FlatButton(
											padding: EdgeInsets.zero,
											child: Text("Reinitialisé ?",
												style: TextStyle(
													color: Colors.teal,
													fontWeight: FontWeight.w500
												), ),
											onPressed: widget.move,
										)
									],
								),
								ConstrainedBox(
									constraints: BoxConstraints(
										minWidth: MediaQuery.of(context).size.width
									),
									child: new RaisedButton(
										color: Colors.yellow[800],
										elevation: 12.0,

										shape: RoundedRectangleBorder(
											borderRadius: new BorderRadius.circular(18.0),
										),
										textColor: _hexToColor("#124A2C"),
										child: Text("M'enregistrer"),
										onPressed: _submit,
									),
								),


								Row(
									children: < Widget > [
										Spacer(),
										Text("Déja enregistré?"),
										FlatButton(
											padding: EdgeInsets.zero,
											child: Text("Connexion",
												style: TextStyle(
													color: Colors.teal,
													fontWeight: FontWeight.bold
												), ),
											onPressed: widget.move,
										),

									],
								)
							]
						),
					),
				),
			),
		);
	}
}