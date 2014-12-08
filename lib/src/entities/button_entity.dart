/**
 *--------------------------------------------------------------------+
 * button_entity.dart
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

const String GROUP_BUTTONS      = "BUTTONS";

class ButtonEntity extends AbstractEntity {

  ButtonEntity(entities, int x, int y, String key, String state)
  : super(entities) {

    Artemis.Entity button = level.artemis.createEntity();
    button
    ..addComponent(new Sprite(x, y, key))
    ..addComponent(new State(state))
    ..addToWorld();
    groupManager.add(button, GROUP_BUTTONS);
  }

}