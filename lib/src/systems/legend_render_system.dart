part of alienzone;

class LegendRenderSystem extends Artemis.VoidEntitySystem {

  BaseLevel level;

  LegendRenderSystem(this.level);
  List<Phaser.Sprite> sprites;


  void initialize() {
    if (DEBUG) print("LegendRenderSystem::initialize");
    Artemis.GroupManager groupManager = level.artemis.getManager(new Artemis.GroupManager().runtimeType);
    Artemis.ComponentMapper<Sprite> spriteMapper = new Artemis.ComponentMapper<Sprite>(Sprite, level.artemis);
    Artemis.ComponentMapper<Opacity> opacityMapper = new Artemis.ComponentMapper<Opacity>(Opacity, level.artemis);

    sprites = [];
    groupManager.getEntities(GROUP_LEGEND).forEach((entity) {
      Sprite sprite = spriteMapper.get(entity);
      Opacity opacity = opacityMapper.get(entity);
      var s = level.game.add.sprite(sprite.x, sprite.y, sprite.key, sprite.frame);
      s.alpha = opacity.alpha;
      sprites.add(s);
    });

    level.context.pegged.add((int legend) {
      sprites[legend].alpha = 1.0;
    });
  }

  void processSystem() {
  }
}
