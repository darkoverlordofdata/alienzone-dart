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

class GameOver extends State {

  /**
   * Game Over
   */
  Button startButton;

  /**
   * Phaser.State::create
   *
   * @return	Nothing
   */
  create() {


    // game over message
    var style = new TextStyle(
        font      : "bold 30px Acme",
        fill      : "#e22",
        align     : "center"
    );
    var gameOver = add.text(0, 0, "Game Over", style);
    gameOver.fixedToCamera = true;
    gameOver.cameraOffset.setTo(0, 0);
    startButton = add.button(world.centerX - 95, 350, 'startButton', startGame, this);

  }


  /**
   * Start Game
   *
   * @return	Nothing
   */
  startGame(source, input, flag) {
    state.start("Level1", true, false);
  }
}