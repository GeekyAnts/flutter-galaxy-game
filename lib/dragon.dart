import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:galaxygame/explosion.dart';
import 'package:galaxygame/main.dart';

class Dragon extends SpriteComponent {
  bool explode = false;
  double maxY;

  double positionX;

  Dragon({this.positionX}) : super.square(CRATE_SIZE, 'dragon.png');

  @override
  void update(double t) {
    y += t * SPEED;

//    print("y -> ${y}");
    if (game != null && dragon != null && bullet != null && y > 0.0) {
//      print("bullet.toPosition().toOffset() -> ${bullet.toPosition().toOffset()}");
//      print("dragon.toRect().toString() -> ${dragon.toRect().toString()}");
      bool remove = this.toRect().contains(bullet.toPosition().toOffset());
      if (remove) {
        dragon.explode = true;
        game.add(new Explosion(dragon));
      }
    }
  }

  @override
  bool destroy() {
    if (explode) {
      print("exploded");
      return true;
    }
    if (y == null || maxY == null) {
      return false;
    }
    bool destroy = y >= maxY + CRATE_SIZE / 2;
    if (destroy) {
//      points -= 20;
//      Flame.audio.play('miss.mp3');
    }
    return destroy;
//    bool destroy = this.y==this.maxY;
//    return destroy;
  }

  @override
  void resize(Size size) {
    this.x = positionX;
    this.y = 0.0;
    this.maxY = size.height;
  }
}