/**
 *--------------------------------------------------------------------+
 * state.dart
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

class State extends Artemis.ComponentPoolable {
  String name;

  State._();
  factory State(name) {
    State state = new Artemis.Poolable.of(State, _constructor);
    state.name = name;
    return state;
  }
  static State _constructor() => new State._();
}

