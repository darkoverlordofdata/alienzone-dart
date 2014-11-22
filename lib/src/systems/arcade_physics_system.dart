part of alienzone;

class ArcadePhysicsSystem extends Artemis.VoidEntitySystem {

  BaseLevel level;
  Arcade.Arcade arcade;

  ArcadePhysicsSystem(this.level) {
    if (DEBUG) print("ArcadePhysicsSystem: started");
    level.game.physics.startSystem(Phaser.Physics.ARCADE);
    arcade = level.game.physics.arcade;

  }

  /**
   * Do the collision checks
   */
  void processSystem() {

    //  Collide the player and the gems with the platforms
    arcade.collide(level.context.player, level.context.platforms);
    arcade.collide(level.context.gems, level.context.platforms);

    //  Checks to see if the player overlaps with any of the gems, if he does call the collectStar function
    arcade.overlap(level.context.player, level.context.gems, collectStar, null);

  }

  /**
   * Collect Star's to Win!
   */
  collectStar(playerSprite, star) {
    // Removes the star from the screen
    star.kill();
    //  Add and update the score
    level.context.score += 10;

  }

}

