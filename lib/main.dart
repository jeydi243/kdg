import 'package:flutter/material.dart';
import 'package:kdg/services/auth.dart';
import 'package:kdg/views/login.dart';
import 'package:provider/provider.dart';
import 'views/page.dart';

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
				home: Builder(
					builder: (context) {
						return FutureBuilder(
							future: Provider.of < Auth > (context).currentUser(),
							builder: (context, snap) {
								if (snap.hasData) {
									return MyPage();
								}else{
									return LoginPage();
								}
							},
						);
					},
				)

			),
		);
	}
}