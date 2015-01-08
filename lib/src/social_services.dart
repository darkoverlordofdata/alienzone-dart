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
 */
part of alienzone;

abstract class SocialServicesListener {

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

class SocialServices {

  static const STATE_IDLE                 = 0;
  static const STATE_CREATING_MATCH       = 1;
  static const STATE_WAITING_FOR_PLAYERS  = 2;
  static const STATE_PLAYING              = 3;
  static const STATE_SCORES               = 4;

  bool isMultiplayerGame = false;
  bool nativeAvailable = false;
  bool usingGameCenter = false;
  bool usingGooglePlayGames = false;
  bool waitingLogin = false;

  String leaderboardId = '';
  var listener;

  JsObject multiplayerService;
  JsObject socialService;
  List<JsObject> loopbackServices;
  List<JsObject> players;

  SocialServices(this.leaderboardId, this.listener) {


    JsObject gc = context['Cocoon']['Social']['GameCenter'];
    JsObject gp = context['Cocoon']['Social']['GooglePlayGames'];
    JsFunction LoopbackService = context['Cocoon']['Multiplayer']['LoopbackService'];

    if (gc['nativeAvailable']) {
      multiplayerService = gc.callMethod('getMultiplayerInterface', []);
      socialService = gc.callMethod('getSocialInterface', []);
      usingGameCenter = true;
      usingGooglePlayGames = false;
      nativeAvailable = true;

    } else if (gp['nativeAvailable']) {
      gp.callMethod('init', [new JsObject.jsify({'defaultLeaderboard': leaderboardId})]);
      multiplayerService = gp.callMethod('getMultiplayerInterface');
      socialService = gp.callMethod('getSocialInterface');
      usingGameCenter = false;
      usingGooglePlayGames = true;
      nativeAvailable = true;

    } else {
      usingGameCenter = false;
      usingGooglePlayGames = false;
      nativeAvailable = false;
    }

    loopbackServices = [new JsObject(LoopbackService, []), new JsObject(LoopbackService, [])];

    if (multiplayerService != null) {

      multiplayerService.callMethod('on', ['invitation', new JsObject.jsify({

          'received': () {
            if (DEBUG) print("Invitation received");
            listener.received(this);

          },

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

  isSocial() {
    return (socialService != null && socialService.callMethod('isLoggedIn'));
  }

  isLocalPlayerTurn(index) {
    return !!players[index]['match'];
  }

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
    listener.found(match);

    requestPlayersCallback(JsObject players, JsObject error) {
      if (error != null) {
        listener.error("requestPlayersInfo: ${error['message']}");
        return;
      }
      listener.init(players, isMultiplayerGame ? [multiplayerService] : loopbackServices);
      match.callMethod('start');
    }

    match.callMethod('on', ['match', new JsObject.jsify({

        'dataReceived': (match, data, playerID) {
          listener.dataReceived(match, data, playerID);
        },

        'stateChanged': (match, player, state) {
          listener.stateChanged(match, player, state);
        },

        'connectionWithPlayerFailed': (match, player, error) {
          listener.connectionWithPlayerFailed(match, player, error);
        },

        'failed': (match, error) {
          listener.failed(match, error);
        }
    })]);

    if (match.callMethod('getExpectedPlayerCount') == 0) {
      match.callMethod('requestPlayersInfo', [requestPlayersCallback]);
    }
  }

  loginSocialService(bool autoLogin) {
    window.alert('loginSocialService');
    if (socialService == null) return;

    if (!waitingLogin) {
      waitingLogin = true;
      socialService.callMethod('login', [(loggedIn, error){
        if (!loggedIn || error != null) {
          if (!autoLogin && error['code'] == 2 && usingGameCenter) {
            context['Cocoon']['Dialog'].callMethod('confirm', [new JsObject.jsify({
                'title': "Game Center Disabled",
                'message': "Sign in with the Game Center application to enable it",
                'confirmText': "Ok",
                'cancelText': "Cancel"}),

              (accepted) {
                if(accepted) context['Cocoon']['App'].callMethod('openURL', "gamecenter:");
              }
            ]);
          }
        }
        waitingLogin = false;
      }]);
    }
  }

  createMatch(bool multi, players, tokens) {

    JsObject request = new JsObject(context['Cocoon']['Multiplayer']['MatchRequest'], [players, tokens]);
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

  cancelMatch() {
    if (isMultiplayerGame) {
      multiplayerService.callMethod('cancelAutoMatch');
    } else {
      loopbackServices[0].callMethod('cancelAutoMatch');
      loopbackServices[1].callMethod('cancelAutoMatch');
    }
  }


  showLeaderboard() {
    if (isSocial()) {
      socialService.callMethod('showLeaderboard');
      return true;
    } else {
      return false;
    }
  }


  disconnect(bool sendMessage) {
    players.forEach((player) {
      JsObject match = player['match'];
      if (match != null && sendMessage) {
        match.callMethod('sendDataToAllPlayers', ['exit']);
        match.callMethod('disconnect');
      }
    });
  }


  submitScore(value) {
    if (isSocial()) {
      socialService.callMethod('submitScore', [(error) {
        if (error != null) {
          listener.error("Error submitting score: ${error['message']}");
        }
      }]);
    }
  }

  send(index, message) {
    players[index]['match'].callMethod('sendDataToAllPlayers', [message]);
  }
}