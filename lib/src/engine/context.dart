/**
 *--------------------------------------------------------------------+
 * context.dart
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
/**
 * Manage score and preferences
 */

class Context {

  static const String PFX = "com.darkoverlordofdata.alienzone";

  static const VOLUME_ON  = 0.05;
  static const VOLUME_OFF = 0.00;

  bool _sfx = false;
  bool _music = false;
  int _score = 0;
  int _legend = 0;

  BaseLevel _level;
  Phaser.Signal _scored = null;
  Phaser.Signal _pegged = null;
  Phaser.Signal _action = null;

  /**
   * Initialize persisted options
   */
  Context(this._level) {
    _score = _level._score;
    _scored = new Phaser.Signal();
    _pegged = new Phaser.Signal();
    _action = new Phaser.Signal();
    _sfx = (window.localStorage["${PFX}_sfx"] == "true");
    _music = (window.localStorage["${PFX}_music"] == "true");
    _level.game.sound.volume = this.volume;

  }
  BaseLevel get level => _level;
  Phaser.Signal get scored => _scored;
  Phaser.Signal get pegged => _pegged;
  Phaser.Signal get action => _action;
  int get score => _score;
  bool get sfx => _sfx;
  bool get music => _music;
  double get volume => (_sfx) ? VOLUME_ON: VOLUME_OFF;
  int get legend => _legend;

  set legend(int value) {
    _legend = value;
    _pegged.dispatch(_legend);

  }

  /**
   * Update the score, fire signal
   */
  void updateScore(int points) {
    _score += points;
    _scored.dispatch(points);
  }

  /**
   * Get game preference
   */
  bool getPreference(String id) {
    switch(id) {
      case 'sfx': return _sfx;
      case 'music': return _music;
    }
    return false;
  }

  /**
   * Set game preference
   */
  setPreference(String id, bool value) {

    switch(id) {

      case 'sfx':
        window.localStorage["${PFX}_${id}"] = value.toString();
        _sfx = value;
        break;

      case 'music':
        window.localStorage["${PFX}_${id}"] = value.toString();
        _music = value;
        break;
    }
  }



}

