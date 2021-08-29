import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:kdg/constantes/helper.dart';
import 'package:kdg/services/user_service.dart';
import 'package:kdg/views/home.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPassword = false;
  bool _obscureText = false;
  Map<String, String> _map = <String, String>{"email": "", "password": ""};
  TextEditingController textController;
  TextEditingController passController;
  FocusNode _focus;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    textController = new TextEditingController(text: "email@email.com");
    passController = new TextEditingController(text: "123456789");
    _focus = new FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: SafeArea(
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Bienvenue",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Text("Ravis de te revoir",
                      style: Theme.of(context).textTheme.headline5),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    // Add TextFormFields and ElevatedButton here.
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: textController,
                        enableInteractiveSelection: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ce champ est requis';
                          }
                          return null;
                        },
                        onSaved: (newValue) => _map['email'] = newValue,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Email@email.com",
                            isDense: true,
                            labelText: "Email",
                            alignLabelWithHint: true,
                            focusColor: Colors.grey[200],
                            filled: true,
                            fillColor: Colors.grey[200]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: passController,
                        enableInteractiveSelection: true,
                        keyboardType: TextInputType.text,
                        keyboardAppearance: Brightness.dark,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ce champ est requis';
                          }
                          return null;
                        },
                        onSaved: (newValue) => _map['password'] = newValue,
                        decoration: InputDecoration(
                            isDense: true,
                            hintText: "********",
                            labelText: "Mot de passe",
                            alignLabelWithHint: true,
                            // suffix: IconButton(
                            //     onPressed: () {
                            //       setState(() {
                            //         _obscureText = !_obscureText;
                            //       });
                            //     },
                            //     icon: Icon(
                            //         _obscureText ? Icons.lock : Icons.lock_open)),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: Icon(_obscureText
                                    ? Icons.lock
                                    : Icons.lock_open)),
                            focusColor: Colors.grey[200],
                            filled: true,
                            fillColor: Colors.grey[200]),
                        obscureText: _obscureText,
                      ),
                    ),
                    MaterialButton(
                        minWidth: Get.width * .9,
                        color: Colors.lightBlueAccent,
                        textColor: Colors.white,
                        highlightElevation: 5,
                        onPressed: () async {
                          // print(userService.currentUser);
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            try {
                              var user =
                                  await userService.signInWithEmailAndPassword(
                                      email: _map['email'],
                                      password: _map['password']);
                              if (user is User) {
                                print(userService.currentUser);
                                Get.to(Home());
                              }
                            } catch (e) {
                              Logger().i("Une Erreur de connexion: $e");
                            }
                          }
                        },
                        child: const Text('Se connecter')),
                    Helper.divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GFIconButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                try {
                                  var user =
                                      await userService.signInWithFacebook();
                                  if (user is User) {
                                    print(userService.currentUser);
                                    Get.to(Home());
                                  }
                                } catch (e) {
                                  Logger().i("Une Erreur de connexion: $e");
                                }
                              }
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.facebookF,
                              size: 16,
                            ),
                            shape: GFIconButtonShape.circle,
                            buttonBoxShadow: true,
                            boxShadow: BoxShadow(
                              blurRadius: 10,
                              color: Colors.blue[50],
                            ),
                          ),
                        ),
                        GFIconButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              try {
                                var user = await userService.signInWithGoogle();
                                if (user is User) {
                                  print(userService.currentUser);
                                  Get.to(Home());
                                }
                              } catch (e) {
                                Logger().i("Une Erreur de connexion: $e");
                              }
                            }
                          },
                          color: Colors.red,
                          focusColor: Colors.red,
                          highlightColor: Colors.red,
                          icon: FaIcon(
                            FontAwesomeIcons.google,
                            size: 16,
                          ),
                          shape: GFIconButtonShape.circle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                "En vous connectant vous accepter les conditions d'utilisation et les regles de confidentialité de KDG",
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
        ),
      )),
    );
  }
}
