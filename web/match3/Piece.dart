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

typedef void getDeepMatching(dynamic piece);

class Piece {

  var grid;
  int x;
  int y;
  var object;

  Piece(this.grid, this.x, this.y) {
    clear();
  }

  clear() {
    this.object = new VoidObject();
  }

  relativeCoordinates(direction, distance) {
    return {
        x: this.x + distance * direction.x, y: this.y + distance * direction.y
    };
  }

  neighbour(direction) {
    return grid.neighbourOf(this, direction);
  }


  neighbours() {
    return grid.neighboursOf(this);
  }

  matchingNeighbours() {
    var matches = [];
    Map<String, dynamic> directions = neighbours();

    directions.forEach((direction, neighbour) {
      if (neighbour.object.type == this.object.type) {
        matches.add(neighbour);
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