/**
 *--------------------------------------------------------------------+
 * alien_zone_application.dart
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
   * == start game ==
   *
   *   * Hide the logo
   *   * Using game configuration
   *   * Start a game instance
   */
  AlienZoneApplication() {

    print("Class AlienZoneApplication Initialized");
    Li2.Dilithium.using("packages/alienzone/res").then((config) => new Game(config));

  }


  /**
   *  translate the preferences strings
   *
   * @param config  Li2.Config instance
   * @returns translated preference map
   *
   *  @usage:
   *
   *
   *    constructor() {
   *
   *      Dilithium.using("packages/name/res")
   *      .then((config) {
   *        config.preferences = translatePreferences(config);
   *        HttpRequest.getString(config.path + config.preferences['template'])
   *        .then((template) {
   *          new Game(config, new Li2Template(template));
   *        });
   *      });
   *    }
   *
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
        'id':           config.preferences['id'],
        'icon':         config.preferences['icon'],
        'template':     config.preferences['template'],
        'title':        config.xlate(config.preferences['title']),
        'categories':   categories
    };
  }
}