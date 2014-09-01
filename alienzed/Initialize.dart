/*+--------------------------------------------------------------------+
#| Initialize.coffee
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

class Initialize extends State {

  static var score = 0;
  static var music = null;
  static var orientated = false;

  preload() {
    load.image('splashScreen', 'images/splash.png');
  }

  /**
   * == Initialize ==
   *
   *   * Start loading the the splash screen image
   *   * Configure the game engine to the environment
   */
  create() {
    input.maxPointers = 1;
    stage.disableVisibilityChange = true;

    if (game.device.desktop) {
      scale.scaleMode = ScaleManager.SHOW_ALL;
      scale.minWidth = 320;
      scale.minHeight = 480;
      scale.maxWidth = 640;
      scale.maxHeight = 960;
      scale.pageAlignHorizontally = true;
      scale.pageAlignVertically = true;
      scale.setScreenSize(true);
    }
    else {
      scale.scaleMode = ScaleManager.SHOW_ALL;
      scale.minWidth = 320;
      scale.minHeight = 480;
      scale.maxWidth = 640;
      scale.maxHeight = 960;
      scale.pageAlignHorizontally = true;
      scale.pageAlignVertically = true;
      scale.forceOrientation(false);
      scale.hasResized.add(gameResized, this);
      scale.enterIncorrectOrientation.add(enterIncorrectOrientation, this);
      scale.leaveIncorrectOrientation.add(leaveIncorrectOrientation, this);
      scale.setScreenSize(true);
    }
    // Load the remaining assets
    state.start('Assets', true, false);
  }

  gameResized(width, height) {}


  enterIncorrectOrientation() {

    orientated = false;
    querySelector('#orientation').style.display = 'block';
  }

  leaveIncorrectOrientation() {

    orientated = true;
    querySelector('#orientation').style.display = 'none';
  }
}