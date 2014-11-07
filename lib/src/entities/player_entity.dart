part of alienzone;

const String TAG_PLAYER = "PLAYER";

class PlayerEntity extends AbstractEntity {

  PlayerEntity(entities, int x, int y, String key, Map cells)
  : super(entities) {

    Entity player = world.createEntity();
    player
      ..addComponent(new Sprite(x, y, key))
      ..addComponent(new Velocity(0, 0))
      ..addComponent(new Gravity(0, 300))
      ..addComponent(new Bounce(0, .2))
      ..addComponent(new Animation(cells))
      ..addToWorld();
    tagManager.register(player, TAG_PLAYER);

  }

}