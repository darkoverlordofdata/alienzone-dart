/*+--------------------------------------------------------------------+
#| Levels.coffee
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

class Intro extends State {

  /**
   * Levels
   */
  var level = 1;

  create() {
    add // ui components
      ..sprite(0, 0, 'splashScreen')
      ..button(world.centerX - 95, 350, 'startButton', startGame, this);
  }


  startGame(source, input, flag) {

    state.start("Levels", true, false);
  }
}