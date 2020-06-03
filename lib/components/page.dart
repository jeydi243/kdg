import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:kdg/animations/fadein.dart';
import 'package:kdg/components/pageV.dart';
import 'package:kdg/components/perso.dart';
import 'package:pigment/pigment.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class MyPage extends StatefulWidget {
	MyPage({
		Key key
	}): super(key: key);

	@override
	_MyPageState createState() => _MyPageState();
}

class _MyPageState extends State < MyPage > {
	int _page = 1;
	GlobalKey _bottomNavigationKey = GlobalKey();
	@override
	Widget build(BuildContext context) {
		String _emailOrNomv = "";
		return Scaffold(
			backgroundColor: Colors.white,
			bottomNavigationBar: CurvedNavigationBar(
				key: _bottomNavigationKey,
				backgroundColor: Colors.white, //Background color of selected
				buttonBackgroundColor: Pigment.fromString("#FFBA02"),
				animationCurve: Curves.easeInOutBack,
				animationDuration: Duration(milliseconds: 600),
				color: Colors.grey.withOpacity(0.2),
				height: 55,
				index: 1,
				items: < Widget > [
					Icon(Icons.add, size: 30, color: Pigment.fromString("200540")),
					Icon(Icons.local_movies, size: 30, color: Pigment.fromString("200540")),
					Icon(FontAwesomeIcons.shieldAlt, color: Pigment.fromString("200540"), )
				],
				onTap: (index) {
					setState(() {
						_page = index;
					});
				},
			),
			body: Container(
				height: MediaQuery.of(context).size.height,
				width: MediaQuery.of(context).size.width,
				child: Padding(
					padding: EdgeInsets.all(10.0),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.start,
						children: < Widget > [
							Row(
								children: < Widget > [
									Padding(
										padding: EdgeInsets.only(
											top: MediaQuery.of(context).padding.top,
											left: 20,
										),
										child: FadeIn(Text("Hi, Chemo", style: GoogleFonts.lobster(
											fontWeight: FontWeight.normal,
											fontSize: 40
										), ), ),
									),
								],
							),

							Builder(
								builder: (context) {
									if (_page == 0) {
										print("page egale a 1");
										return Expanded(
											child: PageV(),
										);
									} else if (_page == 1) {
										print("page egale a 2");
										return Expanded(
											child: SizedBox(
												height: double.infinity,
												width: double.infinity,
												child: Column(
													children: < Widget > [
														FlutterLogo(size: 15.0, ),
														FlutterLogo(),
														FlutterLogo(),
														FlutterLogo(),
														FlutterLogo()
													],
												),
											),
										);
									} else {
										print("page egale a 3");
										return Expanded(
											child: Container(
												child: DefaultTabController(
													length: 3,
													initialIndex: 0,
													child: Column(
														children: < Widget > [
															Padding(
																padding: EdgeInsets.only(bottom: 10.0),
																child: Row(
																	children: < Widget > [
																		Expanded(
																			child: Container(
																				decoration: BoxDecoration(
																					color: Colors.grey.withOpacity(0.2),
																					borderRadius: BorderRadius.circular(20.0)
																				),
																				height: 40,
																				padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
																				child: TextFormField(
																					decoration: InputDecoration(
																						border: InputBorder.none,
																					),
																				),
																			),
																		)
																	],
																),
															),
															SizedBox(
																height: 30.0,
																child: TabBar(
																	indicatorColor: Pigment.fromString("200540"),
																	indicator: BoxDecoration(
																		color: Colors.amber
																	),
																	tabs: < Widget > [
																		Tab(
																			child: Text("Liste", style: GoogleFonts.lobster(
																				color: Colors.black
																			), ),
																			// icon: Icon(FontAwesomeIcons.accusoft,color: Pigment.fromString("200540")),
																		),
																		Tab(
																			child: Text("Etudes", style: GoogleFonts.lobster(
																				color: Colors.black
																			), ),
																			//icon: Icon(FontAwesomeIcons.addressCard, color: Pigment.fromString("200540")),
																		),
																		Tab(
																			child: Text("Notes", style: GoogleFonts.lobster(
																				color: Colors.black
																			), ),
																			//icon: Icon(FontAwesomeIcons.arrowsAltV, color: Pigment.fromString("#200540"), ),
																		),
																	],
																),
															),

															Expanded(
																child: TabBarView(
																	children: < Widget > [
																		Perso(),
																		Container(
																			color: Colors.white,
																		),
																		Container(
																			color: Colors.white,
																		),
																	],
																),
															)
														],
													),
												),
											)
										);
									}
								},
							),
						],
					),
				),
			),
		);
	}
}