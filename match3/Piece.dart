/*+--------------------------------------------------------------------+
#| Piece.dart
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

typedef void getDeepMatching(Piece piece);

class Piece extends Pointe {

  var grid;
  var object;

  Piece(this.grid, x, y) : super(x, y) {
    clear();
  }

  clear() {
    this.object = new VoidObject();
  }

  relativeCoordinates(direction, distance) {
    return new Pointe(x + distance * direction.x, y + distance * direction.y);
  }

  neighbour(direction) {
    return grid.neighbourOf(this, direction);
  }


  neighbours() {
    return grid.neighboursOf(this);
  }

  matchingNeighbours() {
    var matches = [];
    var directions = neighbours();

    directions.forEach((direction, neighbour) {
      if (neighbour != null) {
        if (neighbour.object.type == this.object.type) {
          matches.add(neighbour);
        }
      }
    });
    return matches;

  }

  deepMatchingNeighbours() {
    var deepMatches = [];
    getDeepMatching deepMatchingNeighbours;

    deepMatchingNeighbours = (piece) {
      var matchingNeighbours = piece.matchingNeighbours();

      matchingNeighbours.forEach((matchingNeighbour) {
        if (deepMatches.indexOf(matchingNeighbour) == -1) {
          deepMatches.add(matchingNeighbour);
          deepMatchingNeighbours(matchingNeighbour);
        }
      });
    };

    deepMatchingNeighbours(this);
    return deepMatches;

  }
}