part of alienzone;


class BackgroundRenderSystem extends Artemis.VoidEntitySystem {

  BaseLevel level;

  BackgroundRenderSystem(this.level);


  void initialize() {
    print("BackgroundRenderSystem::initialize");
    Artemis.GroupManager groupManager = level.artemis.getManager(new Artemis.GroupManager().runtimeType);
    Artemis.ComponentMapper<Sprite> spriteMapper = new Artemis.ComponentMapper<Sprite>(Sprite, level.artemis);

    groupManager.getEntities(GROUP_BACKGROUND).forEach((entity) {
      Sprite sprite = spriteMapper.get(entity);
      level.game.add.sprite(sprite.x, sprite.y, sprite.key);
    });
  }

  void processSystem() {
  }
}
