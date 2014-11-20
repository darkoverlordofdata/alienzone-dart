part of alienzone;


class PlatformRenderSystem extends Artemis.VoidEntitySystem {

  BaseLevel level;

  PlatformRenderSystem(this.level);


  void initialize() {
    print("PlatformRenderSystem::initialize");
    Artemis.GroupManager groupManager = level.artemis.getManager(new Artemis.GroupManager().runtimeType);

    Artemis.ComponentMapper<Sprite> spriteMapper = new Artemis.ComponentMapper<Sprite>(Sprite, level.artemis);
    Artemis.ComponentMapper<Scale> scaleMapper = new Artemis.ComponentMapper<Scale>(Scale, level.artemis);
    Artemis.ComponentMapper<Immovable> immovableMapper = new Artemis.ComponentMapper<Immovable>(Immovable, level.artemis);

    //  The platforms group contains the ground and the 2 ledges we can jump on
    Phaser.Group platforms = level.context.registerPlatforms(level.game.add.group());

    //  We will enable physics for any object that is created in this group
    platforms.enableBody = true;

    groupManager.getEntities(GROUP_PLATFORMS).forEach((entity) {

      Sprite sprite = spriteMapper.get(entity);
      Scale scale = scaleMapper.get(entity);
      Immovable immovable = immovableMapper.get(entity);

      Phaser.Sprite s = platforms.create(sprite.x, sprite.y, sprite.key);
      s.scale.set(scale.x, scale.y);
      s.body.immovable = immovable.value;

    });
  }

  void processSystem() {
  }
}
