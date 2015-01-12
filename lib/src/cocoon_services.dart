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

  connectionWithPlayerFailed(match, player, error);
  dataReceived(match, data, playerID);
  error(error);
  failed(match, error);
  found(match);
  init(players, services);
  loaded(object, match, error);
  loginStatusChanged(object, value, error);
  received(object);
  requestScore(object, value, error);
  stateChanged(match, player, state);

}

class CocoonServices {

  static const STATE_IDLE                 = 0;
  static const STATE_CREATING_MATCH       = 1;
  static const STATE_WAITING_FOR_PLAYERS  = 2;
  static const STATE_PLAYING              = 3;
  static const STATE_SCORES               = 4;

  static const LOCAL_USER                 = "d16a";

  bool isMultiplayerGame = false;
  bool nativeAvailable = false;
  bool usingGameCenter = false;
  bool usingGooglePlayGames = false;
  bool waitingLogin = false;
  bool loggedIn = false;
  bool dataAvailable = false;

  String userID = '';
  String userName = '';
  String userImage = '';
  String leaderboardId = '';
  var leaderboards;
  var achievements;
  String lastUrl = '';
  var listener;

  JsObject multiplayerService;
  JsObject socialService;
  List<JsObject> loopbackServices;
  List<JsObject> players;

  JsObject App;
  JsObject Dialog;
  JsObject Multiplayer;
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
    Multiplayer = context['Cocoon']['Multiplayer'];
    Social = context['Cocoon']['Social'];


    JsObject gc = Social['GameCenter'];
    JsObject gp = Social['GooglePlayGames'];

    /**
     * Connect to the Cocoon Native Game Service
     */
    if (gc['nativeAvailable']) {
      multiplayerService = gc.callMethod('getMultiplayerInterface');
      socialService = gc.callMethod('getSocialInterface');
      usingGameCenter = true;
      usingGooglePlayGames = false;
      nativeAvailable = true;

    } else if (gp['nativeAvailable']) {
      gp.callMethod('init', [new JsObject.jsify({'defaultLeaderboard': config.extra['DEFAULT_LEADERBOARD']['id']})]);
      multiplayerService = gp.callMethod('getMultiplayerInterface');
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

    loopbackServices = [new JsObject(Multiplayer['LoopbackService']), new JsObject(Multiplayer['LoopbackService'])];

    if (multiplayerService != null) {

      multiplayerService.callMethod('on', ['invitation', new JsObject.jsify({

          /**
           * received calllback
           */
          'received': () {
            if (DEBUG) print("Invitation received");
            listener.received(this);

          },

          /**
           * loaded callback
           *
           * @param match
           * @param error
           */
          'loaded': (match, error) {
            if (DEBUG) print("Invitation ready: (Error: + ${error['message']}");
            listener.loaded(this, match, error);
            handleMatch(match, error);

          }
      })]);
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
    loginSocialService(true);
  }

  /**
   * Are we using Social Service
   */
  isSocial() {
    return (socialService != null && socialService.callMethod('isLoggedIn'));
  }

  /**
   * Is it the local player turn
   *
   * @param index
   * @returns {boolean}
   */
  isLocalPlayerTurn(index) {
    return !!players[index]['match'];
  }

  /**
   * Get the player index
   *
   * @param index
   * @returns {userName|*|Cocoon.Social.User.userName|Cocoon.Social.Score.userName|Cocoon.Social.GameCenter.Score.userName|Cocoon.Multiplayer.PlayerInfo.userName}
   */
  getPlayerAlias(index) {
    return players[index]['userName'];
  }


  /**
   * Initialize a match
   *
   * @param players
   * @param services
   * @param firstTurn
   * @param firstPlayerTokens
   */
  init(JsArray players, JsArray services, firstTurn, firstPlayerTokens) {

    this.players = [];
    // make a copy
    players.forEach((player) => this.players.add(player));
    // and order players by ID to sync multiplayer turn order
    this.players.sort((a, b) => (a['userID'] < b['userID'] ? -1 : 1));

    // Get each players match object
    this.players.forEach((JsObject player) {
      player['match'] = null;
      services.forEach((JsObject service) {
        JsObject match = service.callMethod('getMatch');
        if (match.callMethod('getLocalPlayerID') == player['userID']) {
          player['match'] = match;
        }
      });
    });
    JsObject match = this.players[0]['match'];
    if (match != null) {
      match.callMethod('sendDataToAllPlayers', [JSON.encode(["turn", firstTurn, firstPlayerTokens])]);
    }
  }

  /**
   * Handle Match callbacks
   *
   * @param match
   * @param error
   */
  handleMatch(JsObject match, JsObject error) {

    if (match == null) {
      listener.error((error != null) ? error['message'] : "match canceled");
      return;
    }
    if (DEBUG) print("match found");
    listener.found(match);

    requestPlayersCallback(JsObject players, JsObject error) {
      if (error != null) {
        if (DEBUG) print("requestPlayersInfo: ${error['message']}");
        listener.error("requestPlayersInfo: ${error['message']}");
        return;
      }
      if (DEBUG) print("Received players info: " + JSON.encode(players));
      listener.init(players, isMultiplayerGame ? [multiplayerService] : loopbackServices);
      match.callMethod('start');
    }

    match.callMethod('on', ['match', new JsObject.jsify({

        /**
         * dataReceived callback
         *
         * @param match
         * @param data
         * @param playerID
         */
        'dataReceived': (match, data, playerID) {
          if (DEBUG) print("received Data: $data from Player: $playerID");
          listener.dataReceived(match, data, playerID);
        },

        /**
         * stateChanged callback
         *
         * @param match
         * @param player
         * @param state
         */
        'stateChanged': (match, player, state) {
          if (DEBUG) print("onMatchStateChanged: $player $state");
          listener.stateChanged(match, player, state);
        },

        /**
         * connectionWithPlayerFailed callback
         *
         * @param match
         * @param player
         * @param error
         */
        'connectionWithPlayerFailed': (match, player, error) {
          if (DEBUG) print("onMatchConnectionWithPlayerFailed: $player $error");
          listener.connectionWithPlayerFailed(match, player, error);
        },

        /**
         * failed callback
         *
         * @param match
         * @param error
         */
        'failed': (match, error) {
          if (DEBUG) print("onMatchFailed $error");
          listener.failed(match, error);
        }
    })]);

    if (match.callMethod('getExpectedPlayerCount') == 0) {
      match.callMethod('requestPlayersInfo', [requestPlayersCallback]);
    }
  }

  loginLocal(bool autoLogin) {

  }
  /**
   * Login to Social Service
   *
   * @param autoLogin
   */
  loginSocialService(bool autoLogin) {

    int count = 0;

    if (socialService == null) return loginLocal(autoLogin);

    if (!waitingLogin) {
      waitingLogin = true;
      socialService.callMethod('login', [(loggedIn, error){
        if (!loggedIn || error != null) {
          if (!autoLogin && error['code'] == 2 && usingGameCenter) {
            Dialog.callMethod('confirm', [
                new JsObject.jsify({
                  'title':        "Game Center Disabled",
                  'message':      "Sign in with the Game Center application to enable it",
                  'confirmText':  "Ok",
                  'cancelText':   "Cancel" }),

                (accepted) {
                  if(accepted) App.callMethod('openURL', ["gamecenter:"]);
                }
            ]);
          }
        } else {
        }

        // get user info
        socialService.callMethod('requestUser', [(user, error) {
          if (error == null) {
            loggedIn = true;
            waitingLogin = false;
            userID = user['userID'];
            userName = user['userName'];
            userImage = user['userImage'];
            count++;
            if (count > 1) dataAvailable = true;

          } else {
            window.alert(error['message']);
          }
        }]);

        // get achievement info
        socialService.callMethod('requestAllAchievements', [(a, error){
          if (error == null) {
            achievements = [];
            a.forEach((achievement) {
              achievements.add({
                  'achievementID':  achievement['achievementID'],
                  'customID':       achievement['customID'],
                  'title':          achievement['title'],
                  'description':    achievement['description'],
                  'imageURL':       achievement['imageURL']
              });
            });
            count++;
            if (count > 1) dataAvailable = true;

          } else {
            window.alert(error['message']);
          }
        }]);

      }]);
    }
  }

  /**
   * Create a Match
   *
   * @param multi
   * @param players
   * @param tokens
   */
  createMatch(bool multi, players, tokens) {

    JsObject request = new JsObject(Multiplayer['MatchRequest'], [players, tokens]);
    isMultiplayerGame = multi;
    if (isMultiplayerGame) {

      if (multiplayerService == null) {
        listener.error("Multiplayer is not supported on this device");
        return;
      }

      if (!socialService.callMethod('isLoggedIn')) {
        loginSocialService(false);
      } else {
        multiplayerService.callMethod('findMatch', [request, handleMatch]);
      }

    } else {

      loopbackServices[0].callMethod('findAutoMatch', [request, handleMatch]);
      loopbackServices[1].callMethod('findAutoMatch', [request, (){}]); //only listen to the first loopback service delegate

    }
  }

  /**
   * Cancel a Match
   */
  cancelMatch() {
    if (isMultiplayerGame) {
      multiplayerService.callMethod('cancelAutoMatch');
    } else {
      loopbackServices[0].callMethod('cancelAutoMatch');
      loopbackServices[1].callMethod('cancelAutoMatch');
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
   * Disconnect
   *
   * @param sendMessage
   * @returns {boolean}
   */
  disconnect(bool sendMessage) {
    players.forEach((player) {
      JsObject match = player['match'];
      if (match != null && sendMessage) {
        match.callMethod('sendDataToAllPlayers', ['exit']);
        match.callMethod('disconnect');
      }
    });
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

        socialService.callMethod('submitScore', [(error) {
          if (error != null) {
            if (DEBUG) print("Error: ${error['message']}");
            cacheScore(userID, value, this.leaderboardId);
          } else {
            if (DEBUG) print("Score submitted!");
          }
        }]);

      } else {

        socialService.callMethod('submitScore', [(error) {
          if (error != null) {
            if (DEBUG) print("Error: ${error['message']}");
            cacheScore(userID, value, leaderboardId);
          } else {
            if (DEBUG) print("Score submitted!");
          }
        }, new JsObject.jsify({
            'leaderboardID': leaderboardId
        })]);
      }
    } else {
      cacheScore(LOCAL_USER, value, leaderboardId);
    }
  }

  /**
   * Cache Score
   *
   * cache score in local storage if we're not logged in
   *
   * @param value
   * @param leaderboardId
   */
  cacheScore(String userID, num value, String leaderboardId) {
    var cache = JSON.decode(window.localStorage["${Context.PFX}_leaderboards"]);
    if (cache == null) cache = {};
    if (cache[userID] == null) cache[userID] = {};
    cache[userID][leaderboardId] = value;
    window.localStorage["${Context.PFX}_leaderboards"] = JSON.encode(cache);

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
          cacheAchievements(userID, achievementID);
        } else {
          if (DEBUG) print("Achievement submitted!");
        }
      }]);
    } else {
      cacheAchievements(LOCAL_USER, achievementID);
    }
  }

  /**
   * Cache Achievements
   *
   * cache achievement in local storage if we're not logged in
   *
   * @param value
   */
  cacheAchievements(String userID, String achievementID) {
    var cache = JSON.decode(window.localStorage["${Context.PFX}_achievements"]);
    if (cache == null) cache = {};
    if (cache[userID] == null) cache[userID] = {};
    cache[userID][achievementID] = true;
    window.localStorage["${Context.PFX}_achievements"] = JSON.encode(cache);
  }

  /**
   * Send Message
   *
   * @param index
   * @param message
   */
  send(int index, String message) {
    players[index]['match'].callMethod('sendDataToAllPlayers', [message]);
  }

  /**
   * Show Web View
   *
   * @param url
   * @param top
   * @param left
   * @param height
   * @param width
   */
  showWebView(String url, [int top=0, int left=0, num width=0, num height=0]) {

    if (!dataAvailable) {
      window.alert("Data not ready. Try again.");
      return;
    }

    width = (width == 0) ? window.innerWidth * window.devicePixelRatio : width;
    height = (height == 0) ? window.innerHeight * window.devicePixelRatio : height;

    var payload = {
        'user': {
            'userName': userName,
            'userImage': userImage,
        },
        'leaderboards': [config.extra['DEFAULT_LEADERBOARD']],
        'achievements': achievements
    };

    String injection = "injectData('${JSON.encode(payload)}');";

    if (lastUrl == url) {
      App.callMethod('showTheWebView', [top, left, width, height]);
      App.callMethod('forwardAsync', [injection]);

    } else {

      App['WebView'].callMethod('on', ['load', new JsObject.jsify({
          'success': () {
            lastUrl = url;
            App.callMethod('showTheWebView', [top, left, width, height]);
            App.callMethod('forwardAsync', [injection]);
          },
          'error': () {
            window.alert("Unable to load the webview");
          }
      })]);
      App.callMethod('loadInTheWebView', [url]);
    }

  }
}