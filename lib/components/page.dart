import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:kdg/animations/fadein.dart';
import 'package:kdg/components/pageV.dart';
import 'package:kdg/models/rapport.dart';
import 'package:pigment/pigment.dart';



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
			floatingActionButton: FloatingActionButton(
				onPressed: () {

				},
				backgroundColor: Colors.blue,
			),
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
					Icon(Icons.accessibility_new, size: 30, color: Pigment.fromString("200540")),
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
										child: FadeIn(Text("Hi, \nChémo",style: GoogleFonts.lobster(
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
											child: StreamBuilder(

												stream: Firestore.instance.collection("rapports").snapshots(),
												builder: (context, snapshot) {
													List < Rapport > _rapports = [];
													for (DocumentSnapshot doc in snapshot.data.documents) {
														_rapports.add(Rapport.fromMap(doc.data, doc.documentID));
													}
													if (snapshot.hasData) {
														return ListView.builder(
															physics: BouncingScrollPhysics(),
															itemCount: snapshot.data.documents.length,
															itemBuilder: (context, index) {
																return Card(
																	elevation: 7.0,
																	child: ListTile(

																		contentPadding: EdgeInsets.all(5.0),
																		dense: true,
																		leading: Container(
																			height: 50,
																			width: 50,
																			color: Colors.greenAccent,
																		),
																		title: Text("${_rapports[index].mois}", style: GoogleFonts.abhayaLibre(
																			fontSize: 25
																		), ),
																	),
																);
															}

														);
													} else {
														return ListView(
															children: < Widget > [
																CircularProgressIndicator()
															],
														);
													}
												},
											),
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