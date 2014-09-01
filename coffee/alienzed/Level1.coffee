#+--------------------------------------------------------------------+
#| Level1.coffee
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
jMatch3 = require('../jmatch3')
alienzed = require('../alienzed')
#
# Game Level One
#

class alienzed.Level1 extends Phaser.State

  #
  # Members
  #
  background      : Phaser.Sprite
  board           : Phaser.Sprite
  grid            : jMatch3.Grid
  startButton     : Phaser.Sprite
  cells           : null
  discoveredGems  : null
  text            : null
  gemGroup        : undefined
  score           : 0

  #
  # == Create the game level
  #   * set the background and game board
  #   * draw the text
  #   * wire up the buttons
  #
  # @return none
  #
  create: () ->

    @time.advancedTiming = true
    @score = 0
    @background = @add.sprite(0, 0, 'background')
    @board = @add.sprite(0, 0, 'board')
    @board.alpha = 0.7
    @text = @add.text(100, 20, "Score: 0",
      font      : "bold 30px Acme"
      fill      : "#e0e0e0"
    )
    @grid = new jMatch3.Grid(
      width     : 6
      height    : 7
      gravity   : 'down'
    )
    @discoveredGems = [alienzed.GEMTYPES[0], alienzed.GEMTYPES[1], alienzed.GEMTYPES[2]]

    @newGemGroup()
    @add.button   0, 420, 'arrow_left',   @leftButton,  @
    @add.button  50, 420, 'arrow_down',   @dropButton,  @
    @add.button 100, 420, 'arrow_right',  @rightButton, @
    @add.button 210, 420, 'arrow_lrot',   @lrotButton,  @
    @add.button 260, 420, 'arrow_rrot',   @rrotButton,  @

  #
  # Directional Handlers
  #
  # @return none
  #
  leftButton: () ->
    @gemGroup?.move -1
    
  rightButton: () ->
    @gemGroup?.move 1
    
  lrotButton: () ->
    @gemGroup?.rotate -1
    
  rrotButton: () ->
    @gemGroup?.rotate 1
    
  dropButton: () ->
    @gemGroup?.drop()
    @gemGroup = undefined


  #
  # New Gem Group
  #
  # @return Gem Group
  #
  newGemGroup: () ->
    @gemGroup = new alienzed.GemGroup(@)

  #
  # Handle Matches
  #
  # @return none
  #
  handleMatches: () ->

    # Get all matches
    # If matches have been found
    if (matches = @grid.getMatches())
      # Initialize the array of pieces to upgrade
      piecesToUpgrade = []
      # Reference to the current game
      # For each match found
      @grid.forEachMatch (matchingPieces, type) =>
        # Add to score
        @addToScore (alienzed.GEMTYPES.indexOf(type) + 1) * matchingPieces.length
        # For each match take the first piece to upgrade it
        piecesToUpgrade.push
          piece   : matchingPieces[0]
          type    : type

        for matchingPiece in matchingPieces
          gem = matchingPiece.object
          # Remove gem bitmap from stage
          gem.sprite.destroy()

      # Remove matches and apply Gravity
      @grid.clearMatches()
      # Upgrade pieces
      @handleUpgrade piecesToUpgrade

    @handleFalling()
    return

  #
  # Handle Falling
  #
  # @return none
  #
  handleFalling: () ->

    # Apply gravity and get falling Pieces
    fallingPieces = @grid.applyGravity()

    if fallingPieces.length > 0
      # Falling counter
      hasFall = 0
      # For each falling pieces
      for piece in fallingPieces
        # Reference to current game
        # Make gem fall
        piece.object.fall piece.x, piece.y, () =>
          hasFall += 1
          if hasFall is fallingPieces.length
            @handleMatches()
    else

      # Create a new gem if no falling pieces
      @newGemGroup()
    return

  #
  # Handle Upgrade
  #
  # @return none
  #
  handleUpgrade: (piecesToUpgrade) ->

    # For each piece to upgrade
    for pieceToUpgrade in piecesToUpgrade
      # Get the upgraded type
      upgradedType = alienzed.GEMTYPES[alienzed.GEMTYPES.indexOf(pieceToUpgrade.type) + 1]
      # If the type is defined
      if typeof upgradedType isnt "undefined"
        # And if the type is not already discovered
        if @discoveredGems.indexOf(upgradedType) is -1
          # Push it to discovered gems array
          @discoveredGems.push(upgradedType)
    return


  #
  # Random Gem Type
  #
  # @return string - random gem type
  #
  randomGemType: () ->
    @discoveredGems[Math.floor(Math.random() * @discoveredGems.length)]

  #
  # Add to Score
  #
  # @return none
  #
  addToScore: (points) ->
    @score += points
    @text.text = "Score: #{@score}"
    return


  #
  # Game Over
  #
  # @return none
  #
  gameOver: () ->
    @state.start "GameOver", false, false
