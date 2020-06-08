import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdg/animations/fadein.dart';
import 'package:kdg/components/blur.dart';

class CarsHome extends StatefulWidget {
	CarsHome({
		Key key,
		this.name,
		this.title
	}): super(key: key);
	final String name;
	final String title;

	@override
	_CarsHomeState createState() => _CarsHomeState();
}

class _CarsHomeState extends State < CarsHome > {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Container(
				height: MediaQuery.of(context).size.height,
				width: MediaQuery.of(context).size.width,
				child: Stack(
					children: < Widget > [
						SizedBox(
							height: MediaQuery.of(context).size.height,
							width: MediaQuery.of(context).size.width,
							child: Hero(tag: '${widget.title}', child: Image.asset(widget.name, fit: BoxFit.cover))
						),
						Align(alignment: Alignment(0, -0.80),
							child: Hero(tag: '${widget.name}2', child: BlurCard(titre: widget.title, ))
						),
						Align(
							alignment: Alignment(0, -0.60),
							child: Column(
								children: [
									Expanded(
										child: ListView(
											children: < Widget > [
												Padding(
													padding: EdgeInsets.all(10.0),
													child: Container(
														height: 50,
														width: 200,
														color: Colors.white,
														child: Text("Assurance",style: GoogleFonts.romanesco(
															fontSize: 25,
															fontWeight: FontWeight.bold
														),),
													),
												),
												Padding(
													padding: EdgeInsets.all(10.0),
													child: Container(
														height: 50,
														width: 200,
														color: Colors.white,
													),
												),
												Padding(
													padding: EdgeInsets.all(10.0),
													child: Container(
														height: 50,
														width: 200,
														color: Colors.white,
													),
												),



											],

										),
									),
								]
							),
						)
					],
				),
			),
		);
	}
}