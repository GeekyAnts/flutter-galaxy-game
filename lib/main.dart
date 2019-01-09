import 'dart:math';

import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart' ;

import 'package:flame/flame.dart';
import 'package:galaxygame/bullet.dart';
import 'package:galaxygame/dragon.dart';
import 'package:galaxygame/galaxy.dart';

const SPEED = 40.0;
const CRATE_SIZE = 40.0;
const BULLET_SIZE = 40.0;


var points = 0;
Dragon dragon;
Bullet bullet;

var game;

double touchPositionDx = 0.0;
double touchPositionDy = 0.0;


main() async {
  Flame.audio.disableLog();
  Flame.images.loadAll(['fire.png', 'dragon.png', 'gun.png', 'bullet.png']);


  var dimensions = await Flame.util.initialDimensions();


  game = new Galaxy(dimensions);
  runApp(MaterialApp(home: Scaffold(body: Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: GameWrapper(game)))));

  HorizontalDragGestureRecognizer horizontalDragGestureRecognizer =
  new HorizontalDragGestureRecognizer();

  // Adds ondrag feature to fire bullets
  Flame.util.addGestureRecognizer(horizontalDragGestureRecognizer
    ..onUpdate = (startDetails) => game.dragInput(startDetails.globalPosition));

  // Adds onTap feature to fire bullets
  Flame.util.addGestureRecognizer(new TapGestureRecognizer()
    ..onTapDown = (TapDownDetails evt) => game.tapInput(evt.globalPosition));
}


class GameWrapper extends StatelessWidget {
  final Galaxy game;
  GameWrapper(this.game);

  @override
  Widget build(BuildContext context) {
    return game.widget;
  }
}

