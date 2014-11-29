/**
 *--------------------------------------------------------------------+
 * Game.dart
 *--------------------------------------------------------------------+
 * Copyright DarkOverlordOfData (c) 2014
 *--------------------------------------------------------------------+
 *
 * This file is a part of Alien Zone
 *
 * Alien Zone is free software; you can copy, modify, and distribute
 * it under the terms of the GPLv3 License
 *
 *--------------------------------------------------------------------+
 *
 */
part of alienzone;

class Game { //extends Dilithium {

  static const VOLUME_ON  = 0.05;
  static const VOLUME_OFF = 0;
  static const GEMSIZE    = 48;     // Gem size constant in pixels
  static const MARGINTOP  = 2;      // Margin top equal to 2 gems height
  static final List GEMTYPES = [    // All gem types:
      "blue",
      "cyan",
      "green",
      "magenta",
      "orange",
      "pink",
      "red",
      "yellow"
  ];

  AlienZoneApplication app;
  Li2Config config;
  Li2Template template;

  num soundfx = VOLUME_ON;
  bool fullscreen = true;
  bool playmusic = true;

  PIXI.Stage stage;
  PIXI.Renderer renderer;
  Map<String, PIXI.Texture> images;
  int width = 320;
  int height = 480;


  /**
   * == New Game ==
   *   * Set the screen dimensions
   *   * Configure the game states
   *   * Start the game
   *
   * returns this
   */
  Game(this.config, this.template) {

    print("Class Game initialized");

    if (window.navigator.appVersion.contains("CocoonJS")) {

      // Use Canvas+
      var canvas = document.createElement("screencanvas");
      canvas.style.cssText = "idtkscale:ScaleAspectFill;";
      canvas.width = window.innerWidth;
      canvas.height = window.innerHeight;
      document.body.append(canvas);
      renderer = new PIXI.CanvasRenderer(window.innerWidth, window.innerHeight, canvas);

    } else {

      // Let PIXI decide
      renderer = PIXI.autoDetectRenderer(window.innerWidth, window.innerHeight, null);
      document.body.append(renderer.view);
    }

    var game_stage = new PIXI.DisplayObjectContainer();
    game_stage.scale.x = window.innerWidth / width;
    game_stage.scale.y = window.innerHeight / height;

    stage = new PIXI.Stage(0x000000, true);
    stage.addChild(game_stage);

    images = new Map();
    var assets = [];
    config.images.forEach((key, path) {
      assets.add(config.path + path);
      images[key] = PIXI.Texture.fromImage(config.path + path);
    });

    var loader = new PIXI.AssetLoader(assets);
    loader.onComplete = () {
      var splash = new PIXI.Sprite(images['splash']);
      game_stage.addChild(splash);
      PIXI.requestAnimFrame(update);
    };
    loader.load();

    window.document.getElementById("logo").hidden = true;
  }

  update(dt) {

    PIXI.requestAnimFrame(update);
    renderer.render(stage);
  }


  /**
   * Set game preferences
   */
  setPreference(id, value) {

    switch(id) {
      case 'fullscreen':
        fullscreen = value;
        break;

      case 'soundfx':
        soundfx = value ? VOLUME_ON : VOLUME_OFF;
        break;

      case 'playmusic':
        playmusic = value;
        break;
    }
  }

}
