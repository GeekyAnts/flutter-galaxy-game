import 'package:galaxygame/main.dart';

class CollisionBox {
  final double x;
  final double y;
  final double width;
  final double height;
  const CollisionBox({
    this.x,
    this.y,
    this.width,
    this.height,
  });
}

bool checkCollision(Bullet bullet, Crate crate) {
  bool crashed = false;
  CollisionBox crateBox = CollisionBox(
    x: crate.x + 1,
    y: crate.y + 1,
    width: crate.width,
    height: crate.height,
  );
  CollisionBox bulletBox = CollisionBox(
    x: bullet.x + 1,
    y: bullet.y + 1,
    width: bullet.width,
    height: bullet.height,
  );
  if (boxCompare(bulletBox, crateBox)) {
    //crashed = true;
    print("inside");
    List<CollisionBox> collisionBoxes = crate.collisionBoxes;
    List<CollisionBox> bulletCollision = bullet.bulletCollision;
    collisionBoxes.forEach((obstacle) {
      print(obstacle);
      CollisionBox adjObstacleBox =
          createAdjustedCollisionBox(obstacle, crateBox);
      print("inside ${adjObstacleBox.y}");
      bulletCollision.forEach((bulletCollisionBox) {
        CollisionBox adjBulletBox =
            createAdjustedCollisionBox(bulletCollisionBox, bulletBox);
        crashed = crashed || boxCompare(adjBulletBox, adjObstacleBox);
        print("inside ${adjBulletBox.y}");
        print("in $crashed");
      });
    });
    //print(crashed);
    return crashed;
  }
  return crashed;
}

bool boxCompare(CollisionBox bulletBox, CollisionBox crateBox) {
  final double obstacalX = crateBox.x;
  final double obstacalY = crateBox.y;

  return (bulletBox.x < obstacalX + crateBox.width &&
      bulletBox.x + bulletBox.width > obstacalX &&
      bulletBox.y < crateBox.y + crateBox.height &&
      bulletBox.height + bulletBox.y > obstacalY);
}

CollisionBox createAdjustedCollisionBox(
    CollisionBox box, CollisionBox adjustment) {
  return CollisionBox(
    x: box.x + adjustment.x,
    y: box.y + adjustment.y,
    width: box.width,
    height: box.height,
  );
}
