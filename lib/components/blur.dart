import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class BlurCard extends StatefulWidget {
	BlurCard({
		Key? key,
		required this.titre
	}): super(key: key);
	final String titre;
	@override
	_BlurCardState createState() => _BlurCardState();
}

class _BlurCardState extends State < BlurCard > {
	@override
	void initState() {
		super.initState();
	}
	@override
	Widget build(BuildContext context) {
		return Stack(
			children: [
				SizedBox(
					height: 50.0,
					width: double.maxFinite,
					child: ClipRRect(
						child: BackdropFilter(
							filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
							child: Container(
								color: Colors.black.withOpacity(0.2),
								child: Padding(
									padding: EdgeInsets.only(left: 10.0),
									child: Center(
									  child: Text('${widget.titre}', style: GoogleFonts.lobster(
									  	color: Colors.white,
									  	fontSize: 30,
									  	
									  ), ),
									),
								),
							),
						),
					),
				),
			]
		);
	}
}