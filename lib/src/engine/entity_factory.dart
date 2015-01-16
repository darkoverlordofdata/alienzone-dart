/**
 *--------------------------------------------------------------------+
 * entity_factory.dart
 *--------------------------------------------------------------------+
 * Copyright DarkOverlordOfData (c) 2014
 *--------------------------------------------------------------------+
 *
 * This file is a part of Alien Zone
 *
 * Alien Zone is free software; you can copy, modify, and distribute
 * it under the terms of the GPLv3 License
 *
 *--------------------------------------------------------------------+
 *
 */
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

  ButtonEntity button(int x, int y, String key, String action, [String text = "", String font = "", String fill = ""])
    => new ButtonEntity(this, x, y, key, action, text, font, fill);

  GemEntity gem(int x, int y, String key, int range)
    => new GemEntity(this, x, y, key, range);

  ImageEntity image(int x, int y, String key, [double opacity=1])
    => new ImageEntity(this, x, y, key, opacity);

  InputEntity input(int x, int y, String key, String action)
    => new InputEntity(this, x, y, key, action);

  LegendEntity legend(int x, int y, String key, int frame, double opacity)
    => new LegendEntity(this, x, y, key, frame, opacity);

  OptionEntity option(int x, int y, String key, String action)
    => new OptionEntity(this, x, y, key, action);

  PlayerEntity player(int x, int y, String key, Map cells)
    => new PlayerEntity(this, x, y, key, cells);

  ScoreEntity score(int x, int y, String text, String font, String fill)
    => new ScoreEntity(this, x, y, text, font, fill);

  StringEntity string(int x, int y, String name, String font, String fill)
    => new StringEntity(this, x, y, name, font, fill);

  TimerEntity timer(int x, int y, String action, String font, String fill)
    => new TimerEntity(this, x, y, action, font, fill);

  UserEntity user(int x, int y, int w, int h)
    => new UserEntity(this, x, y, w, h);

  /**
   * Mirrors aren't stable in compiled js,
   * so we do this the old-fashioned way.
   */
  AbstractEntity invoke(String methodName, List args) {
    switch(methodName) {
      case 'button':      return Function.apply(button, args);
      case 'gem':         return Function.apply(gem, args);
      case 'image':       return Function.apply(image, args);
      case 'input':       return Function.apply(input, args);
      case 'legend':      return Function.apply(legend, args);
      case 'option':      return Function.apply(option, args);
      case 'player':      return Function.apply(player, args);
      case 'score':       return Function.apply(score, args);
      case 'string':      return Function.apply(string, args);
      case 'timer':       return Function.apply(timer, args);
      case 'user':        return Function.apply(user, args);
      default:            return null;
    }
  }

}