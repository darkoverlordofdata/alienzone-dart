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
#
#
# Game Over
*/

part of alienzed;


class GameOver extends State {

  Button startButton;

  //
  // Phaser.State::create
  //
  // @return	Nothing
  //
  create() {


    // game over message
    var gameOver = add.text(0, 0, "Game Over", {
        'fill' : "#e22", 'align' : "center"
    });
    gameOver.fixedToCamera = true;
    gameOver.cameraOffset.setTo(0, 0);
    startButton = add.button(world.centerX - 95, 350, 'startButton', startGame, this, 2, 1, 0);

  }


  //
  // Start Game
  //
  // @return	Nothing
  //
  startGame() {
    state.start("Level1", true, false);
  }
}