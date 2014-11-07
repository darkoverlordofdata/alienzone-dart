part of alienzone;
/**
 * The game
 */

class Context {

  int _score = 0;
  World world;
  EntityFactory add;
  Phaser.Game game;
  Phaser.Sprite player = null;
  Phaser.Group platforms = null;
  Phaser.Group stars = null;
  ScoreRenderSystem scoreListener = null;

  Context(this.game, this.world) {
    add = new EntityFactory(game, world);
  }

  /**
   * Game Score
   */
  int get score => _score;

  set score(int value) {
    _score = value;
    scoreListener.update(_score);

  }

  /**
   * register the score listener
   */
  void registerScoreListener(ScoreRenderSystem scoreListener) {
    this.scoreListener = scoreListener;
  }

  /**
   * register the player sprite
   */
  Phaser.Sprite registerPlayer(Phaser.Sprite player) {
    this.player = player;
    return player;
  }

  /**
   * register the platforms group
   */
  Phaser.Group registerPlatforms(Phaser.Group platforms) {
    this.platforms = platforms;
    return platforms;
  }

  /**
   * register the stars group
   */
  Phaser.Group registerStars(Phaser.Group stars) {
    this.stars = stars;
    return stars;
  }



}

