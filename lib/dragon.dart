import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:galaxygame/main.dart';

class Dragon extends SpriteComponent {
  Size dimenstions;
  int postion;
  int ypostion;
  bool explode = false;
  double maxY;

  Dragon(this.dimenstions, this.postion, this.ypostion)
      : super.square(CRATE_SIZE, 'dragon.png');

  @override
  void update(double t) {
    y += gameOver ? 0 : (t * DRAGONSPEED);
  }

  @override
  bool destroy() {
    if (explode) {
      return true;
    }
    if (y == null || maxY == null) {
      return false;
    }
    bool destroy = y >= maxY + CRATE_SIZE / 2;
    if (destroy) {
      gameOver = true;

      print("Game over");
      return true;
    }
    return destroy;
  }

  @override
  void resize(Size size) {
    this.x = (CRATE_SIZE * postion);
    this.y = CRATE_SIZE * ypostion;
    this.maxY = size.height;
  }
}
