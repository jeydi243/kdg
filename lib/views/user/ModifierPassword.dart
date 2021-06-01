import 'package:flutter/material.dart';

class ModifierPassword extends StatefulWidget {
  ModifierPassword({Key key}) : super(key: key);

  @override
  _ModifierPasswordState createState() => _ModifierPasswordState();
}

class _ModifierPasswordState extends State<ModifierPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Placeholder(),
    );
  }
}
