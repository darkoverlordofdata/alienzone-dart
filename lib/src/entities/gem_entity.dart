/**
 *--------------------------------------------------------------------+
 * gem_entity.dart
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

const String GROUP_GEMS      = "GEMS";

class GemEntity extends AbstractEntity {

  GemEntity(entities, int x, int y, String key, int frame)
  : super(entities) {

    Artemis.Entity gem = level.artemis.createEntity();
    gem
    ..addComponent(new Sprite(x, y, key, frame))
    ..addComponent(new Number(frame))
    ..addComponent(new Gravity(0, 300))
    ..addComponent(new Bounce(0, 0.7 + level.random.nextDouble() * 0.2))
    ..addToWorld();
    groupManager.add(gem, GROUP_GEMS);

  }

}