import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kdg/services/auth.dart';
import 'package:kdg/views/page.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:pigment/pigment.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
	LoginPage({
		this.move,
		this.onSignedIn
	});
	final VoidCallback onSignedIn;
	final VoidCallback move;

	@override
	_LoginState createState() => _LoginState();
}

class _LoginState extends State < LoginPage > {
	final _formKey = GlobalKey < FormState > ();
	Auth auth;
	bool showIndicator;
	bool _canObscure;
	String fin = "#FAD961";
	String _emailOrNom;
	String _password;

	bool  _validateandSave() {
		final form = _formKey.currentState;
		if (form.validate()) {
			form.save();
			return true;
		} else {
			return false;
		}
	}
	void  _submit() async {
		if (_validateandSave()) {
			setState(() {
				showIndicator = false;
			});
			try {
				await auth.signIn(_emailOrNom, _password).then((uid) => {
					setState(() {
						_formKey.currentState.reset();
						showIndicator = true;
						Navigator.of(context).push(_createRoute());
					})
				});
			} catch (e) {
				print(e);
			}
		}

	}
	Route _createRoute() {
		return PageRouteBuilder(
			opaque: true,
			pageBuilder: (context, animation, secondaryAnimation) => MyPage(),
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

	@override
	void initState() {
		super.initState();
		showIndicator = true;
		_canObscure = false;
	}
	@override
	Widget build(BuildContext context) {
		auth = Provider.of < Auth > (context);
		return Scaffold(
			body: Container(
				height: double.infinity,
				width: double.infinity,
				child: Stack(
					alignment: AlignmentDirectional.center,
					children: [
						SizedBox.expand(
							child: FittedBox(
								fit: BoxFit.cover,
								child: Image.asset("assets/deux.jpg"),
							),
						),
						Container(
							padding: EdgeInsets.all(20.0),
							child: Form(
								key: _formKey,
								child: Column(
									mainAxisAlignment: MainAxisAlignment.spaceBetween,
									children: < Widget > [
										Column(
											children: < Widget > [
												new Text("Bonjour!",
													style: GoogleFonts.bubblegumSans(
														textStyle: TextStyle(
															color: Colors.amber,
															letterSpacing: .5,
															fontSize: 25.0,
														)
													)),
												new Text("Ravis de vous revoir",
													style: GoogleFonts.bubblegumSans(
														textStyle: TextStyle(
															color: Colors.amber,
															fontSize: 35.0,
															letterSpacing: .5
														)
													)
												),
											],
										),
										Column(
											mainAxisAlignment: MainAxisAlignment.spaceBetween,
											crossAxisAlignment: CrossAxisAlignment.center,
											children: < Widget > [
												new TextFormField(
													style: TextStyle(
														color: Colors.white.withOpacity(.5)
													),
													onSaved: (value) => _emailOrNom = value,
													cursorColor: Colors.green,
													validator: (value) => value.isEmpty ? "L'email ou le nom doit etre renseigné" : null,
													decoration: new InputDecoration(
														focusColor: Colors.amber.withOpacity(.5),
														isDense: true,
														fillColor: Colors.white.withOpacity(.2),
														filled: true,
														prefixIcon: Icon(Icons.email, color: Colors.amber),
														hintText: "Email ou Nom",
														labelText: "Email",
														labelStyle: GoogleFonts.bubblegumSans(textStyle: TextStyle(
															color: Colors.amber,
															decorationStyle: TextDecorationStyle.dashed
														)),
													),
												),
												new TextFormField(
													style: TextStyle(
														color: Colors.white.withOpacity(.5)
													),

													onSaved: (value) => _password = value,
													cursorColor: Colors.green,
													validator: (value) => value.isEmpty ? "Le mot de passe doit etre renseigné" : null,
													decoration: new InputDecoration(
														fillColor: Colors.white.withOpacity(.2),
														filled: true,
														isDense: true,
														prefixIcon: Icon(Icons.lock, color: Colors.amber),
														suffixIcon: FlatButton(
															child: _canObscure == true ? Text("SHOW", style: TextStyle(color: Colors.amber[200])) : Text("HIDE", style:
																TextStyle(color: Colors.amber[200])),
															onPressed: () {
																setState(() {
																	_canObscure = _canObscure ? false : true;
																});
															},
														),
														labelText: "Mot de passe",
														labelStyle: GoogleFonts.bubblegumSans(textStyle: TextStyle(
															color: Colors.amber,
														))
													),
													obscureText: _canObscure,
												),
												Row(
													mainAxisAlignment: MainAxisAlignment.end,
													children: < Widget > [
														new FlatButton(
															textColor: Colors.amber,
															child: Text("Réinitialisé ?", style: TextStyle(color: Colors.amber), ),
															onPressed: widget.move,
														)
													],
												),

											],
										),


										Column(
											children: < Widget > [
												FittedBox(
													fit: BoxFit.fill,
													child: showIndicator ? new RaisedButton(
														elevation: 12.0,
														textColor: Pigment.fromString("#124A2C"),
														child: new Text("Connexion", style: TextStyle(fontSize: 17.0)),
														shape: RoundedRectangleBorder(
															borderRadius: new BorderRadius.circular(18.0),
														),
														color: Colors.amber,
														onPressed: _submit
													) : Loading(indicator: BallPulseIndicator(), size: 60.0, color: Colors.amber)
												),
												Row(
													mainAxisAlignment: MainAxisAlignment.center,
													children: < Widget > [
														Text("Vous etes nouveau ?",
															style: TextStyle(color: Colors.white),
														),

														FlatButton(
															textColor: Colors.amber,
															child: Text("M'inscrire", style: TextStyle(color: Colors.amber), ),
															onPressed: widget.move,
														)
													],
												),
											],
										),

									]
								)
							),

						)
					]
				),
			),
		);
	}
}