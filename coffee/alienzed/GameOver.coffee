#+--------------------------------------------------------------------+
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
alienzed = require('../alienzed')
#
# Game Over
#

class alienzed.GameOver extends Phaser.State

  #
  # Phaser.State::create
  #
  # @return	Nothing
  #
  create: ->
  
    # game over message
    gameOver = @add.text(0, 0, "Game Over",
      fill    : "#e22"
      align   : "center"
    )
    gameOver.fixedToCamera = true
    gameOver.cameraOffset.setTo 0,0
    @startButton = @add.button(@world.centerX - 95, 350, 'startButton', @startGame, @, 2, 1, 0)



  #
  # Start Game
  #
  # @return	Nothing
  #
  startGame: ->

    @state.start "Level1", true, false
