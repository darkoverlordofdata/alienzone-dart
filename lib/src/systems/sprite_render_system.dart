part of alienzone;

const String GROUP_SPRITES = "SPRITES";

class SpriteRenderSystem extends Artemis.VoidEntitySystem {

  BaseLevel level;

  SpriteRenderSystem(this.level);


  void initialize() {
    if (DEBUG) print("SpriteRenderSystem::initialize");
    Artemis.GroupManager groupManager = level.artemis.getManager(new Artemis.GroupManager().runtimeType);
    Artemis.ComponentMapper<Sprite> spriteMapper = new Artemis.ComponentMapper<Sprite>(Sprite, level.artemis);
    Artemis.ComponentMapper<Opacity> opacityMapper = new Artemis.ComponentMapper<Opacity>(Opacity, level.artemis);

    groupManager.getEntities(GROUP_SPRITES).forEach((entity) {
      Sprite sprite = spriteMapper.get(entity);
      Opacity opacity = opacityMapper.get(entity);
      var s = level.game.add.sprite(sprite.x, sprite.y, sprite.key, sprite.frame);
      s.alpha = opacity.alpha;
    });
  }

  void processSystem() {
  }
}
