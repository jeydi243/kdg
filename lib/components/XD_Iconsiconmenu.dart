import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter_svg/flutter_svg.dart';

class XD_Iconsiconmenu extends StatelessWidget {
  XD_Iconsiconmenu({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Transform(
          transform: Matrix4(0.0, -1.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0,
              1.0, 0.0, 0.0, 44.0, 0.0, 1.0),
          child:
              // Adobe XD layer: 'Rectangle' (shape)
              Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26.0),
              color: const Color(0xfffafafa),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(12.0, 12.0),
          child:
              // Adobe XD layer: 'icon-menu' (group)
              Stack(
            children: <Widget>[
              // Adobe XD layer: 'Rectangle' (shape)
              Container(
                width: 20.0,
                height: 20.0,
                decoration: BoxDecoration(),
              ),
              Transform.translate(
                offset: Offset(1.87, 6.25),
                child:
                    // Adobe XD layer: 'Path' (shape)
                    SvgPicture.string(
                  _shapeSVG_5a004c065a9649b4a127c72a8c4d1abc,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

const String _shapeSVG_5a004c065a9649b4a127c72a8c4d1abc =
    '<svg viewBox="1.9 6.2 16.3 7.5" ><path transform="translate(1.87, 6.25)" d="M 0.6339015364646912 6.276990461628884e-05 C 0.4085040986537933 -0.003124911105260253 0.1988507062196732 0.115297332406044 0.08522173017263412 0.3099833130836487 C -0.02840724401175976 0.5046692490577698 -0.02840724401175976 0.7454562783241272 0.08522173017263412 0.9401422142982483 C 0.1988507062196732 1.134828209877014 0.4085040986537933 1.253250479698181 0.6339015364646912 1.250062823295593 L 15.63390159606934 1.250062823295593 C 15.85929870605469 1.253250479698181 16.0689525604248 1.134828209877014 16.18258094787598 0.9401422142982483 C 16.29621124267578 0.7454562783241272 16.29621124267578 0.5046692490577698 16.18258094787598 0.3099833130836487 C 16.0689525604248 0.115297332406044 15.85929870605469 -0.003124911105260253 15.63390159606934 6.276990461628884e-05 L 0.6339015364646912 6.276990461628884e-05 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /><path transform="translate(1.87, 12.5)" d="M 0.6339015364646912 6.276990461628884e-05 C 0.4085040986537933 -0.003124911105260253 0.1988507062196732 0.115297332406044 0.08522173017263412 0.3099833130836487 C -0.02840724401175976 0.5046692490577698 -0.02840724401175976 0.7454562783241272 0.08522173017263412 0.9401422142982483 C 0.1988507062196732 1.134828209877014 0.4085040986537933 1.253250479698181 0.6339015364646912 1.250062823295593 L 15.63390159606934 1.250062823295593 C 15.85929870605469 1.253250479698181 16.0689525604248 1.134828209877014 16.18258094787598 0.9401422142982483 C 16.29621124267578 0.7454562783241272 16.29621124267578 0.5046692490577698 16.18258094787598 0.3099833130836487 C 16.0689525604248 0.115297332406044 15.85929870605469 -0.003124911105260253 15.63390159606934 6.276990461628884e-05 L 0.6339015364646912 6.276990461628884e-05 Z" fill="#000000" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
