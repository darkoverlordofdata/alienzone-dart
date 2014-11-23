part of alienzone;

class SystemFactory {

  BaseLevel level;

  SystemFactory(this.level);

  ArcadePhysicsSystem arcadePhysics()       => new ArcadePhysicsSystem(level);
  ButtonRenderSystem buttonRender()         => new ButtonRenderSystem(level);
  PlayerControlSystem playerControl()       => new PlayerControlSystem(level);
  ScoreRenderSystem scoreRender()           => new ScoreRenderSystem(level);
  SpriteRenderSystem spriteRender()         => new SpriteRenderSystem(level);
  StringRenderSystem stringRender()         => new StringRenderSystem(level);

  /**
   * Mirrors aren't stable in compiled js,
   * so we do this the old-fashioned way.
   */
  Artemis.EntitySystem invoke(String methodName) {
    switch(methodName) {
      case 'arcadePhysics':     return arcadePhysics();
      case 'buttonRender':      return buttonRender();
      case 'playerControl':     return playerControl();
      case 'scoreRender':       return scoreRender();
      case 'spriteRender':      return spriteRender();
      case 'stringRender':      return stringRender();
      default:                  return null;
    }
  }
}