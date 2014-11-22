part of alienzone;

class SystemFactory {

  BaseLevel level;

  SystemFactory(this.level);

  ArcadePhysicsSystem arcadePhysics()       => new ArcadePhysicsSystem(level);
  BackgroundRenderSystem backgroundRender() => new BackgroundRenderSystem(level);
  ButtonRenderSystem buttonRender()         => new ButtonRenderSystem(level);
  ImageRenderSystem imageRender()           => new ImageRenderSystem(level);
  InputRenderSystem inputRender()           => new InputRenderSystem(level);
  LegendRenderSystem legendRender()         => new LegendRenderSystem(level);
  PlatformRenderSystem platformRender()     => new PlatformRenderSystem(level);
  PlayerControlSystem playerControl()       => new PlayerControlSystem(level);
  ScoreRenderSystem scoreRender()           => new ScoreRenderSystem(level);
  StringRenderSystem stringRender()         => new StringRenderSystem(level);

  /**
   * Mirrors aren't stable in compiled js,
   * so we do this the old-fashioned way.
   */
  Artemis.EntitySystem invoke(String methodName) {
    switch(methodName) {
      case 'arcadePhysics':     return arcadePhysics();
      case 'backgroundRender':  return backgroundRender();
      case 'buttonRender':      return buttonRender();
      case 'imageRender':       return imageRender();
      case 'inputRender':       return inputRender();
      case 'legendRender':      return legendRender();
      case 'platformRender':    return platformRender();
      case 'playerControl':     return playerControl();
      case 'scoreRender':       return scoreRender();
      case 'stringRender':      return stringRender();
      default:                  return null;
    }
  }
}