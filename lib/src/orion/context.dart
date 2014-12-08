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

  BaseLevel level;
  Phaser.Signal scored = null;
  Phaser.Signal pegged = null;

  /**
   * Initialize persisted options
   */
  Context(this.level) {
    _score = level._score;
    scored = new Phaser.Signal();
    pegged = new Phaser.Signal();
    _sfx = (window.localStorage["${PFX}_sfx"] == "true");
    _music = (window.localStorage["${PFX}_music"] == "true");
    level.game.sound.volume = this.volume;

  }

  /**
   * Game Score
   */
  int get score => _score;
  /**
   * SoundFX?
   */
  bool get sfx => _sfx;
  /**
   * Music?
   */
  bool get music => _music;
  /**
   * Volume level
   */
  double get volume => (_sfx) ? VOLUME_ON: VOLUME_OFF;

  /**
   * Update the score, fire signal
   */
  void updateScore(int points) {
    _score += points;
    scored.dispatch(points);
  }

  /**
   * Legend Level
   */
  int get legend => _legend;

  set legend(int value) {
    _legend = value;
    pegged.dispatch(_legend);

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

