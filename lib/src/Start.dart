/*+--------------------------------------------------------------------+
#| Start.coffee
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

class Start extends State {

  bool orientated = false;

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

    print("Class Start initialized");
    input.maxPointers = 1;
    stage.disableVisibilityChange = true;

    if (game.device.desktop) {
      scale // for desktop:
        ..scaleMode = ScaleManager.SHOW_ALL
        ..minWidth = 320
        ..minHeight = 480
        ..maxWidth = 640
        ..maxHeight = 960
        ..pageAlignHorizontally = true
        ..pageAlignVertically = true
        ..setScreenSize(true);
    } else {
      scale // for mobile:
        ..scaleMode = ScaleManager.SHOW_ALL
        ..minWidth = 320
        ..minHeight = 480
        ..maxWidth = 640
        ..maxHeight = 960
        ..pageAlignHorizontally = true
        ..pageAlignVertically = true
        ..forceOrientation(false)
        ..hasResized.add(gameResized, this)
        ..enterIncorrectOrientation.add(enterIncorrectOrientation, this)
        ..leaveIncorrectOrientation.add(leaveIncorrectOrientation, this)
        ..setScreenSize(true);
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