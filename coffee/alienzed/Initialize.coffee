#+--------------------------------------------------------------------+
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
alienzed = require('../alienzed')
#
# == Initialize ==
#
#   * Start loading the the splash screen image
#   * Configure the game engine to the environment
#
class alienzed.Initialize extends Phaser.State

  # Here we've just got some global level vars that persist regardless of State swaps
  @score = 0

  # If the music in your game needs to play through-out a few State swaps, then you could reference it here
  @music = null

  # Your game can check BasicGame.orientated in internal loops to know if it should pause or not
  @orientated = false


  preload: () ->

    @load.image 'splashScreen', 'images/splash.png'


  create: () ->

    @input.maxPointers = 1
    @stage.disableVisibilityChange = true

    if @game.device.desktop
      @scale.scaleMode = Phaser.ScaleManager.SHOW_ALL
      @scale.minWidth = 320
      @scale.minHeight = 480
      @scale.maxWidth = 640
      @scale.maxHeight = 960
      @scale.pageAlignHorizontally = true
      @scale.pageAlignVertically = true
      @scale.setScreenSize true
    
    else
      @scale.scaleMode = Phaser.ScaleManager.SHOW_ALL
      @scale.minWidth = 320
      @scale.minHeight = 480
      @scale.maxWidth = 640
      @scale.maxHeight = 960
      @scale.pageAlignHorizontally = true
      @scale.pageAlignVertically = true
      @scale.forceOrientation false
      @scale.hasResized.add @gameResized, @
      @scale.enterIncorrectOrientation.add @enterIncorrectOrientation, @
      @scale.leaveIncorrectOrientation.add @leaveIncorrectOrientation, @
      @scale.setScreenSize true

    # Load the remaining assets
    @state.start 'Assets', true, false

  gameResized: (width, height) ->


  enterIncorrectOrientation: () ->

    alienzed.orientated = false
    document.getElementById('orientation').style.display = 'block'

  leaveIncorrectOrientation: () ->

    alienzed.orientated = true
    document.getElementById('orientation').style.display = 'none'

