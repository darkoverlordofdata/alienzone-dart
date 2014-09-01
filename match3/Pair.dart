
part of match3;

class Pair {

  var order;
  Point first;
  Point second;
  var ordinals = ["first", "second"];

  Pair(int ordinal1, int ordinal2, Point this.first, Point this.second) {

    order = [ordinals[ordinal1-1], ordinals[ordinal2-1]];

  }

}
