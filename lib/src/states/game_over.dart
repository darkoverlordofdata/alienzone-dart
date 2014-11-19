/**
 *--------------------------------------------------------------------+
 * GameOver.dart
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

class GameOver extends Li2State {

  /**
   * == Game Over ==
   *   * Show the splash screen
   *   * Play again?
   */

  Game parent;
  Phaser.Button startButton;
  Li2Config config;

  GameOver(this.parent, this.config);

  /**
   * State::create
   *
   * @return	Nothing
   */
  create() {


    // game over message
    Phaser.TextStyle style = new TextStyle(
        font      : "bold 30px Acme",
        fill      : "#e22",
        align     : "center"
    );
    Phaser.Text gameOver = add.text(0, 0, "Game Over", style);
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
    state.start("Level1");
  }
}