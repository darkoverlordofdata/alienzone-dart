/**
 *--------------------------------------------------------------------+
 * abstract_entity.dart
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

abstract class AbstractEntity {

  BaseLevel level;
  Artemis.GroupManager groupManager;
  Artemis.TagManager tagManager;

  AbstractEntity(EntityFactory entities) {
    level = entities.level;
    groupManager = entities.groupManager;
    tagManager = entities.tagManager;
  }

}

