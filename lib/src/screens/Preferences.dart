/**
 *--------------------------------------------------------------------+
 * Preferences.dart
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

class Preferences extends Li2State {

  Li2Config config;
  Li2Template template;

  /**
   * Preferences use HTML ui
   */
  Preferences(this.config, this.template) {
    print('Preferences Class initialized');
  }

  create() {

    querySelector(config.preferences['id'])
      ..setInnerHtml(template.render(config.preferences))
      ..style.display = 'inline';

  }
}

