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
# Levels Menu
#

class alienzed.Levels extends Phaser.State

  level           : 1
  menu            : Phaser.Sprite
  background      : Phaser.Sprite
  startButton     : Phaser.Sprite

  create:() ->

    @background = @add.sprite(0, 0, 'splashScreen')
    @startButton = @add.button(@world.centerX - 95, 350, 'startButton', @startGame, @, 2, 1, 0)



  startGame:() ->

    @state.start "Level#{@level}", true, false
