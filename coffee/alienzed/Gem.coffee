#+--------------------------------------------------------------------+
#| Gem.coffee
#+--------------------------------------------------------------------+
#| Copyright DarkOverlordOfData (c) 2013
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
jMatch3 = require('../jmatch3')
alienzed = require('../alienzed')
#
# Gem class
#
class alienzed.Gem

  #
  # == New Gem ==
  #   * Set the sprite
  #   * Set the initial position
  #
  # @param  [Phaser.GameState]  parent object
  # @param  [String]  gem type
  # @param  [Number]  x coordinate
  # @param  [Number]  y coordinate
  # @returns this
  #
  constructor: (@level, @type, x, y) ->
    @sprite = @level.add.sprite(0, 0, "gem_#{type}")
    @move(x, y)

  #
  # Move method
  #
  # @param  [Number]  x coordinate
  # @param  [Number]  y coordinate
  # @returns none
  #
  move: (x, y) ->
    @x = x
    @y = y
    @sprite.x = @x * alienzed.GEMSIZE
    @sprite.y = @y * alienzed.GEMSIZE
    return

  #
  # Drop method
  #
  # @param  [Function]  next function
  # @returns none
  #
  drop: (next) ->
    # Get the gem column
    column = @level.grid.getColumn(@x)
    # Get the last empty piece to place the gem
    lastEmpty = jMatch3.Grid.getLastEmptyPiece(column)
    # If an empty piece has been found
    if lastEmpty
      # Bind this gem to the piece
      lastEmpty.object = @
      # And make it fall
      @fall lastEmpty.x, lastEmpty.y, next
    else
      # Game Over
      @level.gameOver()

  #
  # Fall method
  #
  # @param  [Number]  x coordinate
  # @param  [Number]  y coordinate
  # @param  [Function]  next function
  # @returns none
  #
  fall: (x, y, next) ->
    next = next or ()->
    # Create a tween animation
    @level.add.tween(@sprite)
    .to(
      x: x * alienzed.GEMSIZE
      y: alienzed.MARGINTOP * alienzed.GEMSIZE + y * alienzed.GEMSIZE
    , 500, Phaser.Easing.Bounce.Out, true)
    .onComplete.add(next)

