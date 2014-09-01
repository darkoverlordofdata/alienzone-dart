#+--------------------------------------------------------------------+
#| Piece.coffee
#+--------------------------------------------------------------------+
#| Copyright DarkOverlordOfData (c) 2013
#+--------------------------------------------------------------------+
#|
#| This file is a part of match3
#|
#| liquid.coffee is free software; you can copy, modify, and distribute
#| it under the terms of the MIT License
#|
#+--------------------------------------------------------------------+
#
# jMatch3 Game Engine
#
jMatch3 = require('../jmatch3')

class jMatch3.Piece
  
  constructor: (grid, x, y) ->
    @grid = grid
    @x = x
    @y = y
    @object = jMatch3.voidObject
  
  clear: () ->
    @object = jMatch3.voidObject
    return
  
  relativeCoordinates: (direction, distance) ->
    return {
      x: @x + distance * direction.x,
      y: @y + distance * direction.y
    }

  neighbour: (direction) ->
    return @grid.neighbourOf(this, direction)

  neighbours: () ->
    return @grid.neighboursOf(this)

  matchingNeighbours: () ->
    matches = []
    neighbours = @neighbours()
    for direction of neighbours
      neighbour = neighbours[direction]
      if neighbour && neighbour.object.type is @object.type
        matches.push(neighbour)
    return matches

  deepMatchingNeighbours: () ->
    deepMatches = []

    deepMatchingNeighbours = (piece) =>

      matchingNeighbours = piece.matchingNeighbours()

      for matchingNeighbour in matchingNeighbours

        if deepMatches.indexOf(matchingNeighbour) is -1
          deepMatches.push(matchingNeighbour)
          deepMatchingNeighbours(matchingNeighbour)

    deepMatchingNeighbours(@)

    return deepMatches
