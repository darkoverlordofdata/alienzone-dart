/**
 *--------------------------------------------------------------------+
 * gravity.dart
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

class Gravity extends Artemis.ComponentPoolable {
  num x, y;

  Gravity._();
  factory Gravity([num x = 0, num y = 0]) {
    Gravity gravity = new Artemis.Poolable.of(Gravity, _constructor);
    gravity.x = x;
    gravity.y = y;
    return gravity;
  }
  static Gravity _constructor() => new Gravity._();
}



