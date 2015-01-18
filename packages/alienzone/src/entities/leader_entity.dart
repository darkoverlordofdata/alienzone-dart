/**
 *--------------------------------------------------------------------+
 * leader_entity.dart
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

const String GROUP_LEADERS      = "LEADERS";

class LeaderEntity extends AbstractEntity {

  LeaderEntity(entities, int x, int y, int index, String font, String fill)
  : super(entities) {

    int score;

    try {
      score = int.parse(window.localStorage[level.config.extra['leaderboards'][index]['id']]);
    } catch(e) {
      score = 0;
    }

    Artemis.Entity leader = level.artemis.createEntity();
    leader
    ..addComponent(new Position(x, y))
    ..addComponent(new Text(level.config.extra['leaderboards'][index]['title'], font, fill))
    ..addComponent(new Count(score))
    ..addToWorld();
    groupManager.add(leader, GROUP_LEADERS);
  }

}