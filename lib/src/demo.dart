/**
 *--------------------------------------------------------------------+
 * Demo.dart
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

class Demo extends Li2State {

  /**
   * == Game Over ==
   *   * Show the splash screen
   *   * Play again?
   */

  Game parent;
  Li2Config config;
  World artemis;
  Context orion;


  Demo(this.parent, this.config);

  /**
   * initialize artemis
   * create the game entities
   * start the systems
   */
  create() {

    artemis = new World();
    orion = new Context(game, artemis);

    /**
     * Load the entity data
     */
    for (var entities in config.extra['demo']) {
      entities.forEach((entity, components) {
        orion.add.invoke(entity, components);
      });
    }

    /**
     * Add Systems and start
     */
    artemis
      ..addSystem(new ArcadePhysicsSystem(game, orion))
      ..addSystem(new BackgroundRenderSystem(game, orion))
      ..addSystem(new PlatformRenderSystem(game, orion))
      ..addSystem(new PlayerControlSystem(game, orion))
      ..addSystem(new StarsRenderSystem(game, orion))
      ..addSystem(new ScoreRenderSystem(game, orion))
      ..initialize();

  }

  /**
   * Game Loop
   */
  update() {
    artemis.delta = game.time.elapsed;
    artemis.process();
  }

}