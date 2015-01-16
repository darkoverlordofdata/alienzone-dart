/**
 *--------------------------------------------------------------------+
 * game-leaderboard.dart
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
import 'package:paper_elements/paper_action_dialog.dart';
import "package:alienzone/alienzone.dart" show AlienZoneApplication;

@CustomTag('game-leaderboard')
class GameLeaderboard extends PolymerElement {

  AlienZoneApplication game;
  /**
   * Create the game canvas
   */
  GameLeaderboard.created() : super.created() {
  }
  /**
   * Pop up the leaderboard dialog
   */
  void show(AlienZoneApplication game) {
    this.game = game;
    game.pause();
    ($['leaderboard'] as PaperActionDialog).open();
  }

  void resume() {
    game.resume();
  }

}
