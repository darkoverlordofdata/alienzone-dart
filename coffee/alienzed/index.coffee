#+--------------------------------------------------------------------+
#| alienzed.coffee
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
module.exports = class alienzed extends Phaser.Game

  @GEMSIZE    = 48    # Gem size constant in pixels
  @MARGINTOP  = 2     # Margin top equal to 2 gems height
  @GEMTYPES   = [     # All gem types:
    "blue"
    "cyan"
    "green"
    "magenta"
    "orange"
    "pink"
    "red"
    "yellow"
  ]

  id          : ''
  width       : 320
  height      : 480
  renderer    : Phaser.CANVAS
 
  #
  # == New Game ==
  #   * Set the screen dimensions
  #   * Configure the game states
  #   * Start the game
  #
  # @param  [String]  dom id
  # @returns this
  #
  constructor: (@id) ->

    super @width, @height, @renderer, @id

    @state.add 'Initialize',  alienzed.Initialize, false
    @state.add 'Assets',      alienzed.Assets, false
    @state.add 'Levels',      alienzed.Levels, false
    @state.add 'Level1',      alienzed.Level1, false
    @state.add 'GameOver',    alienzed.GameOver, false

    @state.start 'Initialize'


#
# == Object Model ==
#
require './Assets'
require './GameOver'
require './Gem'
require './GemGroup'
require './Initialize'
require './Levels'
require './Level1'


