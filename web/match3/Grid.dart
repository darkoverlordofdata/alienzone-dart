/*+--------------------------------------------------------------------+
#| Grid.dart
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
*/
part of alienzed;

typedef void doGravity(dynamic grid);

class Grid {

  int width;
  int height;
  String gravity;
  var pieces;

  var directions = {
    'up':     {'x': 0, 'y': -1},
    'down':   {'x': 0, 'y': 1},
    'right':  {'x': 1, 'y': 0},
    'left':   {'x': -1, 'y': 0}
  };

  static var voidObject = new VoidObject();

  // Get last empty piece from an Array of pieces
  static getLastEmptyPiece(pieces){
    var lastEmpty = false;
    pieces.forEach((piece) {
      if (piece.object == voidObject) {
        lastEmpty = piece;
      }
    });
    return lastEmpty;

  }



  Grid({String gravity: 'none', int height: 10, int width: 10}) {
    this.gravity = gravity;
    this.height = height;
    this.width = width;
    this.pieces = [];

    for (int i=0; i<width; i++) {
      pieces.add(new List(height));
    }

    for (int y=0; y<height; y++) {
      for (int x=0; x<width; x++) {
        pieces[x][y] = new Piece(this, x, y);
      }
    }
  }

  // Return if given coords are in the grid
  coordsInWorld(coords)  {
    coords.x >= 0 && coords.y >= 0 && coords.x < width && coords.y < height;
  }

  // Return the piece from given coords
  getPiece(coords) {
    if (coordsInWorld(coords)) {
      return pieces[coords.x][coords.y];
    }
    else {
      return null;
    }
  }

  // Return the piece neighbour of another piece from a given direction
  neighbourOf(piece, direction) {
    var targetCoords = piece.relativeCoordinates(direction, 1);
    getPiece(targetCoords);
  }

  // Return a Hash of pieces by direction
  neighboursOf(piece) {
    var result = {};
    directions.forEach((directionName, direction) {
      result[directionName] = neighbourOf(piece, direction);
    });
    return result;
  }

  // Execute a callback for each current match
  forEachMatch(callback) {
    var matches = getMatches();
    matches.forEach((match) => callback(match, match[0].object.type));
  }

  // Return an array of matches or false
  getMatches() {
    var checked = [];
    var matches = [];

    pieces.forEach((row) {
      row.forEach((piece) {
        if (checked.indexOf(piece) == -1) {
          var match = piece.deepMatchingNeighbours();

          match.forEach((m) => checked.add(m));
          if (match.length >= 3) {
            if (piece.object != voidObject) {
              matches.add(match);
            }
          }
        }
      });
    });

    return matches;
  }


  // Return an Array of pieces
  getRow(row, reverse) {
    var result = [];

    result.forEach((piece) => result.add(piece[row]));
    return (reverse) ? result.reverse() : result;
  }

  // Return an Array of pieces
  getColumn(column, reverse) {
    var result = [];

    for (int i=0; i<height; i++) {
      result.add(pieces[column][i]);
    }
    return (reverse) ? result.reverse() : result;
  }

  // Destroy all matches and update the grid
  clearMatches() {
    var matches = getMatches();

    if (matches.length == 0)
      return false;

    matches.forEach((row) {
      row.forEach((piece) => piece.clear());
    });
    return true;
  }

  // Swap 2 pieces object
  swapPieces(piece1, piece2) {
    var tmp1 = piece1.object;
    var tmp2 = piece2.object;
    piece1.object = tmp2;
    piece2.object = tmp1;
   }

  // Return an Array of falling pieces
  applyGravity() {
    print("applyGravity");
    if (gravity != 'none') {

      var direction = directions[gravity];
      var horizontal = (direction.x != 0);
      var reverse = (horizontal) ? (direction.x == 1) : (direction.y == 1);
      var fallingPieces = [];
      var limit = (horizontal) ? height : width;
      var chunk;


      for (var i=0; i<limit; i++) {

        chunk = (horizontal) ? getRow(i, reverse) : getColumn(i, reverse);

        doGravity applyGravity;
        applyGravity = (grid) {

          var swaps = 0;
          chunk.forEach((piece) {

            var neighbour = piece.neighbour(direction);

            if (piece.object != voidObject && neighbour.object == voidObject) {
              grid.swapPieces(piece, neighbour);
              if (fallingPieces.indexOf(neighbour) == -1)
                fallingPieces.add(neighbour);
              swaps++;
            }
          });

          if (swaps > 0)
            applyGravity(grid);
        };
        applyGravity(this);
      }
      var fallingPiecesWithoutEmpty = [];

      fallingPieces.forEach((piece) {
        if (piece.object != voidObject)
          fallingPiecesWithoutEmpty.add(piece);
      });

      return fallingPiecesWithoutEmpty;
    }
    return null;
  }



}
