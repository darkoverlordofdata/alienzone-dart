/*+--------------------------------------------------------------------+
#| Grid.dart
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
# match3 Game Logic
*/
part of match3;

typedef void ApplyGravity(dynamic grid);
typedef void FoundMatch(List matches, String type);

class Grid {

  int width;
  int height;
  String gravity;
  var pieces;

  Map<String,Locus> directions = {
    'up'    : new Locus(0, -1),
    'down'  : new Locus(0, 1),
    'right' : new Locus(1,0),
    'left'  : new Locus(-1,0)
  };

  static MatchObject emptyObject = new MatchObject.empty();

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

  /**
   *  Get last empty piece from an Array of pieces
   */
  static Piece getLastEmptyPiece(List pieces){
    var lastEmpty = null;
    pieces.forEach((piece) {
      if (piece.object.type == emptyObject.type) {
        lastEmpty = piece;
      }
    });
    return lastEmpty;

  }

  /**
   * Return if given coordinates are in the grid
   */
  bool coordsInWorld(Locus point)  {
    return (point.x >= 0 && point.y >= 0 && point.x < width && point.y < height);
  }

  // Return the piece from given coordinates
  Piece getPiece(Locus point) {

    if (coordsInWorld(point)) {
      return pieces[point.x][point.y];
    }
    else {
      return null;
    }
  }

  /**
   * Return the piece neighbour of another piece from a given direction
   */
  Piece neighbourOf(Piece piece, Locus direction) {
    var targetCoords = piece.relativeCoordinates(direction, 1);
    return getPiece(targetCoords);
  }

  /**
   * Return a Hash of pieces by direction
   */
  Map neighboursOf(Piece piece) {
    var result = {};
    directions.forEach((directionName, direction) {
      result[directionName] = neighbourOf(piece, direction);
    });
    return result;
  }

  /**
   * Execute a callback for each current match
   */
  void forEachMatch(FoundMatch callback) {
    var matches = getMatches();
    matches.forEach((match) => callback(match, match[0].object.type));
  }

  /**
   * Return an array of matches or false
   */
  List getMatches() {
    var checked = [];
    var matches = [];

    pieces.forEach((pieces) {
      pieces.forEach((piece) {
        if (checked.indexOf(piece) == -1) {
          var match = piece.deepMatchingNeighbours();

          match.forEach((m) => checked.add(m));
          if (match.length >= 3) {
            if (piece.object.type != emptyObject.type) {
              matches.add(match);
            }
          }
        }
      });
    });

    return (matches.length>0) ? matches : null;
  }

  /**
   * Return an Array of pieces
   */
  List getRow(List row, bool reverse) {
    var pieces = [];

    pieces.forEach((piece) => pieces.add(piece[row]));
    return (reverse) ? pieces.reversed.toList() : pieces;
  }

  /**
   * Return an Array of pieces
   */
  List getColumn(List column, bool reverse) {
    var pieces = [];

    for (int i=0; i<height; i++) {
      pieces.add(this.pieces[column][i]);
    }
    return (reverse) ? pieces.reversed.toList() : pieces;
  }

  /**
   * Destroy all matches and update the grid
   */
  bool clearMatches() {
    var matches = getMatches();

    if (matches.length == 0)
      return false;

    matches.forEach((pieces) {
      pieces.forEach((p) => p.clear());
    });
    return true;
  }

  /**
   * Swap 2 pieces object
   */
  void swapPieces(Piece piece1, Piece piece2) {
    var tmp1 = piece1.object;
    var tmp2 = piece2.object;
    piece1.object = tmp2;
    piece2.object = tmp1;
   }

  /**
   * Return an Array of falling pieces
   */
  List applyGravity() {
    if (gravity != 'none') {

      Locus direction = directions[gravity];
      bool horizontal = (direction.x != 0);
      bool reverse = (horizontal) ? (direction.x == 1) : (direction.y == 1);
      var fallingPieces = [];
      var limit = (horizontal) ? height : width;
      var chunk;


      for (var i=0; i<limit; i++) {

        chunk = (horizontal) ? getRow(i, reverse) : getColumn(i, reverse);

        ApplyGravity applyGravity;
        applyGravity = (grid) {

          var swaps = 0;
          chunk.forEach((piece) {

            var neighbour = piece.neighbour(direction);

            if (neighbour != null) {
              if (piece.object.type != emptyObject.type && neighbour.object.type == emptyObject.type) {
                grid.swapPieces(piece, neighbour);
                if (fallingPieces.indexOf(neighbour) == -1)
                  fallingPieces.add(neighbour);
                swaps++;
              }
            }
          });

          if (swaps > 0)
            applyGravity(grid);
        };
        applyGravity(this);
      }
      var fallingPiecesWithoutEmpty = [];

      fallingPieces.forEach((piece) {
        if (piece.object.type != emptyObject.type)
          fallingPiecesWithoutEmpty.add(piece);
      });

      return fallingPiecesWithoutEmpty;
    }
    return null;
  }



}
