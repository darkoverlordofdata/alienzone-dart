/**
 *--------------------------------------------------------------------+
 * game_services.dart
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

abstract class AbstractGameModel {

  int state = GameServices.STATE_IDLE;
  int score = 0;
  bool isTurnBasedGame = false;
  bool isMultiplayerGame = false;

  init(players, services);
  exit();
  tokenMessageReceived(row,col,playerID);
  firstTurnMessageReceived(firstTurn, firstPlayertokens);

}

class GameServices {

  static const STATE_IDLE                 = 0;
  static const STATE_CREATING_MATCH       = 1;
  static const STATE_WAITING_FOR_PLAYERS  = 2;
  static const STATE_PLAYING              = 3;
  static const STATE_SCORES               = 4;


  JsObject services;
  AbstractGameModel model;

  GameServices(String leaderboardId, this.model) {
    print("Class GameServices Initialized");
    services = new JsObject(context['GameServices'], [leaderboardId, invoke]);
  }

  start(players, services, firstTurn, firstPlayerTokens) {
    this.services.callMethod('init', [players, services, firstTurn, firstPlayerTokens]);
  }


  waitingLogin() {
    return services['waitingLogin'];
  }

  isLocalPlayerTurn(index) {
    return services.callMethod('isLocalPlayerTurn', [index]);
  }

  getPlayerAlias(index) {
    return services.callMethod('getPlayerAlias', [index]);
  }

  send(index, message) {
    services.callMethod('send', [index, message]);
  }

  isSocial() {
    return services.callMethod('isSocial', []);
  }

  submitScore(value) {
    services.callMethod('submitScore', [value]);
  }

  createMatch(multi, players, tokens) {
    services.callMethod('createMatch', [multi, players, tokens]);
  }

  cancelMatch() {
    services.callMethod('cancelMatch', []);
  }

  disconnect(sendMessage) {
    model.state = STATE_IDLE;
    services.callMethod('disconnect', [sendMessage]);
  }

  showLeaderboard() {
    return services.callMethod('showLeaderboard', []);
  }

  invoke(String methodName, List args) {
    switch (methodName) {
      case 'connectionWithPlayerFailed':  return Function.apply(connectionWithPlayerFailed, args);
      case 'dataReceived':                return Function.apply(dataReceived, args);
      case 'error':                       return Function.apply(error, args);
      case 'failed':                      return Function.apply(failed, args);
      case 'found':                       return Function.apply(found, args);
      case 'init':                        return Function.apply(init, args);
      case 'loaded':                      return Function.apply(loaded, args);
      case 'loginStatusChanged':          return Function.apply(loginStatusChanged, args);
      case 'received':                    return Function.apply(received, args);
      case 'requestScore':                return Function.apply(requestScore, args);
      case 'stateChanged':                return Function.apply(stateChanged, args);
      default: throw new Exception("Invalid method name: $methodName");
    }
  }

  received(object, match, error) {
    if (model.state != STATE_IDLE) {
      model.exit();
    }
    model.state = STATE_CREATING_MATCH;
  }

  loaded(object, match, error) {
    model.isMultiplayerGame = true;
  }

  loginStatusChanged(object, value, error) {
//    services['socialService'].callMethod('requestUser', [
//    (user, error) {
//      window.alert("User: ${user['userName']}");
//    }]);
    services['socialService'].callMethod('requestAllAchievements', [
    (achievments, error) {
      String s = '';
      achievments.forEach((a) {

        s += "${a['achievementID']}: ${a['imageURL']}\n";

      });
    }]);
  }

  requestScore(object, value, error) {

      if (error != null) {
        print("Error getting user score: " + error['message']);
      } else if (value != null) {
        print("score: " + value['score']);
        model.score = value['score'];
      }
  }

  error(error) {
      model.state = STATE_IDLE;
  }

  found(match) {
    model.state = STATE_WAITING_FOR_PLAYERS;
  }

  init(players, services) {
      model.init(players, services);
  }

  dataReceived(match, data, playerID) {

      var message = JSON.decode(data);

      if (message[0] == "token") {
        model.tokenMessageReceived(message[1], message[2], playerID);
      } else if (message[0] == "exit" && model.state == STATE_PLAYING && model.isMultiplayerGame) {
        window.alert("Opponent disconnected");
        services.callMethod('disconnect', [false]);
      } else if (message[0] == "turn") {
          model.firstTurnMessageReceived(message[1],message[2]);
      }
  }

  stateChanged(match, player, state) {
      if (model.state == STATE_WAITING_FOR_PLAYERS)
        services.callMethod('requestPlayersInfo', [match]);
  }

  connectionWithPlayerFailed(match, player, error) {
      services.callMethod('disconnect', [false]);
  }

  failed(match, error) {
      services.callMethod('disconnect', [false]);
  }

}