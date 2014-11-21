part of alienzone;

class SystemFactory {

  BaseLevel level;

  SystemFactory(this.level);

  ArcadePhysicsSystem arcadePhysics()       => new ArcadePhysicsSystem(level);
  BackgroundRenderSystem backgroundRender() => new BackgroundRenderSystem(level);
  ButtonRenderSystem buttonRender()         => new ButtonRenderSystem(level);
  ImageRenderSystem imageRender()           => new ImageRenderSystem(level);
  PlatformRenderSystem platformRender()     => new PlatformRenderSystem(level);
  PlayerControlSystem playerControl()       => new PlayerControlSystem(level);
  ScoreRenderSystem scoreRender()           => new ScoreRenderSystem(level);
  StringRenderSystem stringRender()         => new StringRenderSystem(level);

  Artemis.EntitySystem invoke(String methodName) {
    switch(methodName) {
      case 'arcadePhysics':     return arcadePhysics();
      case 'backgroundRender':  return backgroundRender();
      case 'buttonRender':      return buttonRender();
      case 'imageRender':       return imageRender();
      case 'platformRender':    return platformRender();
      case 'playerControl':     return playerControl();
      case 'scoreRender':       return scoreRender();
      case 'stringRender':      return stringRender();
      default:
        throw new Exception("Invalid system factory method: $methodName");
    }
    return null;
  }
}