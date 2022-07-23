import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdg/animations/fadein.dart';
import 'package:kdg/constantes/helper.dart';
import 'package:kdg/services/user_service.dart';
import 'package:kdg/utils/utils.dart';
import 'package:kdg/views/home.dart';
import 'package:logger/logger.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPassword = false;
  bool _keepConnect = false;
  bool isConnecting = false;
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
          resizeToAvoidBottomInset: false,
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
                      FadeIn(
                        Text(
                          "Bienvenue",
                          style: Get.textTheme.headline1!.copyWith(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ),
                      FadeIn(
                        Text("Ravis de te revoir",
                            style: Get.textTheme.headline2!
                                .copyWith(fontWeight: FontWeight.w300)),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        // Add TextFormFields and ElevatedButton here.
                        FadeIn(
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                                labelText: "Email",
                              ),
                            ),
                          ),
                        ),
                        FadeIn(
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                              onSaved: (newValue) =>
                                  _map['password'] = newValue!,
                              decoration: InputDecoration(
                                hintText: "********",
                                labelText: "Mot de passe",
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    icon: Icon(_obscureText
                                        ? Icons.lock
                                        : Icons.lock_open)),
                              ),
                              obscureText: _obscureText,
                            ),
                          ),
                        ),
                        FadeIn(
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
                        ),
                        FadeIn(
                          MaterialButton(
                              minWidth: Get.width * .9,
                              color: HexColor.fromHex("#1CBFE2"),
                              
                              highlightElevation: 5,
                              elevation: 10,
                              onPressed: () async {
                                setState(() {
                                  isConnecting = !isConnecting;
                                });
                                Future.delayed(1.seconds, () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    setState(() {
                                      isConnecting = !isConnecting;
                                    });
                                    try {
                                      // await userService.signInWithEmailAndPassword(
                                      //     email: _map['email'] as String,
                                      //     password: _map['password'] as String);
                                      Get.to(() => Home());
                                    } catch (e) {
                                      setState(() {
                                        isConnecting = !isConnecting;
                                      });
                                      Logger().i("Une Erreur de connexion: $e");
                                    }
                                  }
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  isConnecting == true
                                      ? Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      Colors.white),
                                              strokeWidth: 2.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  Text('Se connecter'),
                                ],
                              )),
                        ),
                        FadeIn(Helper.divider()),
                        FadeIn(
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
                        ),
                      ],
                    ),
                  ),
                  FadeIn(
                    Text(
                      "En vous connectant vous accepter les conditions d'utilisation et les regles de confidentialité de KDG",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
