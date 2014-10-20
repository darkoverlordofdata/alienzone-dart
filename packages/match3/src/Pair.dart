/*+--------------------------------------------------------------------+
#| Pair.dart
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

class Pair {

  List order;
  Locus first;
  Locus second;
  var ordinals = ["first", "second"];

  Pair(int ordinal1, int ordinal2, Locus this.first, Locus this.second) {

    order = [ordinals[ordinal1-1], ordinals[ordinal2-1]];

  }

}
