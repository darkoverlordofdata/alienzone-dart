part of alienzone;


class GemsRenderSystem extends VoidEntitySystem {

  Phaser.Game game;
  Context orion;

  GemsRenderSystem(this.game, this.orion);


  void initialize() {
    print("StarsRenderSystem::initialize");
    GroupManager groupManager = world.getManager(new GroupManager().runtimeType);

    ComponentMapper<Sprite> spriteMapper = new ComponentMapper<Sprite>(Sprite, world);
    ComponentMapper<Bounce> bounceMapper = new ComponentMapper<Bounce>(Bounce, world);
    ComponentMapper<Gravity> gravityMapper = new ComponentMapper<Gravity>(Gravity, world);

    //  The platforms group contains the ground and the 2 ledges we can jump on
    Phaser.Group gems = orion.registerGems(game.add.group());

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
