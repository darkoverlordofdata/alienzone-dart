/**
 *--------------------------------------------------------------------+
 * achievement_render_system.dart
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


class AchievementRenderSystem extends Artemis.VoidEntitySystem {

  BaseLevel level;
  CocoonServices cocoon;


  AchievementRenderSystem(this.level, this.cocoon);

  /**
   * Render Achievements
   */
  void initialize() {
    if (DEBUG) print("AchievementRenderSystem::initialize");

    Artemis.GroupManager groupManager = level.artemis.getManager(new Artemis.GroupManager().runtimeType);
    Artemis.ComponentMapper<Position> positionMapper = new Artemis.ComponentMapper<Position>(Position, level.artemis);
    Artemis.ComponentMapper<Lock> lockMapper = new Artemis.ComponentMapper<Lock>(Lock, level.artemis);
    Artemis.ComponentMapper<Text> textMapper = new Artemis.ComponentMapper<Text>(Text, level.artemis);

    groupManager.getEntities(GROUP_ACHIEVEMENTS).forEach((entity) {
      Position position = positionMapper.get(entity);
      Lock lock = lockMapper.get(entity);
      Text text = textMapper.get(entity);
      var style = new Phaser.TextStyle(font: text.font, fill: text.fill);
      level.game.add.text(position.x, position.y, text.value, style);
      //achievement
      if (lock.value) {
        level.game.add.sprite(position.x+200, position.y, 'achievement', 2);
      } else {
        level.game.add.sprite(position.x+200, position.y, 'achievement', 1);
      }

    });

  }


  void processSystem() {

  }
}
