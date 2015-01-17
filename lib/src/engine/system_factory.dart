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

  AchievementRenderSystem achievementRender() => new AchievementRenderSystem(level, cocoon);
  ButtonRenderSystem buttonRender()           => new ButtonRenderSystem(level, cocoon);
  LeaderRenderSystem leaderRender()           => new LeaderRenderSystem(level, cocoon);
  LegendRenderSystem legendRender()           => new LegendRenderSystem(level, cocoon);
  OptionControlSystem optionControl()         => new OptionControlSystem(level, cocoon);
  PlayGamesSystem playGames()                 => new PlayGamesSystem(level, cocoon);
  PlayerControlSystem playerControl()         => new PlayerControlSystem(level, cocoon);
  ScoreRenderSystem scoreRender()             => new ScoreRenderSystem(level, cocoon);
  SpriteRenderSystem spriteRender()           => new SpriteRenderSystem(level, cocoon);
  StringRenderSystem stringRender()           => new StringRenderSystem(level, cocoon);
  TimerControlSystem timerControl()           => new TimerControlSystem(level, cocoon);

  /**
   * Mirrors aren't stable in compiled js,
   * so we do this the old-fashioned way.
   */
  Artemis.EntitySystem invoke(String methodName) {
    switch(methodName) {
      case 'achievementRender': return achievementRender();
      case 'buttonRender':      return buttonRender();
      case 'leaderRender':      return leaderRender();
      case 'legendRender':      return legendRender();
      case 'optionControl':     return optionControl();
      case 'playGames':         return playGames();
      case 'playerControl':     return playerControl();
      case 'scoreRender':       return scoreRender();
      case 'spriteRender':      return spriteRender();
      case 'stringRender':      return stringRender();
      case 'timerControl':      return timerControl();
      default:                  return null;
    }
  }
}