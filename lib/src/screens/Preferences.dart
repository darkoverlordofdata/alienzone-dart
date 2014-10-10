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
  JsObject _prefs = null;
  var preferences = {};

  /**
   * Preferences use HTML ui
   */
  Preferences(this.config, this.template) {
    print('Preferences Class initialized');

    /**
     * make sure that booleans are type bool
     */
    xform(value) {
      switch(value) {
        case 'true':  return true;
        case 'false': return false;
        default:      return value;
      }
    }
    if (context['plugins'] != null)_prefs = context['plugins']['appPreferences'];

    // get the saved preferences
    for (var category in config.preferences['categories']) {
      category['preferences'].forEach((preference) {
        String key = preference['key'];
        preferences[key] = preference;

        if (_prefs == null) {
          preference['value'] = window.localStorage[key] != null
          ? xform(window.localStorage[key])
          : preference['defaultValue'];
        } else {
          _prefs.callMethod('fetch', [
                  (value) => (preference['value'] = xform(value)),
                  (error) => (preference['value'] = preference['defaultValue']),
              key]);
        }
      });
    }
  }

  /**
   * Start
   */
  create() {

    querySelector(config.preferences['id'])
      ..setInnerHtml(template.render(config.preferences))
      ..style.display = 'inline';

    querySelector('.holo-action-bar').on['click'].listen((event){
      querySelector(config.preferences['id'])
        ..style.display = 'none';
      state.start(config.menu);
    });

    querySelector('.holo-action-bar').on['touchstart'].listen((event){
      querySelector(config.preferences['id'])
        ..style.display = 'none';
      state.start(config.menu);
    });

    preferences.forEach((key, preference) {
      querySelector("#$key").on['change'].listen((event) {
        var value;
        String key = event.target.id;
        switch(event.target.type) {
          case 'checkbox':
            value = event.target.checked;
            break;
          case 'select-one':
            value = event.target.value;
            break;
          default:
            value = "";
        }
        if (_prefs == null) {
          window.localStorage[event.target.id] = "$value";
        } else {
          _prefs.callMethod('store', [
                  (value) => (preference['value'] = value),
                  (error) => (print("Unable to save $key")),
              key, value]);
        }
      });
    });
  }
}

