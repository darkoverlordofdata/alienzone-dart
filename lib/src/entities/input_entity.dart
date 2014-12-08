/**
 *--------------------------------------------------------------------+
 * input_entity.dart
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

const String GROUP_INPUTS      = "INPUTS";

class InputEntity extends AbstractEntity {

  InputEntity(entities, int x, int y, String key, String action)
  : super(entities) {

    Artemis.Entity input = level.artemis.createEntity();
    input
    ..addComponent(new Sprite(x, y, key))
    ..addComponent(new Action(action))
    ..addToWorld();
    groupManager.add(input, GROUP_INPUTS);
  }

}