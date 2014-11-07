part of alienzone;

const String GROUP_STARS      = "STARS";

class StarEntity extends AbstractEntity {

  StarEntity(EntityFactory entities, int x, int y, String key)
  : super(entities) {

    Entity star = world.createEntity();
    star
      ..addComponent(new Sprite(x * 70, y, key))
      ..addComponent(new Gravity(0, 300))
      ..addComponent(new Bounce(0, 0.7 + entities.game.rnd.normal() * 0.2))
      ..addToWorld();
    groupManager.add(star, GROUP_STARS);

  }

}