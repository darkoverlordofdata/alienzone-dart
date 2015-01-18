/**
 *--------------------------------------------------------------------+
 * player_entity.dart
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

const String TAG_PLAYER = "PLAYER";

class PlayerEntity extends AbstractEntity {

  PlayerEntity(entities, int x, int y, String key, Map cells)
  : super(entities) {

    Artemis.Entity player = level.artemis.createEntity();
    player
    ..addComponent(new Sprite(x, y, key))
    ..addComponent(new Velocity(0, 0))
    ..addComponent(new Gravity(0, 300))
    ..addComponent(new Bounce(0, .2))
    ..addComponent(new Animation(cells))
    ..addToWorld();
    tagManager.register(player, TAG_PLAYER);

  }

}