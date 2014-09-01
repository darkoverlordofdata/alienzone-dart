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
#
#
# == Initialize ==
#
#   * Start loading the the splash screen image
#   * Configure the game engine to the environment
*/
part of alienzed;

class Initialize extends State {

  // Here we've just got some global level vars that persist regardless of State swaps
  static var score = 0;

  // If the music in your game needs to play through-out a few State swaps, then you could reference it here
  static var music = null;

  // Your game can check BasicGame.orientated in internal loops to know if it should pause or not
  static var orientated = false;

  preload() {
    print('preload');
    load.image('splashScreen', 'images/splash.png');
  }

  create() {
    print('create');
    input.maxPointers = 1;
    stage.disableVisibilityChange = true;

    if (game.device.desktop) {
      print("game.device.desktop TRUE");
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
      print("game.device.desktop FALSE");
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
    print('next');
    state.start('Assets', true, false);
  }

  gameResized(width, height) {}


  enterIncorrectOrientation() {

    orientated = false;
    //document.getElementById('orientation').style.display = 'block';
  }

  leaveIncorrectOrientation() {

    orientated = true;
    //document.getElementById('orientation').style.display = 'none';
  }
}