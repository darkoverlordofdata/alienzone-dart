/**
 *--------------------------------------------------------------------+
 * bonus.dart
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

class Bonus extends Artemis.ComponentPoolable {
  String src;

  Bonus._();
  factory Bonus(String src) {
    Bonus bonus = new Artemis.Poolable.of(Bonus, _constructor);
    bonus.src = src;
    return bonus;
  }
  static Bonus _constructor() => new Bonus._();
}

