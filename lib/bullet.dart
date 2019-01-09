import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:galaxygame/dragon.dart';
import 'package:galaxygame/explosion.dart';
import 'package:galaxygame/main.dart';

class Bullet extends SpriteComponent {
  bool explode = false;
  double maxY;
  List<Dragon> dragonList= <Dragon>[];

  Bullet(this.dragonList) : super.square(BULLET_SIZE, 'gun.png');

  @override
  void update(double t) {
    y -= t * SPEED;

    if(dragonList.isNotEmpty)
    dragonList.forEach((dragon){
      bool remove = this.toRect().contains(dragon.toPosition().toOffset());
      if (remove) {
        dragon.explode = true;
        dragonList.remove(dragon);
        game.add(new Explosion(dragon));
      }
    });

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