/**
 *--------------------------------------------------------------------+
 * immovable.dart
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

class Immovable extends Artemis.ComponentPoolable {
  bool value;

  Immovable._();
  factory Immovable([value = true]) {
    Immovable immovable = new Artemis.Poolable.of(Immovable, _constructor);
    immovable.value = value;
    return immovable;
  }
  static Immovable _constructor() => new Immovable._();
}

