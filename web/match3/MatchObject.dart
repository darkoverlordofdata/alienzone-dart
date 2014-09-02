/*+--------------------------------------------------------------------+
#| MatchObject.dart
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

class MatchObject {

  String type;

  MatchObject(this.type);
  MatchObject.empty() : type = "__empty__";

}
