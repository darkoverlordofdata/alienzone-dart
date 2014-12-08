/**
 *--------------------------------------------------------------------+
 * opacity.dart
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

class Opacity extends Artemis.ComponentPoolable {
  double alpha;

  Opacity._();
  factory Opacity([alpha = 1.0]) {
    Opacity opacity = new Artemis.Poolable.of(Opacity, _constructor);
    opacity.alpha = alpha;
    return opacity;
  }
  static Opacity _constructor() => new Opacity._();
}

