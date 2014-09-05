/*+--------------------------------------------------------------------+
#| alienzed.coffee
#+--------------------------------------------------------------------+
#| Copyright DarkOverlordOfData (c) 2014
#+--------------------------------------------------------------------+
#|
#| This file is a part of alienzed
#|
#| alienzed is free software; you can copy, modify, and distribute
#| it under the terms of the MIT License
#|
#+--------------------------------------------------------------------+
#
# Alien Zed
#
#   Match 3 Style Game
*/
part of alienzed;

class Alienzed extends Game {

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
  Alienzed(cordova.Device this.device): super(320, 480, CANVAS) {

    print("Class Alienzed initialized");
    state
      ..add('Start',      new Start())
      ..add('Assets',     new Assets())
      ..add('Intro',      new Intro())
      ..add('Levels',     new Levels())
      ..add('GameOver',   new GameOver())
      ..start('Start');
  }
}
