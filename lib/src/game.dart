/**
 *--------------------------------------------------------------------+
 * Game.dart
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

class Game  extends Dilithium {

  static const VOLUME_ON  = 0.05;
  static const VOLUME_OFF = 0;
  static const GEMSIZE    = 48;     // Gem size constant in pixels
  static const MARGINTOP  = 2;      // Margin top equal to 2 gems height
  static final List GEMTYPES = [    // All gem types:
      "blue",
      "cyan",
      "green",
      "magenta",
      "orange",
      "pink",
      "red",
      "yellow"
  ];

  AlienZoneApplication app;
  Li2Template template;

  num soundfx = VOLUME_ON;
  bool fullscreen = true;
  bool playmusic = true;


  /**
   * == New Game ==
   *   * Set the screen dimensions
   *   * Configure the game states
   *   * Start the game
   *
   * returns this
   */
  Game(Li2Config config, this.template): super(config) {

    print("Class Game initialized");
    game.scale.fullScreenScaleMode = Phaser.ScaleManager.EXACT_FIT;
  }

  /**
   * Define each of the game states
   */
  Phaser.State levels() {

    game.state.add('game', new BaseLevel('game', config));
    game.state.add('credits', new BaseLevel('credits', config));
    game.state.add('gameover', new BaseLevel('gameover', config));
    game.state.add('preferences', new BaseLevel('preferences', config));

    querySelector('.logo').hidden = true;
    return new BaseLevel('main', config);

  }


  /**
   * Set game preferences
   */
  setPreference(id, value) {

    switch(id) {
      case 'fullscreen':
        fullscreen = value;
        break;

      case 'soundfx':
        soundfx = value ? VOLUME_ON : VOLUME_OFF;
        break;

      case 'playmusic':
        playmusic = value;
        break;
    }
  }

}
