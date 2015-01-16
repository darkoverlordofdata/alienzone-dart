/**
 *--------------------------------------------------------------------+
 * user.dart
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

class User extends Artemis.ComponentPoolable {
  bool state;
  String name;
  String controller;
  String achievements;
  String leaderboards;


  User._();
  factory User(String controller, String achievements, String leaderboards) {
    User user = new Artemis.Poolable.of(User, _constructor);
    user.state = false;
    user.name = '';
    user.controller = controller;
    user.achievements = achievements;
    user.leaderboards = leaderboards;
    return user;
  }
  static User _constructor() => new User._();
}

