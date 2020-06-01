import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdg/animations/fadein.dart';


class Cars extends StatefulWidget {
	Cars({
		Key key
	}): super(key: key);

	@override
	_CarsState createState() => _CarsState();
}

class _CarsState extends State < Cars > {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.amber,
			body: Stack(

				children: < Widget > [
					Positioned(
						top: 0.0,
						left: 0.0,
						right: 0.0,
						child: SizedBox(
							height: (MediaQuery.of(context).size.height / 2) + 40,
							width: double.maxFinite,
							child: Hero(tag: 'cars', child: Image.asset("assets/dix-sept.jpg", fit: BoxFit.fill, )),
						),
					),
					Positioned(
						left: 0.0,
						top: MediaQuery.of(context).size.height / 2,
						bottom: 10.0,
						right: 0.0,
						// height: 300.toDouble(),
						child: Container(
							width: double.infinity,
							height: MediaQuery.of(context).size.height,
							decoration: BoxDecoration(
								color: Colors.amber,
								borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0), topRight: Radius.circular(40.0)),
								// image: DecorationImage(image: AssetImage("assets/un.jpg"))
							),
							child: Padding(padding: EdgeInsets.all(15.0),
								child: ListView(
									physics: BouncingScrollPhysics(),
									children: < Widget > [
										Padding(padding: EdgeInsets.only(bottom: 10.0),
											child: FadeIn( Container(
												  	child: Padding(
												  		padding: EdgeInsets.all(5.0),
												  		child: Column(
												  			mainAxisAlignment: MainAxisAlignment.spaceBetween,
												  			children: < Widget > [
												  				Row(
												  					children: < Widget > [
												  						Text("Audi Q5 Quattro", style: GoogleFonts.lora(
												  							color: Colors.blue,
												  							fontSize: 30,
												  							fontWeight: FontWeight.bold,

												  						), )
												  					],
												  				),
												  				Row(
												  					children: < Widget > [
												  						Text("Controle Technique")
												  					],
												  				),
												  				Row(
												  					children: < Widget > [
												  						Text("Assurance")
												  					],
												  				),
												  				Row(
												  					children: < Widget > [
												  						Text("Stationnement"),
												  						Spacer(),

												  						MaterialButton(
												  							height: 30,
												  							minWidth: 50,
												  							child: Text("Voir", style: TextStyle(
												  								color: Colors.white
												  							), ),
												  							onPressed: () {

												  							},
												  							color: Colors.blue, )
												  					],
												  				)
												  			],
												  		),
												  	),
												  	height: 150,
												  	width: 250.0,
												  	decoration: BoxDecoration(
												  		color: Colors.white,
												  		border: Border(
												  			left: BorderSide(
												  				color: Colors.blue,
												  				style: BorderStyle.solid,
												  				width: 5.0
												  			)
												  		)

												  	),
												  ),
												)),
										Padding(padding: EdgeInsets.only(bottom: 10.0),
											child: FadeIn(Container(
											  	height: 150,
											  	width: 250.0,
											  	decoration: BoxDecoration(
											  		color: Colors.white,
											  		border: Border(
											  			left: BorderSide(
											  				color: Colors.teal,
											  				style: BorderStyle.solid,
											  				width: 3.0
											  			)
											  		)

											  	),
											  ),
											)),
										Padding(padding: EdgeInsets.only(bottom: 10.0),
											child: FadeIn(Container(
											  	height: 150,
											  	width: 250.0,
											  	decoration: BoxDecoration(
											  		color: Colors.white,
											  		border: Border(
											  			left: BorderSide(
											  				color: Colors.red,
											  				style: BorderStyle.solid,
											  				width: 3.0
											  			)
											  		)

											  	),
											  ),
											)),
									],
								),
							),
						),
					)
				],
			),
		);
	}
}