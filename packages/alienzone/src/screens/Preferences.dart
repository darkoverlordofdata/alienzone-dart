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

  Game parent;
  Li2Config config;
  Li2Template template;
  var preferences = {};
  List subcriptions = [];

  /**
   * Preferences use HTML ui
   * If not available, fallback to browser localStorage
   */
  Preferences(this.parent, this.config, this.template) {
    print('Preferences Class initialized');
    //  Initialize holo css
    var holo = document.createElement('link');
    holo.setAttribute('rel', 'stylesheet');
    holo.setAttribute('href', 'packages/alienzone/res/preferences/holo.css');
    querySelector('head').append(holo);

    //  Initialize holo extra css
    var extra = document.createElement('link');
    extra.setAttribute('rel', 'stylesheet');
    extra.setAttribute('href', 'packages/alienzone/res/preferences/extra.css');
    querySelector('head').append(extra);
    loadPreferences();

  }

  /**
   * Load saved preferences
   */
  loadPreferences() {
    try {

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

      /**
       *  Load the preferences:
       *  1. TODO: Check for chrome storage.
       *  2. Fallback to localStorage when there is nothing else
       */
      for (var category in config.preferences['categories']) {
        category['preferences'].forEach((preference) {
          String key = preference['key'];
          preferences[key] = preference;
          preference['value'] = window.localStorage[key] != null
            ? xform(window.localStorage[key])
            : preference['defaultValue'];
          parent.setPreference(key, preference['value']);
        });
      }
    } catch (e) {
      print(e);
    }

  }
  /**
   * Save preference in local collection
   */
  setPreference(key, value, type) {

    preferences[key] = value;
    return value;
  }

  /**
   * Tear down and return to menu
   */
  cancelScreen(event) {
    querySelector(config.preferences['id'])
      ..style.display = 'none';
    subcriptions.forEach((subcription){
      subcription.cancel();
    });
    game.paused = false;
    state.start(config.menu);
  }

  /**
   * Click an on/off switch
   */
  onOffSwitch(event) {
    try {

      event.preventDefault();
      String id = event.target.getAttribute('for');
      var s = querySelector("#$id div");
      bool onOff = (s.innerHtml.length > 0);

      if (onOff) {
        //        s.setInnerHtml("");
        // force rendering in chrome webview
        var p = s.parent;
        s.remove();
        p.insertAdjacentHtml('afterBegin', '<div></div>');
      } else {
        //        s.setInnerHtml("OFF");
        // force rendering in chrome webview
        var p = s.parent;
        s.remove();
        p.insertAdjacentHtml('afterBegin', '<div>OFF</div>');
      }
      window.localStorage[id] = setPreference(id, "$onOff", "localStorage");
      parent.setPreference(id, onOff);
    } catch (e) {
      print(e);
    }
  }


  /**
   * Modify preferences via the ui
   * Persist changes
   */
  create() {

    game.paused = true;
    loadPreferences();
    querySelector(config.preferences['id'])
      ..setInnerHtml(template.render(config.preferences))
      ..style.display = 'block';

    subcriptions = [];
    subcriptions.add(querySelector('.holo-action-bar').onClick.listen(cancelScreen));
    subcriptions.add(querySelector('.holo-action-bar').onTouchStart.listen(cancelScreen));
    preferences.forEach((key, preference) {
      subcriptions.add(querySelector("#$key").onClick.listen(onOffSwitch));
      subcriptions.add(querySelector("#$key").onTouchStart.listen(onOffSwitch));
    });
  }
}

