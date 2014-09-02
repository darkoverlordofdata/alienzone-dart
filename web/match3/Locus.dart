/*+--------------------------------------------------------------------+
#| Locus.dart
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

class Locus {

  int x;
  int y;

  Locus(int this.x, int this.y);

  String toString() {
    return "Locus($x, $y)";
  }
}
