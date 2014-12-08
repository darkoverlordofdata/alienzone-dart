/**
 *--------------------------------------------------------------------+
 * button_render_system.dart
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

//EntityProcessingSystem

class ButtonRenderSystem extends Artemis.VoidEntitySystem {

  BaseLevel level;

  ButtonRenderSystem(this.level);


  void initialize() {
    if (DEBUG) print("ButtonRenderSystem::initialize");
    Artemis.GroupManager groupManager = level.artemis.getManager(new Artemis.GroupManager().runtimeType);
    Artemis.ComponentMapper<Sprite> spriteMapper = new Artemis.ComponentMapper<Sprite>(Sprite, level.artemis);
    Artemis.ComponentMapper<State> stateMapper = new Artemis.ComponentMapper<State>(State, level.artemis);

    groupManager.getEntities(GROUP_BUTTONS).forEach((entity) {
      Sprite sprite = spriteMapper.get(entity);
      State state = stateMapper.get(entity);
      level.game.add.button(sprite.x, sprite.y, sprite.key,
        (source, input, flag) => level.state.start(state.name, true, false, [state.name, 0]));
    });
  }

  void processSystem() {
    if (DEBUG) print("ButtonRenderSystem::processSystem");
  }
}
