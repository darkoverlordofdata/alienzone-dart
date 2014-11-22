part of alienzone;

class InputRenderSystem extends Artemis.VoidEntitySystem {

  BaseLevel level;

  InputRenderSystem(this.level);


  void initialize() {
    if (DEBUG) print("InputRenderSystem::initialize");
    Artemis.GroupManager groupManager = level.artemis.getManager(new Artemis.GroupManager().runtimeType);
    Artemis.ComponentMapper<Sprite> spriteMapper = new Artemis.ComponentMapper<Sprite>(Sprite, level.artemis);
    Artemis.ComponentMapper<Action> stateMapper = new Artemis.ComponentMapper<Action>(Action, level.artemis);

    groupManager.getEntities(GROUP_INPUTS).forEach((entity) {
      Sprite sprite = spriteMapper.get(entity);
      Action action = stateMapper.get(entity);
      level.game.add.button(sprite.x, sprite.y, sprite.key,
        (source, input, flag) => action.name);
    });
  }

  void processSystem() {
    if (DEBUG) print("InputRenderSystem::processSystem");
  }
}
