/*+--------------------------------------------------------------------+
#| alienzone.dart
#+--------------------------------------------------------------------+
#| Copyright DarkOverlordOfData (c) 2014
#+--------------------------------------------------------------------+
#|
#| This file is a part of alienzone
#|
#| alienzone is free software; you can copy, modify, and distribute
#| it under the terms of the MIT License
#|
#+--------------------------------------------------------------------+
#
# Alien Zone
#
#   Match 3 Style Game
*/
part of alienzone;

class Alienzone  extends Game {

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


  /**
   * == New Game ==
   *   * Set the screen dimensions
   *   * Configure the game states
   *   * Start the game
   *
   * returns this
   */
  Alienzone(String config, cordova.Device device): super(320, 480, CANVAS) {

    print("Class Alienzone initialized");

    state
      ..add('Boot',       new Boot())     //  Template
      ..add('Assets',     new Assets())   //  Template
      ..add('Menu',       new Menu())
      ..add('Levels',     new Levels())
      ..add('Credits',    new Credits())
      ..add('Scores',     new Scores())
      ..add('GameOver',   new GameOver())
      ..start('Boot', true, false, {'config': new Config(config, device)});

  }
}
