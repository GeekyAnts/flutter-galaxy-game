import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:galaxygame/bullet.dart';
import 'package:galaxygame/dragon.dart';
import 'package:galaxygame/main.dart';

class Galaxy extends BaseGame {
  bool checkOnce = true;

  List<Dragon> dragonList = <Dragon>[];
  List<Bullet> bulletList = <Bullet>[];
  Size dimenstions;

  Galaxy(this.dimenstions);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    String text = points.toString();
    TextSpan span = TextSpan(text: text, style: TextStyle(fontSize: 48.0, color:Colors.white, fontFamily: 'Halo'));
    TextPainter p = TextPainter(text: span, textDirection: TextDirection.ltr);
    p.layout(minWidth: 0.0);
    
    String over = "Game over";
    TextSpan spann = TextSpan(text: over, style: TextStyle(fontSize: 48.0, color:Colors.white, fontFamily: 'Halo'));
    TextPainter overGame = TextPainter(text: spann, textDirection: TextDirection.ltr);
    overGame.layout(minWidth: 0.0);
   
    gameOver
        ? overGame.paint(canvas, Offset(size.width / 5, size.height / 2))
        : p.paint(canvas,
            new Offset(size.width - p.width - 10, size.height - p.height - 10));
  }

  double creationTimer = 0.0;
  @override
  void update(double t) {
    creationTimer += t;
    if (creationTimer >= 4) {
      creationTimer = 0.0;

      for (int i = 1; i <= DRAGON_SIZE / 7; i++) {
        for (int j = 0; j < i; ++j) {
          dragon = new Dragon(dimenstions, i, j);
          dragonList.add(dragon);
          add(dragon);
        }
      }
    }
    super.update(t);
  }

  void tapInput(Offset position) {
    touchPositionDx = position.dx;
    touchPositionDy = position.dy;
    bulletStartStop = true;
    bulletList.add(bullet);
    bullet = new Bullet(dragonList, bulletList);
    add(bullet);
  }

  void dragInput(Offset position) {
    touchPositionDx = position.dx;
    touchPositionDy = position.dy;
    bulletStartStop = true;
  }

  void onUp() {
    bulletStartStop = false;
  }
}
