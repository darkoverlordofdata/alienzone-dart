#+--------------------------------------------------------------------+
#| index.coffee
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
# Alien Zed
#
#   Match 3 Style Game
#
"use strict"
alienzed = require('./alienzed')
#
# == Entry Point ==
#   * Check for FastClick
#   * Create a new game object
# 
window.addEventListener 'load', ->
  FastClick?.attach document.body
  setTimeout () ->
    #
    # Replace brand logo with product splash
    #
    document.getElementById('logo').style.display = 'none'
    document.body.style.backgroundColor = 'black'
    new alienzed('game')
  , 1000
, false
