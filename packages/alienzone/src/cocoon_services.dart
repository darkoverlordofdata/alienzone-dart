/**
 *--------------------------------------------------------------------+
 * social_services.dart
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
 * CocoonJS Game Services Adapter
 *
 */
part of alienzone;

abstract class CocoonListener {

  loginStatusChanged(object, value, error);
  requestScore(object, value, error);

}

class CocoonServices {

  static const LOCAL_USER                 = "d16a";

  bool nativeAvailable = false;
  bool usingGameCenter = false;
  bool usingGooglePlayGames = false;
  bool waitingLogin = false;
  bool loggedIn = false;
  bool dataAvailable = false;

  CocoonListener listener;

  JsObject socialService;

  JsObject App;
  JsObject Dialog;
  JsObject Social;

  Li2.Config config;
  /**
   *
   * CocoonJS Game Services Adapter
   *
   * @param leaderboardId
   * @param listener
   *
   */
  CocoonServices(this.config, this.listener) {

    if (DEBUG) print("Class SocialServices Initialized");

    window.localStorage.forEach((key, value) {
      if (key.startsWith(Context.PFX)) {
        key = key.replaceAll("${Context.PFX}_", "");
        print("storage: $key = $value");
      }
    });

    App = context['Cocoon']['App'];
    Dialog = context['Cocoon']['Dialog'];
    Social = context['Cocoon']['Social'];

  }

  connect() {
    JsObject gc = Social['GameCenter'];
    JsObject gp = Social['GooglePlayGames'];

    /**
     * Connect to the Cocoon Native Game Service
     */
    if (gc['nativeAvailable']) {
      socialService = gc.callMethod('getSocialInterface');
      usingGameCenter = true;
      usingGooglePlayGames = false;
      nativeAvailable = true;

    } else if (gp['nativeAvailable']) {
      gp.callMethod('init', [new JsObject.jsify({'defaultLeaderboard': config.extra['leaderboards'][0]['id']})]);
      socialService = gp.callMethod('getSocialInterface');
      usingGameCenter = false;
      usingGooglePlayGames = true;
      nativeAvailable = true;

    } else {

      if (DEBUG) print("No Native Game Services Available");
      usingGameCenter = false;
      usingGooglePlayGames = false;
      nativeAvailable = false;
    }

    if (socialService != null) {

      socialService.callMethod('on', ['loginStatusChanged', (loggedIn, error) {

        listener.loginStatusChanged(this, loggedIn, error);

        if (loggedIn) {
          if (DEBUG) print("Logged into social service");
          socialService.callMethod('requestScore', [
              (score, error){
                listener.requestScore(this, score, error);
              }
          ]);
        }
      }]);
    }

    login(true, (loggedIn, error) {
    });
  }

  /**
   * Are we using Social Service
   */
  isSocial() {
    return (socialService != null && socialService.callMethod('isLoggedIn'));
  }

  logout() {
    socialService.callMethod('logout', [(error) {
      waitingLogin = false;
      loggedIn = false;
      dataAvailable = false;
    }]);
  }
  /**
   * Login to Social Service
   *
   * @param autoLogin
   */
  login([bool autoLogin = false, Function next]) {

    int count = 0;
    if (socialService != null) {

      socialService.callMethod('on', ['loginStatusChanged', (loggedIn, error) {

        listener.loginStatusChanged(this, loggedIn, error);

        if (loggedIn) {
          if (DEBUG) print("Logged into social service");
          socialService.callMethod('requestScore', [
                  (score, error){
                listener.requestScore(this, score, error);
              }
          ]);
        }
      }]);
    }

    if (socialService == null) {
      next(false, null);
      return;
    }

    if (!waitingLogin) {
      waitingLogin = true;
      socialService.callMethod('login', [(loggedIn, error){
        if (!loggedIn || error != null) {
          if (!autoLogin && error['code'] == 2 && usingGameCenter) {
            Dialog.callMethod('confirm', [
                new JsObject.jsify({
                    'title': "Game Center Disabled",
                    'message': "Sign in with the Game Center application to enable it",
                    'confirmText': "Ok",
                    'cancelText': "Cancel"
                }),
                    (accepted) {
                  if (accepted) App.callMethod('openURL', ["gamecenter:"]);
                }
            ]);
          } else {
            next(false, error);
            return;
          }
        }
        waitingLogin = false;
        this.loggedIn = true;
        next(true, null);
      }]);
    }
  }
  /**
   * Show Achievements
   *
   * @returns {boolean}
   */
  showAchievements() {
    if (DEBUG) print("Social: ${isSocial()}");
    if (isSocial()) {
      socialService.callMethod('showAchievements');
      return true;
    } else {
      return false;
    }
  }

  /**
   * Show Leaderboard
   *
   * @returns {boolean}
   */
  showLeaderboard() {
    if (DEBUG) print("Social: ${isSocial()}");
    if (isSocial()) {
      socialService.callMethod('showLeaderboard');
      return true;
    } else {
      return false;
    }
  }


  /**
   * Submit Score
   *
   * Submit score to game service
   *
   * @param value
   * @param leaderboardId
   */
  submitScore(num value, [String leaderboardId = '']) {
    if (isSocial()) {
      if (leaderboardId == '') {

        socialService.callMethod('submitScore', [value, (error) {
          if (error != null) {
            if (DEBUG) print("Error: ${error['message']}");
            _submitScore(leaderboardId, value);
          } else {
            if (DEBUG) print("Score submitted!");
          }
        }]);

      } else {

        socialService.callMethod('submitScore', [value, (error) {
          if (error != null) {
            if (DEBUG) print("Error: ${error['message']}");
            _submitScore(leaderboardId, value);
          } else {
            if (DEBUG) print("Score submitted!");
          }
        }, new JsObject.jsify({
            'leaderboardID': leaderboardId
        })]);
      }
    } else {
      _submitScore(leaderboardId, value);
    }
  }

  _submitScore(String leaderboardId, num value) {
    int score;
    try {
      score = int.parse(window.localStorage[leaderboardId]);
    } catch(e) {
      score = 0;
    }
    if (value > score) {
      window.localStorage[leaderboardId] = value.toString();
    }
  }

  /**
   * Submit Achievements
   *
   * Submit achievements to game service
   *
   * @param value
   */
  submitAchievements(String achievementID) {
    if (isSocial()) {
      socialService.callMethod('submitAchievements', [(error) {
        if (error != null) {
          if (DEBUG) print("Error: ${error['message']}");
          window.localStorage[achievementID] = 'true';
        } else {
          if (DEBUG) print("Achievement submitted!");
        }
      }]);
    } else {
      window.localStorage[achievementID] = 'true';
    }
  }



}