/**
 +--------------------------------------------------------------------+
 | alienzone.dart
 +--------------------------------------------------------------------+
 | Copyright DarkOverlordOfData (c) 2014
 +--------------------------------------------------------------------+
 |
 | This file is a part of alienzone
 |
 | alienzone is free software; you can copy, modify, and distribute
 | it under the terms of the MIT License
 |
 +--------------------------------------------------------------------+

  Alien Zone
 
    Match 3 Style Game
*/
part of alienzone;

class Alienzone  extends BaseGame {

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

  cordova.Device device;

  /**
   * == New Game ==
   *   * Set the screen dimensions
   *   * Configure the game states
   *   * Start the game
   *
   * returns this
   */
  Alienzone(config, cordova.Device device): super(config) {

    this.device = device;
    print("Class Alienzone initialized");
  }

  create() {

    super.create();
    game.state
      ..add(config.menu,  new Menu(config))
      ..add('Levels',     new Levels(config))
      ..add('Credits',    new Credits(config))
      ..add('Scores',     new Scores(config))
      ..add('GameOver',   new GameOver(config))
      ..start(config.boot);

  }
}
