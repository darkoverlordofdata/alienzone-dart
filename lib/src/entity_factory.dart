part of alienzone;

class EntityFactory  {

  Phaser.Game game;
  World world;
  GroupManager groupManager;
  TagManager tagManager;

  EntityFactory(this.game, this.world) {

    tagManager = new TagManager();
    world.addManager(tagManager);

    groupManager = new GroupManager();
    world.addManager(groupManager);

  }

  BackgroundEntity background(int x, int y, String key) {
    return new BackgroundEntity(this, x, y, key);
  }

  GemEntity gem(int x, int y, String key) {
    return new GemEntity(this, x, y, key);
  }

  PlatformEntity platform(int x, int y, String key, [int scale = 1]) {
    return new PlatformEntity(this, x, y, key, scale);
  }

  PlayerEntity player(int x, int y, String key, Map cells) {
    return new PlayerEntity(this, x, y, key, cells);
  }

  ScoreEntity score(int x, int y, String text, String font, String fill) {
    return new ScoreEntity(this, x, y, text, font, fill);
  }

  /**
   * Mirrors aren't stable in compiled js,
   * so we do this the old-fashioned way.
   */
  AbstractEntity invoke(String methodName, List p) {
    switch(methodName) {

      case 'background':  return background(p[0], p[1], p[2]);
      case 'gem':         return gem(p[0], p[1], p[2]);
      case 'platform':    return platform(p[0], p[1], p[2], p[3]);
      case 'player':      return player(p[0], p[1], p[2], p[3]);
      case 'score':       return score(p[0], p[1], p[2], p[3], p[4]);
    }
    return null;
  }

}