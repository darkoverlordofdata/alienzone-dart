part of alienzone;

const String GROUP_PLATFORMS  = "PLATFORMS";

class PlatformEntity extends AbstractEntity {

  PlatformEntity(entities, int x, int y, String key, [int scale = 1])
  : super(entities) {

    Artemis.Entity platform = level.artemis.createEntity();
    platform
    ..addComponent(new Sprite(x, y, key))
    ..addComponent(new Scale(scale, scale))
    ..addComponent(new Immovable(true))
    ..addToWorld();
    groupManager.add(platform, GROUP_PLATFORMS);
  }

}