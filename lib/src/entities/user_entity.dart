/**
 *--------------------------------------------------------------------+
 * user_entity.dart
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

const String GROUP_USERS      = "USERS";

class UserEntity extends AbstractEntity {

  UserEntity(entities, int x, int y, int w, int h)
  : super(entities) {

    Artemis.Entity user = level.artemis.createEntity();
    user
    ..addComponent(new Position(x, y))
    ..addComponent(new Scale(w, h))
    ..addComponent(new User('gamesController', 'gamesAchievements', 'gamesLeaderboards'))
    ..addToWorld();
    groupManager.add(user, GROUP_USERS);
  }

}