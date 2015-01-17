/**
 *--------------------------------------------------------------------+
 * lock.dart
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

class Lock extends Artemis.ComponentPoolable {
  bool value;

  Lock._();
  factory Lock([value = true]) {
    Lock lock = new Artemis.Poolable.of(Lock, _constructor);
    lock.value = value;
    return lock;
  }
  static Lock _constructor() => new Lock._();
}

