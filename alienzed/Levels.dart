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

class Levels extends State {

  /**
   * Levels
   */
  var level = 1;
  Sprite menu;
  Sprite background;
  Sprite startButton;

  create() {
    background = add.sprite(0, 0, 'splashScreen');
    startButton = add.button(world.centerX - 95, 350, 'startButton', startGame, this);
  }


  startGame(source, input, flag) {

    state.start("Level$level", true, false);
  }
}