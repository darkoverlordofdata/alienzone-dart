/**
 *--------------------------------------------------------------------+
 * string_render_system.dart
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

class StringRenderSystem extends Artemis.VoidEntitySystem {

  BaseLevel level;
  CocoonServices cocoon;

  StringRenderSystem(this.level, this.cocoon);

  /**
   * Render Strings using font and text fill color
   */
  void initialize() {
    if (DEBUG) print("StringRenderSystem::initialize");
    Artemis.GroupManager groupManager = level.artemis.getManager(new Artemis.GroupManager().runtimeType);
    Artemis.ComponentMapper<Position> positionMapper = new Artemis.ComponentMapper<Position>(Position, level.artemis);
    Artemis.ComponentMapper<Text> textMapper = new Artemis.ComponentMapper<Text>(Text, level.artemis);

    groupManager.getEntities(GROUP_STRINGS).forEach((entity) {
      Position position = positionMapper.get(entity);
      Text text = textMapper.get(entity);
      var style = new Phaser.TextStyle(font: text.font, fill: text.fill);
      level.game.add.text(position.x, position.y, text.value, style);

    });
  }

  void processSystem() {
  }
}
