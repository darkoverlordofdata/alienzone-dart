/**
 *--------------------------------------------------------------------+
 * game.dart
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

class Game extends Li2.Dilithium implements CocoonListener {

  CocoonServices cocoon;

  /**
   * == New Game ==
   *   * Set the screen dimensions
   *   * Configure the game states
   *   * Start the game
   *
   * returns this
   */
  Game(Li2.Config config): super(config) {

    print("Class Game initialized  ");
    cocoon = new CocoonServices(config, this);
  }

  loginStatusChanged(object, value, error){

  }
  requestScore(object, value, error){

  }

  /**
   * Define each of the game states
   */
  Phaser.State levels() {


    game.state.add('helplogin', new BaseLevel('helplogin', config, cocoon));
    game.state.add('howtoplay', new BaseLevel('howtoplay', config, cocoon));
    game.state.add('infinity', new BaseLevel('infinity', config, cocoon));
    game.state.add('ftl', new BaseLevel('ftl', config, cocoon));
    game.state.add('gameover', new BaseLevel('gameover', config, cocoon));
    game.state.add('achievements', new BaseLevel('achievements', config, cocoon));
    game.state.add('leaderboards', new BaseLevel('leaderboards', config, cocoon));

    try {
      document.querySelector('#logo').style.display = "none";
    } catch(e) {}
    return new BaseLevel('main', config, cocoon);

  }


}
