/**
 *--------------------------------------------------------------------+
 * leader_render_system.dart
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


class LeaderRenderSystem extends Artemis.VoidEntitySystem {

  BaseLevel level;
  CocoonServices cocoon;


  LeaderRenderSystem(this.level, this.cocoon);

  void initialize() {
    if (DEBUG) print("LeaderRenderSystem::initialize");

    Artemis.GroupManager groupManager = level.artemis.getManager(new Artemis.GroupManager().runtimeType);
    Artemis.ComponentMapper<Position> positionMapper = new Artemis.ComponentMapper<Position>(Position, level.artemis);
    Artemis.ComponentMapper<Count> countMapper = new Artemis.ComponentMapper<Count>(Count, level.artemis);
    Artemis.ComponentMapper<Text> textMapper = new Artemis.ComponentMapper<Text>(Text, level.artemis);

    groupManager.getEntities(GROUP_LEADERS).forEach((entity) {
      Position position = positionMapper.get(entity);
      Count score = countMapper.get(entity);
      Text text = textMapper.get(entity);
      var style = new Phaser.TextStyle(font: text.font, fill: text.fill);
      level.game.add.text(position.x, position.y, text.value, style);
      level.game.add.text(position.x+150, position.y, "${score.value}", style);

    });

  }


  void processSystem() {

  }
}
