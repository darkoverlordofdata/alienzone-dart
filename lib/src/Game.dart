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
  cordova.Device device;
  Li2Template template;

  /**
   * == New Game ==
   *   * Set the screen dimensions
   *   * Configure the game states
   *   * Start the game
   *
   * returns this
   */
  Game(config, this.template, this.device): super(config) {

    print("Class Game initialized");
  }

  /**
   * Define each of the game states
   */
  State levels() {

    game.state.add('Levels',       new Levels(config));
    game.state.add('Credits',      new Credits(config));
    game.state.add('Scores',       new Scores(config));
    game.state.add('Preferences',  new Preferences(config, template));
    game.state.add('GameOver',     new GameOver(config));

    if (context['cordova'] != null) {
      JsObject _splashscreen = context['navigator']['splashscreen'];
      if (_splashscreen == null) {
        print("Splashscreen plugin not ready yet.");
//        throw new StateError('Splashscreen plugin not ready yet.');
      } else {
        _splashscreen.callMethod('hide', []);

      }

    }

    querySelector('body').style.backgroundColor = 'black';

    return new Menu(config);

  }

}
