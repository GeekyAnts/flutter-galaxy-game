import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:galaxygame/bullet.dart';
import 'package:galaxygame/dragon.dart';
import 'package:galaxygame/explosion.dart';
import 'package:galaxygame/main.dart';

class Galaxy extends BaseGame {
  double creationTimer = 0.0;
  bool checkOnce = true;

  List<Dragon> dragonList= <Dragon>[];


  Size dimenstions;


  Galaxy(this.dimenstions);

  @override
  void render(Canvas canvas) {
    super.render(canvas);

//    print("rendered");
    String text = points.toString();
    TextPainter p = Flame.util
        .text(text, color: Colors.white, fontSize: 48.0, fontFamily: 'Halo');

    p.paint(canvas,
        new Offset(size.width - p.width - 10, size.height - p.height - 10));
  }

  @override
  void update(double t) {
//    creationTimer += t;
//    if (creationTimer >= 5) {
//      creationTimer = 0.0;
    if (checkOnce) {
      checkOnce = false;

//    bullet = new Bullet();

//    add(bullet);

      for (int i = 1; i <= CRATE_SIZE / 7; i++) {
        // dragon = new Dragon(dimenstions,0,0);
        // add(dragon);
        for (int j = 0; j < i; ++j) {
          dragon = new Dragon(dimenstions, i, j);
          dragonList.add(dragon);
          add(dragon);
        }
      }

      print("dragonList -> ${dragonList}");
//      bullet = new Bullet();
//      add(bullet);
//    }

//    components.forEach((component) {
//      print("component -> ${component.toString()}");

//        if(dragon!=null&&bullet!=null) {
//          print("bullet.toPosition().toOffset() -> ${bullet.toPosition().toOffset()}");
//          bool remove = dragon.toRect().contains(bullet.toPosition().toOffset());
//          if (remove) {
//            dragon.explode = true;
//            add(new Explosion(dragon));
//          }
//        }
//    });

    }

    super.update(t);

  }


    void tapInput(Offset position) {
      print("direction: ${position.direction}");
      touchPositionDx = position.dx;
      touchPositionDy = position.dy;
      bullet = new Bullet(dragonList);
      add(bullet);
    }

    void dragInput(Offset position) {
      print("direction: ${position.direction}");
      touchPositionDx = position.dx;
      touchPositionDy = position.dy;
//    bullet = new Bullet();
//    add(bullet);
    }
}
