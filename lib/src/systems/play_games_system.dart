/**
 *--------------------------------------------------------------------+
 * play_games_system.dart
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

class PlayGamesSystem extends Artemis.VoidEntitySystem {

  BaseLevel level;      //  parent game state
  CocoonServices cocoon;
  Phaser.Sprite controller;
  Phaser.Sprite achievements;
  Phaser.Sprite leaderboards;
  num logging = 0.5;

  PlayGamesSystem(this.level, this.cocoon);

  /**
   * Initialize option control
   */
  void initialize() {
    if (DEBUG) print("PlayGamesSystem::initialize");

    Artemis.GroupManager groupManager = level.artemis.getManager(new Artemis.GroupManager().runtimeType);
    Artemis.ComponentMapper<User> userMapper = new Artemis.ComponentMapper<User>(User, level.artemis);
    Artemis.ComponentMapper<Scale> scaleMapper = new Artemis.ComponentMapper<Scale>(Scale, level.artemis);
    Artemis.ComponentMapper<Position> positionMapper = new Artemis.ComponentMapper<Position>(Position, level.artemis);

    groupManager.getEntities(GROUP_USERS).forEach((entity) {
      User user = userMapper.get(entity);
      Scale scale = scaleMapper.get(entity);
      Position position = positionMapper.get(entity);

      controller = level.add.sprite(position.x, position.y, user.controller, 0);
      controller.inputEnabled = true;
      controller.events.onInputDown.add((sprite, pointer) => play(0));

      achievements = level.add.sprite(position.x+scale.x, position.y, user.achievements, 0);
      achievements.inputEnabled = true;
      achievements.events.onInputDown.add((sprite, pointer) => play(1));

      leaderboards = level.add.sprite(position.x+(scale.x*2), position.y, user.leaderboards, 0);
      leaderboards.inputEnabled = true;
      leaderboards.events.onInputDown.add((sprite, pointer) => play(2));

      processSystem();
    });

  }

  /**
   * Toggle
   *
   * set the button frame
   * persist the setting
   * set context preference
   */
  void play(int state) {
    print("Play state = $state");
    switch (state) {

      case 0:
      /**
       * LogIn?
       */
        if (cocoon.loggedIn) {
          logging = 0.5;
          processSystem();
          cocoon.logout();
        } else {
          logging = 1.0;
          processSystem();
          cocoon.login();
        }
        break;

      case 1:
      /**
       * Achievements
       */
        if (cocoon.loggedIn) {
          cocoon.showAchievements();

        } else {
          level.ui.showAchievements();
        }
        break;

      case 2:
      /**
       * Leaderboard
       */
        if (cocoon.loggedIn) {
          cocoon.showLeaderboard();

        } else {
          level.ui.showLeaderboard();
        }
        break;


    }
  }


  void processSystem() {
    if (cocoon.loggedIn) {
      controller.frame = 2;
      controller.alpha = 1;
      achievements.frame = 2;
      leaderboards.frame = 2;
    } else {
      controller.frame = 0;
      controller.alpha = logging;;
      achievements.frame = 0;
      leaderboards.frame = 0;
    }
  }
}
