/*+--------------------------------------------------------------------+
#| Piece.dart
#+--------------------------------------------------------------------+
#| Copyright DarkOverlordOfData (c) 2014
#+--------------------------------------------------------------------+
#|
#| This file is a part of match3
#|
#| match3 is free software; you can copy, modify, and distribute
#| it under the terms of the MIT License
#|
#+--------------------------------------------------------------------+
#
# match3 Game Logic
*/
part of match3;

typedef void GetDeepMatching(Piece piece);

class Piece extends Locus {

  Grid grid;
  MatchObject object;

  Piece(this.grid, x, y) : super(x, y) {
    clear();
  }

  void clear() {
    object = new MatchObject.empty();
  }

  Locus relativeCoordinates(Locus direction, int distance) {
    return new Locus(x + distance * direction.x, y + distance * direction.y);
  }

  Piece neighbour(Locus direction) {
    return grid.neighbourOf(this, direction);
  }


  Map neighbours() {
    return grid.neighboursOf(this);
  }

  List matchingNeighbours() {
    var matches = [];
    var directions = neighbours();

    directions.forEach((direction, neighbour) {
      if (neighbour != null) {
        if (neighbour.object.type == object.type) {
          matches.add(neighbour);
        }
      }
    });
    return matches;

  }

  List deepMatchingNeighbours() {
    var deepMatches = [];

    GetDeepMatching deepMatchingNeighbours;

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