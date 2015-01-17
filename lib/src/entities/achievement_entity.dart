/**
 *--------------------------------------------------------------------+
 * achievement_entity.dart
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

const String GROUP_ACHIEVEMENTS      = "ACHIEVEMENTS";

class AchievementEntity extends AbstractEntity {

  AchievementEntity(entities, int x, int y, int index, String font, String fill)
  : super(entities) {

    bool lock;

    try {
      lock = (window.localStorage[level.config.extra['achievements'][index]['id']] == 'true');
    } catch(e) {
      lock = false;
    }

    Artemis.Entity achievement = level.artemis.createEntity();
    achievement
    ..addComponent(new Position(x, y))
    ..addComponent(new Text(level.config.extra['achievements'][index]['title'], font, fill))
    ..addComponent(new Lock(lock))
    ..addToWorld();
    groupManager.add(achievement, GROUP_ACHIEVEMENTS);
  }

}