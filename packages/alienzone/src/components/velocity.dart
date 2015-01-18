/**
 *--------------------------------------------------------------------+
 * velocity.dart
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

class Velocity extends Artemis.ComponentPoolable {
  num x, y;

  Velocity._();
  factory Velocity([num x = 0, num y = 0]) {
    Velocity velocity = new Artemis.Poolable.of(Velocity, _constructor);
    velocity.x = x;
    velocity.y = y;
    return velocity;
  }
  static Velocity _constructor() => new Velocity._();
}
