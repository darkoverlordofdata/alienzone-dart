part of alienzone;


class GemsRenderSystem extends Artemis.VoidEntitySystem {

  BaseLevel level;

  GemsRenderSystem(this.level);


  void initialize() {
    print("StarsRenderSystem::initialize");
    Artemis.GroupManager groupManager = level.artemis.getManager(new Artemis.GroupManager().runtimeType);

    Artemis.ComponentMapper<Sprite> spriteMapper = new Artemis.ComponentMapper<Sprite>(Sprite, level.artemis);
    Artemis.ComponentMapper<Bounce> bounceMapper = new Artemis.ComponentMapper<Bounce>(Bounce, level.artemis);
    Artemis.ComponentMapper<Gravity> gravityMapper = new Artemis.ComponentMapper<Gravity>(Gravity, level.artemis);

    //  The platforms group contains the ground and the 2 ledges we can jump on
    Phaser.Group gems = level.context.registerGems(level.game.add.group());

    //  We will enable physics for any object that is created in this group
    gems.enableBody = true;

    groupManager.getEntities(GROUP_GEMS).forEach((entity) {

      Sprite sprite = spriteMapper.get(entity);
      Bounce bounce = bounceMapper.get(entity);
      Gravity gravity = gravityMapper.get(entity);

      Phaser.Sprite s = gems.create(sprite.x, sprite.y, sprite.key);
      s.body.bounce.y = bounce.y;
      s.body.gravity.y = gravity.y;

    });
  }

  void processSystem() {
  }
}
