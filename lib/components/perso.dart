import 'package:flutter/material.dart';
import 'package:kdg/animations/fadein.dart';
import 'package:kdg/models/rapport.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';


class Perso extends StatefulWidget {
	Perso({
		Key key
	}): super(key: key);

	@override
	_PersoState createState() => _PersoState();
}

class _PersoState extends State < Perso > {
	@override
	Widget build(BuildContext context) {
		return StreamBuilder(
			stream: Firestore.instance.collection("rapports").snapshots(),
			builder: (context, snapshot) {
				if (snapshot.hasData) {
					List < Rapport > _rapports = [];
					for (DocumentSnapshot doc in snapshot.data.documents) {
						_rapports.add(Rapport.fromMap(doc.data, doc.documentID));
					}
					return FadeIn(ListView.builder(
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

					), );
				} else {
					return FadeIn(ListView(
						children: < Widget > [
							ClipRRect(
								borderRadius: BorderRadius.circular(15.0),
								child: Container(
									color: Colors.black.withOpacity(0.2)
								),
							),
							ClipRRect(
								borderRadius: BorderRadius.circular(15.0),
								child: Container(
									color: Colors.black.withOpacity(0.2)
								),
							),
							ClipRRect(
								borderRadius: BorderRadius.circular(15.0),
								child: Container(
									color: Colors.black.withOpacity(0.2)
								),
							),
							ClipRRect(
								borderRadius: BorderRadius.circular(15.0),
								child: Container(
									color: Colors.black.withOpacity(0.2)
								),
							),
						],
					), );
				}
			},
		);
	}
}