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
  static var GEMTYPES   = [         // All gem types:
    "blue",
    "cyan",
    "green",
    "magenta",
    "orange",
    "pink",
    "red",
    "yellow"
  ];

  var id          = '';
  var width       = 320;
  var height      = 480;
  var renderer    = CANVAS;
  Game game;
 
  /**
   * == New Game ==
   *   * Set the screen dimensions
   *   * Configure the game states
   *   * Start the game
   *
   * param  [String]  dom id
   * returns this
   */
  Alienzed(): super(320, 480, AUTO, '') {

    state.add('Initialize', new Initialize());
    state.add('Assets',     new Assets());
    state.add('Levels',     new Levels());
    state.add('Level1',     new Level1());
    state.add('GameOver',   new GameOver());
    state.start('Initialize');
  }
}
