part of alienzone;

//EntityProcessingSystem

class ButtonRenderSystem extends Artemis.VoidEntitySystem {

  BaseLevel level;

  ButtonRenderSystem(this.level);


  void initialize() {
    print("ButtonRenderSystem::initialize");
    Artemis.GroupManager groupManager = level.artemis.getManager(new Artemis.GroupManager().runtimeType);
    Artemis.ComponentMapper<Sprite> spriteMapper = new Artemis.ComponentMapper<Sprite>(Sprite, level.artemis);
    Artemis.ComponentMapper<State> stateMapper = new Artemis.ComponentMapper<State>(State, level.artemis);

    groupManager.getEntities(GROUP_BUTTONS).forEach((entity) {
      Sprite sprite = spriteMapper.get(entity);
      State state = stateMapper.get(entity);
      level.game.add.button(sprite.x, sprite.y, sprite.key,
        (source, input, flag) => level.state.start(state.name, true, false, [state.name]));
    });
  }

  void processSystem() {
  }
}
