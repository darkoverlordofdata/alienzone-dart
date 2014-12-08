/**
 *--------------------------------------------------------------------+
 * sprite.dart
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

class Sprite extends Artemis.ComponentPoolable {

  num x;
  num y;
  String key;
  var frame;

  Sprite._();
  factory Sprite(num x, num y, String key, [frame]) {
    Sprite sprite = new Artemis.Poolable.of(Sprite, _constructor);
    sprite.x = x;
    sprite.y = y;
    sprite.key = key;
    sprite.frame = frame;
    return sprite;
  }
  static Sprite _constructor() => new Sprite._();
}


