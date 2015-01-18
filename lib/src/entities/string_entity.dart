/**
 *--------------------------------------------------------------------+
 * string_entity.dart
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

const String GROUP_STRINGS        = "STRINGS";

class StringEntity extends AbstractEntity {

  StringEntity(entities, int x, int y, String name, String font, String fill, [String align='left'])
  : super(entities) {

    Artemis.Entity string = level.artemis.createEntity();
    string
    ..addComponent(new Position(x, y))
    ..addComponent(new Text(level.config.strings[name], font, fill, align))
    ..addComponent(new Immovable(true))
    ..addToWorld();
    groupManager.add(string, GROUP_STRINGS);
  }

}