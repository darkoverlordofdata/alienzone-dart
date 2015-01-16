/**
 *--------------------------------------------------------------------+
 * game-ui.dart
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

import 'dart:html';
import 'package:polymer/polymer.dart';
import "package:alienzone/alienzone.dart" show AlienZoneApplication;

@CustomTag('game-ui')
class GameUi extends PolymerElement {

  @observable String copyright = '';
  @observable String title = '';
  @observable String build = '';

  AlienZoneApplication game;

  /**
   * Create the game canvas
   */
  GameUi.created() : super.created() {
    game = new AlienZoneApplication(this);
  }


  /**
   * Hide the splash banner
   */
  void hideBanner() {
    $['banner'].hide();
  }

  /**
   * Pop up the leaderboard dialog
   */
  void showLeaderboard([Event e, var detail, Node target]) {
    $['leaderboard'].show(game);
  }

  /**
   * Pop up the achievements dialog
   */
  void showAchievements([Event e, var detail, Node target]) {
    $['achievements'].show(game);
  }

  /**
   * User info / logon / logoff
   */
  void showUser(Event e, var detail, Node target) {

  }
}
