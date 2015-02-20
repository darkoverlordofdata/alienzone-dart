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
 * callback from the web view with state
###
game_start = ->
  game.eraseSplash()

class Game

  VERSION   : '0.0.36'
  width     : 320
  height    : 512
  base      : 'app/packages/alienzone/res/'
  objects   : []
  game      : Phaser.Game

  constructor: ->

    @objects = []
    @game = new Phaser.Game(@width, @height, Phaser.CANVAS, "")
    @game.state.add("Boot", new Boot(this, @game))
    @game.state.add("Splash", new Splash(this, @game))
    @game.state.start("Boot")

    Cocoon.App.WebView.on 'load',
      success: ->
        Cocoon.App.showTheWebView(0, 0, window.innerWidth * window.devicePixelRatio, window.innerHeight * window.devicePixelRatio)

      error: ->
        console.log(JSON.stringify(arguments))


    Cocoon.App.loadInTheWebView("app/index.html")

  eraseSplash: ->
    for obj in @objects

      @game.add.tween(obj).to({alpha:0}, 2000).start()
      window.setTimeout ->
        obj.destroy()
      , 3000


###
 * Boot
 *   Load the logo image,
 *   configure the game
###
class Boot

  constructor:(@app, @game) ->
    console.log('Initialized Class Boot')

  ###
   * load the logo
  ###
  preload: ->
    @game.load.image('logo', "#{@app.base}images/d16a.png")

  ###
   * configure the game
  ###
  create: ->
    @game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL
    @game.scale.pageAlignHorizontally = true
    @game.scale.pageAlignVertically = true
    @game.scale.setScreenSize(true)
    @game.physics.startSystem(Phaser.Physics.ARCADE)
    @game.state.start("Splash")

###
 * Splash
 *   Display the logo splash
###
class Splash

  constructor:(@app, @game) ->
    console.log('Initialized Class Splash')

  ###
   * Load reemaining sprites and text elements
  ###
  preload: ->
    title = 'Alien Zone'
    copyright = 'Copyright 2014 Dark Overlord of Data'
    build = "Build #{@app.VERSION}"
    style10 =
      fill: 'yellow'
      font: '10pt opendyslexic'

    style40 =
      fill: 'orange'
      font: '40pt opendyslexic'

#    @game.load.spritesheet('sprite1', "#{@app.base}images/star17.png", 17, 17)
#    @game.load.spritesheet('sprite2', "#{@app.base}images/bucky.png", 64, 64)

    obj = @game.add.sprite(@app.width/2, @app.height/2, 'logo')
    obj.anchor.setTo(0.5, 0.5)
    @app.objects.push(obj)

    obj = @game.add.text(@app.width/2, 80, title, style40)
    obj.anchor.setTo(0.5)
    @app.objects.push(obj)

    obj = @game.add.text(@app.width/2, 400, build, style10)
    obj.anchor.setTo(0.5)
    @app.objects.push(obj)

    obj = @game.add.text(@app.width/2, 480, copyright, style10)
    obj.anchor.setTo(0.5)
    @app.objects.push(obj)

  ###
   * Fire the particle emitters, Number One
   * (Say it like you're Patrick Stewart)
  ###
  create: ->
    ###
     * star particles
    ###
#    backStars = @game.add.emitter(@app.width/2, -32, 100)
#    backStars.makeParticles('sprite1', [0, 1])
#    backStars.maxParticleScale = 0.6
#    backStars.minParticleScale = 0.2
#    backStars.setYSpeed(20, 50)
#    backStars.setXSpeed(-15, 15)
#    backStars.gravity = 0
#    backStars.width = @app.width
#    backStars.minRotation = 0
#    backStars.maxRotation = 0
#    backStars.start(false, 14000, 500)

    ###
     * buckyball particles
    ###
#    backBalls = @game.add.emitter(@app.width/2, -32, 50)
#    backBalls.makeParticles('sprite2', [0])
#    backBalls.maxParticleScale = 0.75
#    backBalls.minParticleScale = 0.5
#    backBalls.setYSpeed(20, 70)
#    backBalls.setXSpeed(-20, 20)
#    backBalls.gravity = 0
#    backBalls.width = @app.width
#    backBalls.minRotation = 0
#    backBalls.maxRotation = 0
#    backBalls.start(false, 14000, 1000)

    ###
     * signal the game to start
    ###
    Cocoon.App.forwardAsync("D16A_WAIT=false;window.dispatchEvent(new CustomEvent('D16A_START'))")

game = new Game()