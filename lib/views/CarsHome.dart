import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdg/animations/fadein.dart';
import 'package:kdg/components/blur.dart';

class CarsHome extends StatefulWidget {
	CarsHome({
		Key key,
		this.name
	}): super(key: key);
	final String name;
	@override
	_CarsHomeState createState() => _CarsHomeState();
}

class _CarsHomeState extends State < CarsHome > {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Stack(
				children: < Widget > [
					Align(alignment: Alignment(0,0), child: Hero(tag: 'un${widget.name}', child: BlurCard())),
					
					SizedBox(
						height: MediaQuery.of(context).size.height,
						width: MediaQuery.of(context).size.width,
						child: Hero(
							tag: widget.name,
							child: Image.asset(widget.name, fit: BoxFit.cover, ),

						)
					),
					SafeArea(
						child: FadeIn(
							Text("le Monde est Bleu",style: GoogleFonts.lobster(
								color: Colors.white,
								fontSize: 40
							),)
						),
					)
				],
			),
		);
	}
}