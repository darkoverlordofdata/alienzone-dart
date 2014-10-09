/**
 *--------------------------------------------------------------------+
 * AlienZoneApplication.dart
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

class AlienZoneApplication {

  /**
   * == Start ==
   *
   *   * Check if running with cordova
   *   * Start a game
   */
  AlienZoneApplication() {

    if (context['cordova'] != null) {
      cordova.Device.init()
      .then((device) => startGame(this, device))
      .catchError((ex, st) {
        print(ex);
        print(st);
        startGame(this, null);
      });
    }
    else startGame(this, null);
  }

  /**
   * == start game ==
   *
   *   * Hide the logo
   *   * Using game configuration
   *   * Start a game instance
   */
  void startGame(listener, device) {

    Dilithium.using("packages/alienzone/res")
    .then((config) {


      config.preferences = translatePreferences(config);
      HttpRequest.getString("packages/alienzone/res/${config.preferences['template']}")
      .then((String template) {

        querySelector('#logo').style.display = 'none';
        querySelector('body').style.backgroundColor = 'black';
        new Game(config, new Li2Template(template), device);
      });
    });

  }

  /**
   *  translate the preferences strings
   */
  translatePreferences(config) {

    List categories = [];
    for (var c in config.preferences['categories']) {
      List preferences = [];
      for (var p in c['preferences']) {
        var p1 = {};
        p1['key'] = config.xlate(p['key']);
        p1['type'] = config.xlate(p['type']);
        p1['title'] = config.xlate(p['title']);
        p1['summary'] = config.xlate(p['summary']);
        p1['defaultValue'] = config.xlate(p['defaultValue']);
        if (p1['type'] == 'ListPreference') {
          p1['entries'] = config.xlate(p['entries']);
          p1['entryValues'] = config.xlate(p['entryValues']);
        }
        preferences.add(p1);
      }
      categories.add({'title': config.xlate(c['title']), 'preferences': preferences});
    }
    return {
        'template':     config.preferences['template'],
        'title':        config.xlate(config.preferences['title']),
        'categories':   categories
    };
  }
}