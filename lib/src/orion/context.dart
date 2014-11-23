part of alienzone;
/**
 * Expose Phaser objects to Artemis
 */

class Context {

  int _score = 0;
  BaseLevel level;
  Phaser.Game game;
  Phaser.Sprite player = null;
  Phaser.Group platforms = null;
  Phaser.Group gems = null;
  ScoreRenderSystem scoreListener = null;
  int legend = 0;

  Context(this.level);

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
   * register the gems group
   */
  Phaser.Group registerGems(Phaser.Group gems) {
    this.gems = gems;
    return gems;
  }



}

