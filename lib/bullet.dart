import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:galaxygame/main.dart';

class Bullet extends SpriteComponent {
  bool explode = false;
  double maxY;

  Bullet() : super.square(CRATE_SIZE, 'gun.png');

  @override
  void update(double t) {
    y -= t * SPEED;
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
//      points += 20;
//      Flame.audio.play('miss.mp3');
    }
    return destroy;
  }

  @override
  void resize(Size size) {
    this.x = touchPositionDx;
    this.y = touchPositionDy;
    this.maxY = size.height;
  }
}