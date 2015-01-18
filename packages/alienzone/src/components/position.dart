/**
 *--------------------------------------------------------------------+
 * position.dart
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

class Position extends Artemis.ComponentPoolable {
  num x, y;

  Position._();
  factory Position([num x = 0, num y = 0]) {
    Position position = new Artemis.Poolable.of(Position, _constructor);
    position.x = x;
    position.y = y;
    return position;
  }
  static Position _constructor() => new Position._();
}

