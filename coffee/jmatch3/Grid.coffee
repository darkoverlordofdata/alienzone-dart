#+--------------------------------------------------------------------+
#| Grid.coffee
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

class jMatch3.Grid

  @directions =
    up:     x: 0, y: -1
    down:   x: 0, y: 1
    right:  x: 1, y: 0
    left:   x: -1, y: 0

  # Get last empty piece from an Array of pieces
  @getLastEmptyPiece = (pieces) ->
    lastEmpty = false
    for piece in pieces
      if piece.object is jMatch3.voidObject
        lastEmpty = piece
    return lastEmpty


  constructor: (options = {})  ->
    
    @gravity = options.gravity || false # Could be "up", "down", "left", "right" or false
    @height = options.height || 10
    @width = options.width || 10

    @pieces = []

    for i in [0...@width]
      @pieces.push(new Array(@height))

    for y in [0...@height]
      for x in [0...@width]
        @pieces[x][y] = new jMatch3.Piece(this, x, y)

  # Return if given coords are in the grid
  coordsInWorld: (coords) ->
    coords.x >= 0 and coords.y >= 0 and coords.x < @width and coords.y < @height

  # Return the piece from given coords
  getPiece: (coords) ->
    if (@coordsInWorld(coords))
      @pieces[coords.x][coords.y]
    else
      false

  # Return the piece neighbour of another piece from a given direction
  neighbourOf: (piece, direction) ->
    targetCoords = piece.relativeCoordinates(direction, 1)
    @getPiece(targetCoords)

  # Return a Hash of pieces by direction
  neighboursOf: (piece) ->
    result = {}
    for directionName of Grid.directions
      result[directionName] = @neighbourOf(piece, Grid.directions[directionName])
    result

  # Execute a callback for each current match
  forEachMatch: (callback) ->
    matches = @getMatches()
    if (matches)
      for match in matches
        callback(match, match[0].object.type)
    return

  # Return an array of matches or false
  getMatches: () ->
    checked = []
    matches = []

    for pieces in @pieces
      for piece in pieces

        if checked.indexOf(piece) is -1
          match = piece.deepMatchingNeighbours()

          for m in match
            checked.push m

          if match.length >= 3

            if piece.object.type isnt jMatch3.voidObject.type
              matches.push match

    if matches.length is 0
      return false

    return matches

  # Return an Array of pieces
  getRow: (row, reverse) ->
    pieces = []
    for piece in @pieces
      pieces.push piece[row]
    return if reverse then pieces.reverse() else pieces

  # Return an Array of pieces
  getColumn: (column, reverse) ->
    pieces = []
    for i in [0...@height]
      pieces.push(@pieces[column][i])
    return if reverse then pieces.reverse() else pieces

  # Destroy all matches and update the grid
  clearMatches: () ->
    matches = @getMatches()

    if matches.length is 0
      return false

    for pieces in matches
      for piece in pieces
        piece.clear()

    return true

  # Swap 2 pieces object
  swapPieces: (piece1, piece2) ->
    tmp1 = piece1.object
    tmp2 = piece2.object
    piece1.object = tmp2
    piece2.object = tmp1
    return

  # Return an Array of falling pieces
  applyGravity: () ->
    if @gravity

      direction = Grid.directions[@gravity]
      horizontal = direction.x isnt 0
      reverse = if horizontal then direction.x is 1 else direction.y is 1

      fallingPieces = []
      for i in [0...if horizontal then @height else @width]

        chunk = if horizontal then @getRow(i, reverse) else @getColumn(i, reverse)

        applyGravity = (grid) =>
          swaps = 0
          for piece in chunk
            neighbour = piece.neighbour(direction)

            if (piece.object isnt jMatch3.voidObject and neighbour and neighbour.object is jMatch3.voidObject)
              grid.swapPieces(piece, neighbour)
              if fallingPieces.indexOf(neighbour) is -1
                fallingPieces.push(neighbour)
              swaps++

          if swaps > 0
            applyGravity(grid)
        applyGravity(@)
      fallingPiecesWithoutEmpty = []

      for piece in fallingPieces
        if piece.object isnt jMatch3.voidObject
          fallingPiecesWithoutEmpty.push(piece)

      return fallingPiecesWithoutEmpty

  debug: (symbols) ->
    lines = []

    for i in [0...@height]
      line = @getRow(i)
      pieces = ""
      for x in line
        type = x.object.type
        pieces += if typeof symbols isnt "undefined" then symbols[type] else type

      lines.push(pieces)

    console.log("[jMatch3] - Actual Grid")

    for line in lines
      console.log line

