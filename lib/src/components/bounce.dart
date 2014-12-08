/**
 *--------------------------------------------------------------------+
 * bounce.dart
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

class Bounce extends Artemis.ComponentPoolable {
  num x, y;

  Bounce._();
  factory Bounce([num x = 0, num y = 0]) {
    Bounce bounce = new Artemis.Poolable.of(Bounce, _constructor);
    bounce.x = x;
    bounce.y = y;
    return bounce;
  }
  static Bounce _constructor() => new Bounce._();
}

