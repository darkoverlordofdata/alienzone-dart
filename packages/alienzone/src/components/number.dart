/**
 *--------------------------------------------------------------------+
 * number.dart
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

class Number extends Artemis.ComponentPoolable {
  int value;

  Number._();
  factory Number([value = true]) {
    Number number = new Artemis.Poolable.of(Number, _constructor);
    number.value = value;
    return number;
  }
  static Number _constructor() => new Number._();
}

