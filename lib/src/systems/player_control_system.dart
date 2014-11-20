part of alienzone;

class PlayerControlSystem extends Artemis.IntervalEntitySystem {

  BaseLevel level;
  Phaser.Sprite playerSprite;
  var cursors;

  PlayerControlSystem(this.level)
    : super(20, Artemis.Aspect.getAspectForAllOf([Velocity, Bounce, Gravity, Animation, Sprite]));

  void initialize() {
    print("PlayerControlSystem::initialize");
    //  Our controls.
    cursors = level.game.input.keyboard.createCursorKeys();
    var velocityMapper = new Artemis.ComponentMapper<Velocity>(Velocity, level.artemis);
    var bounceMapper = new Artemis.ComponentMapper<Bounce>(Bounce, level.artemis);
    var gravityMapper = new Artemis.ComponentMapper<Gravity>(Gravity, level.artemis);
    var animationMapper = new Artemis.ComponentMapper<Animation>(Animation, level.artemis);
    var spriteMapper = new Artemis.ComponentMapper<Sprite>(Sprite, level.artemis);

    Artemis.TagManager tagManager = level.artemis.getManager(Artemis.TagManager);
    Artemis.Entity player = tagManager.getEntity(TAG_PLAYER);
    Velocity velocity = velocityMapper.get(player);
    Bounce bounce = bounceMapper.get(player);
    Gravity gravity = gravityMapper.get(player);
    Animation animation = animationMapper.get(player);
    Sprite sprite = spriteMapper.get(player);

    playerSprite = level.game.add.sprite(sprite.x, sprite.y, sprite.key);
    level.context.registerPlayer(playerSprite);

    //  We need to enable physics on the player
    level.game.physics.arcade.enable(playerSprite);

    playerSprite
    ..body.bounce.y = bounce.y
    ..body.gravity.y = gravity.y
    ..body.collideWorldBounds = true;

    animation.cells.forEach((name, v) {
      playerSprite.animations.add(name, v['frames'], v['frameRate'], v['loop'], v['useNumericIndex']);
    });
  }

  /**
   * This is where all of the player activities occur
   */
  void processEntities(Iterable<Artemis.Entity> entities) {

    playerSprite.body.velocity.x = 0;

    if (cursors.left.isDown){
      //  Move to the left
      playerSprite.body.velocity.x = -150;

      playerSprite.animations.play('left');
    } else if (cursors.right.isDown) {
      //  Move to the right
      playerSprite.body.velocity.x = 150;

      playerSprite.animations.play('right');
    } else {
      //  Stand still
      playerSprite.animations.stop();

      playerSprite.frame = 4;
    }

    //  Allow the player to jump if they are touching the ground.
    if (cursors.up.isDown && playerSprite.body.touching.down) {
//    if (cursors.up.isDown) {
      print(playerSprite.body.touching.down);
      playerSprite.body.velocity.y = -350;
    }

  }

}
