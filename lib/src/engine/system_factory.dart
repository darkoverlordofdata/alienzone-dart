/**
 *--------------------------------------------------------------------+
 * system_factory.dart
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

class SystemFactory {

  BaseLevel level;
  CocoonServices cocoon;

  SystemFactory(this.level, this.cocoon);

//  ArcadePhysicsSystem arcadePhysics()       => new ArcadePhysicsSystem(level);
  ButtonRenderSystem buttonRender()         => new ButtonRenderSystem(level, cocoon);
  LegendRenderSystem legendRender()         => new LegendRenderSystem(level, cocoon);
  OptionControlSystem optionControl()       => new OptionControlSystem(level, cocoon);
  PlayerControlSystem playerControl()       => new PlayerControlSystem(level, cocoon);
  ScoreRenderSystem scoreRender()           => new ScoreRenderSystem(level, cocoon);
  SpriteRenderSystem spriteRender()         => new SpriteRenderSystem(level, cocoon);
  StringRenderSystem stringRender()         => new StringRenderSystem(level, cocoon);

  /**
   * Mirrors aren't stable in compiled js,
   * so we do this the old-fashioned way.
   */
  Artemis.EntitySystem invoke(String methodName) {
    switch(methodName) {
//      case 'arcadePhysics':     return arcadePhysics(); // *UNUSED*
      case 'buttonRender':      return buttonRender();
      case 'legendRender':      return legendRender();
      case 'optionControl':     return optionControl();
      case 'playerControl':     return playerControl();
      case 'scoreRender':       return scoreRender();
      case 'spriteRender':      return spriteRender();
      case 'stringRender':      return stringRender();
      default:                  return null;
    }
  }
}