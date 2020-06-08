import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:kdg/animations/fadein.dart';
import 'package:kdg/components/pageV.dart';
import 'package:kdg/components/perso.dart';
import 'package:kdg/services/auth.dart';
import 'package:kdg/views/login.dart';
import 'package:pigment/pigment.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:slimy_card/slimy_card.dart';

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
		Auth auth = Provider.of < Auth > (context);
		String _emailOrNomv = "";
		return Scaffold(
			backgroundColor: Colors.white,
			bottomNavigationBar: CurvedNavigationBar(
				key: _bottomNavigationKey,
				backgroundColor: Colors.white, //Background color of selected
				buttonBackgroundColor: Pigment.fromString("#FFBA02"),
				animationCurve: Curves.ease,
				animationDuration: Duration(milliseconds: 600),
				color: Colors.grey.withOpacity(0.2),
				height: 55,
				index: 1,
				items: < Widget > [
					Icon(Icons.supervised_user_circle, size: 30, color: Pigment.fromString("200540")),
					Icon(Icons.local_movies, size: 30, color: Pigment.fromString("200540")),
					Icon(FontAwesomeIcons.shieldAlt, color: Pigment.fromString("200540"))
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
											left: 5,
											bottom: 10
										),
										child: FadeIn(IconButton(onPressed: () {

										}, icon: Icon(FontAwesomeIcons.bars), color: Pigment.fromString("200540"))),
									),
									Spacer(),
									Padding(
										padding: EdgeInsets.only(
											top: MediaQuery.of(context).padding.top,
											right: 5,
											bottom: 10
										),
										child: GestureDetector(
											onTap: () {
												auth.signOut().then((d) => MaterialPageRoute(builder: (context) => LoginPage()));
											},
											child: CircleAvatar(
												backgroundColor: Colors.amber,
												backgroundImage: NetworkImage("https://via.placeholder.com/150"),
											),
										),
									)
								],
							),
							Builder(
								builder: (context) {
									if (_page == 0) {
										return Expanded(
											child: FadeIn(PageV()),
										);
									} else if (_page == 1) {
										return Expanded(
											child: FadeIn(SizedBox(
												height: double.infinity,
												width: double.infinity,
												child: ListView(
													physics: BouncingScrollPhysics(),
													children: < Widget > [
														SlimyCard(
															color: Colors.blueGrey,

															width: 200,
															topCardHeight: 400,
															bottomCardHeight: 200,
															borderRadius: 15,
															topCardWidget: Container(
																color: Colors.green
															),
															bottomCardWidget: Container(
																height: 50,
																color: Colors.red
															),
															slimeEnabled: true,
														),
													]
												),
											), ),
										);
									} else {
										return Expanded(
											child: Container(
												child: DefaultTabController(
													length: 3,
													initialIndex: 0,
													child: Column(
														children: < Widget > [
															FadeIn(Padding(
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
															), ),
															FadeIn(
																SizedBox(
																	height: 30.0,
																	child: Stack(
																		fit: StackFit.loose,
																		children: [
																			Align(
																				alignment: Alignment(0, 1),
																				child: Container(
																					color: Pigment.fromString("200540"),
																					height: 0.5,
																					width: double.infinity,
																				),
																			),
																			TabBar(
																				indicatorColor: Colors.amber,
																				tabs: < Widget > [
																					Tab(
																						child: Text("Liste", style: GoogleFonts.lobster(
																							color: Pigment.fromString("200540")
																						), ),
																					),
																					Tab(
																						child: Text("Etudes", style: GoogleFonts.lobster(
																							color: Pigment.fromString("200540")
																						), ),
																					),
																					Tab(
																						child: Text("Notes", style: GoogleFonts.lobster(
																							color: Colors.black
																						), ),
																					),
																				],
																			),
																		]
																	),
																), ),
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