/**
 *--------------------------------------------------------------------+
 * time.dart
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

class Time extends Artemis.ComponentPoolable {
  int minutes, seconds, ms;

  Time._();
  factory Time([int minutes = 0, int seconds = 0, int ms = 0]) {
    Time time = new Artemis.Poolable.of(Time, _constructor);
    time.minutes = minutes;
    time.seconds = seconds;
    time.ms = ms;
    return time;
  }
  static Time _constructor() => new Time._();
}

