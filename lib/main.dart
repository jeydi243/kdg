import 'package:flutter/material.dart';
import 'package:kdg/XD_ConfigurationMain.dart';
import 'package:kdg/services/auth.dart';
import 'package:kdg/views/home.dart';
import 'package:kdg/views/login.dart';
import 'package:provider/provider.dart';
import 'package:supercharged/supercharged.dart';

void main() {
	runApp(Kdg());
}

class Kdg extends StatelessWidget {
	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) {
		return MultiProvider(
			providers: [
				Provider < Auth > (
					create: (_) => Auth(),
					lazy: false,
				)
			],
			child: MaterialApp(
				title: 'Kdg',
				debugShowCheckedModeBanner: false,
				theme: ThemeData(
					primarySwatch: Colors.blue,
					visualDensity: VisualDensity.adaptivePlatformDensity,
				),
				home: Builder(
					builder: (context) {
						return FutureBuilder(
							future: Provider.of < Auth > (context).currentUser(),
							builder: (context, snap) {
								return AnimatedSwitcher(
									duration: 500.milliseconds,
									child: snap.data == null ? LoginPage() : Home(),
								);
							},
						);
					},
				)

			),
		);
	}
}