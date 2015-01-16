/**
 *--------------------------------------------------------------------+
 * option_control_system.dart
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

class OptionControlSystem extends Artemis.VoidEntitySystem {

  BaseLevel level;      //  parent game state
  CocoonServices cocoon;
  Map<String, Phaser.Button> options;

  OptionControlSystem(this.level, this.cocoon);

  /**
   * Initialize option control
   */
  void initialize() {
    if (DEBUG) print("OptionControlSystem::initialize");

    Artemis.GroupManager groupManager = level.artemis.getManager(new Artemis.GroupManager().runtimeType);
    Artemis.ComponentMapper<Sprite> spriteMapper = new Artemis.ComponentMapper<Sprite>(Sprite, level.artemis);
    Artemis.ComponentMapper<Action> actionMapper = new Artemis.ComponentMapper<Action>(Action, level.artemis);

    options = new Map();
    groupManager.getEntities(GROUP_OPTIONS).forEach((entity) {
      Sprite sprite = spriteMapper.get(entity);
      Action action = actionMapper.get(entity);

      options[action.name] = level.add.button(sprite.x, sprite.y, sprite.key,
        (source, input, flag) => toggle(action.name));

      if (level.context.getPreference(action.name)) {
        options[action.name].frame = 1;
        options[action.name].alpha = 1;
      } else {
        options[action.name].frame = 0;
        options[action.name].alpha = 0.5;
      }
    });

  }

  /**
   * Toggle
   *
   * set the button frame
   * persist the setting
   * set context preference
   */
  void toggle(String name) {
    switch (options[name].frame) {

      case 0:
      /**
       * Set ON
       */
        options[name].frame = 1;
        options[name].alpha = 1;
        level.context.setPreference(name, true);
        break;

      case 1:
      /**
       * Set OFF
       */
        options[name].frame = 0;
        options[name].alpha = 0.5;
        level.context.setPreference(name, false);
        break;
    }
  }


  void processSystem() {
  }
}
