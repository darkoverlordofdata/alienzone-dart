#+--------------------------------------------------------------------+
#| index.coffee
#+--------------------------------------------------------------------+
#| Copyright DarkOverlordOfData (c) 2013
#+--------------------------------------------------------------------+
#|
#| This file is a part of jmatch3
#|
#| liquid.coffee is free software; you can copy, modify, and distribute
#| it under the terms of the MIT License
#|
#+--------------------------------------------------------------------+
#
# jMatch3 Game Engine
#
# Based on the work:
#
#   https://github.com/hugeen/jmatch3
#   http://hugeen.github.io/jmatch3/
#
module.exports = class jMatch3

  @voidObject = type: "empty"

require './Grid'
require './Piece'