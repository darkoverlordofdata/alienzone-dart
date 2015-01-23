#+--------------------------------------------------------------------+
#| bootstrap.coffee
#+--------------------------------------------------------------------+
#| Copyright DarkOverlordOfData (c) 2014
#+--------------------------------------------------------------------+
#|
#| This file is a part of Alien Zone
#|
#| Alien Zone is free software; you can copy, modify, and distribute
#| it under the terms of the GPL3 License
#|
#+--------------------------------------------------------------------+
#
# Bootstrap the game
#

###
  callback from the web view with state
###
game_start = (state) ->
  game.state.start(state)

###
  Bootstrap
###
game = do() ->

  VERSION   = '0.0.34'
  base      = 'app/packages/alienzone/res/'
  sprite1   = 'star17'
  sprite2   = 'bucky'
  logo      = 'logo'
  width     = 320
  height    = 512
  bmd       = undefined
  area      = undefined
  dropTime  = 0
  texts     = []
  done      = false


  ###
  Log
  ###
  log = ->
    console.log("Running #{game.state.getCurrentState().state.current} state  ")


  ###
  Boot
    Load the logo image,
    configure the game
  ###
  boot =
    init: ->
      log()

    preload: ->
      game.load.image(logo, "#{base}images/#{logo}.png")

    create: ->
      game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL
      game.scale.pageAlignHorizontally = true
      game.scale.pageAlignVertically = true
      game.scale.setScreenSize(true)
      game.physics.startSystem(Phaser.Physics.ARCADE)
      game.state.start("Load")

  ###
  Load
    Display the logo, load the rest
  ###
  load =
    init: ->
      log()

    preload: ->
      game.load.spritesheet(sprite1, "#{base}images/#{sprite1}.png", 17, 17)
      game.load.spritesheet(sprite2, "#{base}images/#{sprite2}.png", 64, 64)

    create: ->

      title = 'AlienZone'
      copyright = 'Copyright 2014 Dark Overlord of Data'
      build = "Build #{VERSION}"
      style10 =
        fill: '#fff'
        font: '10pt opendyslexic'

      style20 =
        fill: '#fff'
        font: '30pt opendyslexic'

      texts.push(game.add.text(50, 80, title, style20))
      texts.push(game.add.text(120, 400, build, style10))
      texts.push(game.add.text(20, 480, copyright, style10))

      bmd = game.make.bitmapData()
      bmd.load(logo).cls()
      bmd.addToWorld(game.world.centerX, game.world.centerY, 0.5, 0.5, 2, 2)
      game.stage.smoothed = false
      area = new Phaser.Rectangle(0, bmd.height, bmd.width, 1)
      dropTime = game.time.now + 250

    update: ->
      if (area.y > 0 && game.time.now > dropTime)
        for y in [0...area.y]
          bmd.copyRect(logo, area, 0, y)


        area.y--
        dropTime = game.time.now + 25
      else if (game.time.now > dropTime)
        if (done == false)
          # We're ready, so ease on out and start the game
          for i in [0...texts.length]
            game.add.tween(texts[i]).to(alpha:0, 1500, Phaser.Easing.Linear.None, true)

          bmd.shiftHSL(0.1)
          setInterval(() ->
            bmd.shiftHSL(0.1)
          , 500)

          Cocoon.App.forwardAsync("D16A_WAIT=false;window.dispatchEvent(new CustomEvent('D16A_START'))")

        done = true

  ###
  Start
    start the game animation
  ###
  start =
    init: ->
      log()

    preload: ->
    create: ->
      game.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT
      backStars = game.add.emitter(160, -32, 600)
      backBalls = game.add.emitter(160, -32, 50)

      ###
      star particles
      ###
      backStars.makeParticles(sprite1, [0])
      backStars.maxParticleScale = 0.6
      backStars.minParticleScale = 0.2
      backStars.setYSpeed(20, 100)
      backStars.setXSpeed(-15, 15)
      backStars.gravity = 0
      backStars.width = width
      backStars.minRotation = 0
      backStars.maxRotation = 40
      backStars.start(false, 14000, 200)

      ###
      buckyball particles
      ###
      backBalls.makeParticles(sprite2, [0])
      backBalls.maxParticleScale = 0.75
      backBalls.minParticleScale = 0.5
      backBalls.setYSpeed(50, 150)
      backBalls.setXSpeed(-20, 20)
      backBalls.gravity = 0
      backBalls.width = width
      backBalls.minRotation = 0
      backBalls.maxRotation = 40
      backBalls.start(false, 14000, 1000)

  game = new Phaser.Game(width, height, Phaser.CANVAS, "")
  game.state.add("Boot", boot)
  game.state.add("Load", load)
  game.state.add("Start", start)
  game.state.start("Boot")
  Cocoon.App.WebView.on 'load',
    success: () ->
      Cocoon.App.showTheWebView()

    error: () ->
      console.log(JSON.stringify(arguments))


  Cocoon.App.loadInTheWebView("app/index.html")

  return game

