import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kdg/components/blur.dart';
import 'package:kdg/views/cars.dart';


class Home extends StatefulWidget {
	Home({
		Key key
	}): super(key: key);

	@override
	_HomeState createState() => _HomeState();
}

class _HomeState extends State < Home > {
	ScrollController _controller;

	@override
	void initState() {
		super.initState();
		_controller = new ScrollController();
	}
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: SafeArea(
				child: Padding(
					padding: EdgeInsets.only(left: 10.0, right: 10.0),
					child: Column(
						children: < Widget > [
							Padding(
								padding: EdgeInsets.all(10.0),
								child: Row(
									children: < Widget > [
										Spacer(),
										Material(
											elevation: 12.0,
											color: Colors.transparent,
											shadowColor: Colors.amber,
											borderRadius: BorderRadius.all(Radius.circular(20.0)),
											child: CircleAvatar(
												backgroundColor: Colors.transparent,
												child: Image.asset("assets/bald-man.png", ),

											),
										),

									],
								),
							),
							Expanded(
								child: ListView(
									controller: _controller,
									physics: BouncingScrollPhysics(),
									children: < Widget > [
										Padding(
											padding: EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0, top: 25.0),
											child: Stack(
												children: < Widget > [
													Card(
														borderOnForeground: false,
														color: Colors.transparent,
														elevation: 15.0,
														shadowColor: Colors.blueGrey,
														child: Hero(

															tag: "cars",
															child: GestureDetector(
																onTap: () {
																	Navigator.of(context).push(MaterialPageRoute(builder: (_) => Cars()));
																},
																child: ClipRRect(
																	borderRadius: BorderRadius.circular(20.0),
																	child: Image.asset("assets/dix-sept.jpg"),
																),
															),
														),
													),
													Positioned(
														bottom: 8.0,
														left: 20.0,
														child: BlurCard(
															child: Text("Cars", style: GoogleFonts.dancingScript(
																color: Colors.white,
																fontSize: 30,
																fontWeight: FontWeight.bold
															), ),
														),
													),

												]
											)
										),
										Padding(
											padding: EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0, top: 25.0),
											child: ClipRRect(
												borderRadius: BorderRadius.circular(20.0),
												child: Image.asset("assets/treze.jpg")
											)
										),
										Padding(
											padding: EdgeInsets.only(bottom: 15.0, left: 15.0, right: 15.0, top: 25.0),
											child: ClipRRect(
												borderRadius: BorderRadius.circular(20.0),
												child: Image.asset("assets/huit.jpg")
											)
										),
									],
								),
							)
						],
					),
				)
			)
		);
	}
}