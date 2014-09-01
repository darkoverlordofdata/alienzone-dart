/*+--------------------------------------------------------------------+
#| Piece.dart
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
        matches.push(neighbour);
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
          deepMatches.push(matchingNeighbour);
          deepMatchingNeighbours(matchingNeighbour);
        }
      });
    };

    deepMatchingNeighbours(this);
    return deepMatches;

  }
}