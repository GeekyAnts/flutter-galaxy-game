import 'dart:math';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart' show Colors, TextPainter, runApp;

import 'package:flame/game.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/animation_component.dart';
import 'package:flame/flame.dart';

const SPEED = 100.0;
const CRATE_SIZE = 50.0;

var points = 0;

main() async {
  Flame.audio.disableLog();
  Flame.images.loadAll(['explosion.png', 'crate.png', 'bullet.png']);

  var game = new MyGame();
  runApp(game.widget);

  Flame.audio.loop('music.ogg');
  Flame.util.addGestureRecognizer(new TapGestureRecognizer()
    ..onTapDown = (TapDownDetails evt) => game.input(evt.globalPosition));
}

class Crate extends SpriteComponent {
  bool explode = false;
  double maxY;

  Crate() : super.square(CRATE_SIZE, 'crate.png');

  @override
  void update(double t) {
    y += t * SPEED;
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
      points -= 20;
      Flame.audio.play('miss.mp3');
    }
    return destroy;
  }

  @override
  void resize(Size size) {
    this.x = rnd.nextDouble() * (size.width - CRATE_SIZE);
    this.y = 0.0;
    this.maxY = size.height;
  }
}

class Bullet extends SpriteComponent {
  bool explode = false;
  double maxY;

  Bullet() : super.square(CRATE_SIZE, 'bullet.png');

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
      points -= 20;
      Flame.audio.play('miss.mp3');
    }
    return destroy;
  }

  @override
  void resize(Size size) {
    this.x = size.width / 2;
    this.y = size.height;
    this.maxY = size.height;
  }
}

class Explosion extends AnimationComponent {
  static const TIME = 0.75;

  Explosion(Crate crate)
      : super.sequenced(CRATE_SIZE, CRATE_SIZE, 'explosion-4.png', 7,
            textureWidth: 31.0, textureHeight: 31.0) {
    this.x = crate.x;
    this.y = crate.y;
    this.animation.stepTime = TIME / 7;
  }

  bool destroy() {
    return this.animation.isLastFrame;
  }
}

Random rnd = new Random();

class MyGame extends BaseGame {
  double creationTimer = 0.0;

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    String text = points.toString();
    TextPainter p = Flame.util
        .text(text, color: Colors.white, fontSize: 48.0, fontFamily: 'Halo');
    p.paint(canvas,
        new Offset(size.width - p.width - 10, size.height - p.height - 10));
  }

  @override
  void update(double t) {
    creationTimer += t;
    if (creationTimer >= 1) {
      creationTimer = 0.0;
      add(new Crate());
      add(new Bullet());
    }
    super.update(t);
  }

  void input(Offset position) {
    components.forEach((component) {
      if (!(component is Crate)) {
        return;
      }
      Crate crate = component as Crate;
      bool remove = crate.toRect().contains(position);
      if (remove) {
        crate.explode = true;
        add(new Explosion(crate));
        Flame.audio.play('explosion.mp3');
        points += 10;
      }
    });
  }
}
