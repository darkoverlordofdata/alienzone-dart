/**
 *--------------------------------------------------------------------+
 * count.dart
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

class Count extends Artemis.ComponentPoolable {
  int value;

  Count._();
  factory Count([value = true]) {
    Count count = new Artemis.Poolable.of(Count, _constructor);
    count.value = value;
    return count;
  }
  static Count _constructor() => new Count._();
}

