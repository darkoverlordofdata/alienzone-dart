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

  Game alienZone;
  Li2Config config;
  Li2Template template;
  JsObject _prefs = null;
  var preferences = {};
  List subcriptions = [];

  /**
   * Preferences use HTML ui
   * Persist preferences using the cordova plugin
   * If not available, fallback to browser localStorage
   */
  Preferences(this.config, this.template) {
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
      if (context['plugins'] != null)_prefs = context['plugins']['appPreferences'];

      /**
       *  Load the preferences:
       *  1. First check cordova preferences plugin
       *  2. TODO: Next check for chrome storage.
       *  3. Fallback to localStorage when there is nothing else
       */
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
      if (_prefs == null) {
        window.localStorage[id] = setPreference(id, "$onOff", "localStorage");
      } else {
        _prefs.callMethod('store', [
            (value) => (setPreference(id, "$onOff", "appPreferences")),
            (error) => (print("Unable to save $id")),
            id, "$onOff"]);
      }
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

