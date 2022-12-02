import 'package:flutter/material.dart';

class SizeMe extends StatefulWidget {
  SizeMe({Key? key, required this.child}) : super(key: key);
  Widget child;
  @override
  State<SizeMe> createState() => _SizeMeState();
}

class _SizeMeState extends State<SizeMe> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1700),
    )..repeat(reverse: true); // automatically animation will be started
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      child: widget.child,
      sizeFactor: CurvedAnimation(
        curve: Curves.fastOutSlowIn,
        parent: controller,
      ),
    );
  }
}
