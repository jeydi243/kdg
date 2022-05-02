import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:kdg/constantes/helper.dart';
import 'package:kdg/services/user_service.dart';
import 'package:kdg/utils/utils.dart';
import 'package:kdg/views/home.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPassword = false;
  bool _keepConnect = false;
  bool _obscureText = false;
  Map<String, String> _map = <String, String>{"email": "", "password": ""};
  late TextEditingController textController;
  late TextEditingController passController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    textController = new TextEditingController(text: "ekadiongo@gmail.com");
    passController = new TextEditingController(text: "123456789");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserService userService = Get.find();
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
                        onSaved: (newValue) => _map['email'] = newValue!,
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
                        onSaved: (newValue) => _map['password'] = newValue!,
                        decoration: InputDecoration(
                            isDense: true,
                            hintText: "********",
                            labelText: "Mot de passe",
                            alignLabelWithHint: true,
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
                    CheckboxListTile(
                      value: _keepConnect,
                      onChanged: (value) {
                        setState(() {
                          _keepConnect = value!;
                        });
                      },
                      // checkColor: HexColor.fromHex("#1CBFE2"),
                      activeColor: HexColor.fromHex("#1CBFE2"),
                      dense: true,
                      title: Text('Rester connecté ?'),
                    ),
                    MaterialButton(
                        minWidth: Get.width * .9,
                        color: HexColor.fromHex("#1CBFE2"),
                        textColor: Colors.white,
                        highlightElevation: 5,
                        elevation: 10,
                        onPressed: () async {
                          // print(userService.currentUser);
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            try {
                              // await userService.signInWithEmailAndPassword(
                              //     email: _map['email'] as String,
                              //     password: _map['password'] as String);
                              Get.to(Home());
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
                        GFIconButton(
                          onPressed: () async {
                            await userService.signInWithGoogle();
                          },
                          color: Colors.red,
                          focusColor: Colors.red,
                          highlightColor: Colors.red,
                          icon: FaIcon(
                            FontAwesomeIcons.google,
                            size: 16,
                          ),
                          shape: GFIconButtonShape.pills,
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
