part of alienzone;

class EntityFactory  {

  BaseLevel level;
  Artemis.GroupManager groupManager;
  Artemis.TagManager tagManager;

  EntityFactory(this.level) {

    tagManager = new Artemis.TagManager();
    level.artemis.addManager(tagManager);

    groupManager = new Artemis.GroupManager();
    level.artemis.addManager(groupManager);

  }

  BackgroundEntity background(int x, int y, String key)
    => new BackgroundEntity(this, x, y, key);

  ButtonEntity button(int x, int y, String key, String state)
    => new ButtonEntity(this, x, y, key, state);

  GemEntity gem(int x, int y, String key)
    => new GemEntity(this, x, y, key);

  ImageEntity image(int x, int y, String key, double opacity)
    => new ImageEntity(this, x, y, key, opacity);

  PlatformEntity platform(int x, int y, String key, [int scale = 1])
    => new PlatformEntity(this, x, y, key, scale);

  PlayerEntity player(int x, int y, String key, Map cells)
    => new PlayerEntity(this, x, y, key, cells);

  ScoreEntity score(int x, int y, String text, String font, String fill)
    => new ScoreEntity(this, x, y, text, font, fill);

  StringEntity string(int x, int y, String name, String font, String fill)
    => new StringEntity(this, x, y, name, font, fill);

  /**
   * Mirrors aren't stable in compiled js,
   * so we do this the old-fashioned way.
   */
  AbstractEntity invoke(String methodName, List p) {
    switch(methodName) {

      case 'background':  return background(p[0], p[1], p[2]);
      case 'button':      return button(p[0], p[1], p[2], p[3]);
      case 'gem':         return gem(p[0], p[1], p[2]);
      case 'image':       return image(p[0], p[1], p[2], p[3]);
      case 'platform':    return platform(p[0], p[1], p[2], p[3]);
      case 'player':      return player(p[0], p[1], p[2], p[3]);
      case 'score':       return score(p[0], p[1], p[2], p[3], p[4]);
      case 'string':      return string(p[0], p[1], p[2], p[3], p[4]);
      default:
        throw new Exception("Invalid system factory method: $methodName");
    }
    return null;
  }

}