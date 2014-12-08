/**
 *--------------------------------------------------------------------+
 * action.dart
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

class Action extends Artemis.ComponentPoolable {
  String name;

  Action._();
  factory Action(name) {
    Action action = new Artemis.Poolable.of(Action, _constructor);
    action.name = name;
    return action;
  }
  static Action _constructor() => new Action._();
}

