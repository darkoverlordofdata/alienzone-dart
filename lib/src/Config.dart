/*+--------------------------------------------------------------------+
#| Config.dart
#+--------------------------------------------------------------------+
#| Copyright DarkOverlordOfData (c) 2014
#+--------------------------------------------------------------------+
#|
#| This file is a part of alienzone
#|
#| alienzone is free software; you can copy, modify, and distribute
#| it under the terms of the MIT License
#|
#+--------------------------------------------------------------------+
#
# Load the game assets
*/
part of alienzed;

class Config {


  String name = "name";
  String creditsText = "";
  String copyrightText = "Copyright 2014 Dark Overlord of Data";


  int minWidth = 320;
  int minHeight = 480;
  int maxWidth = 640;
  int maxHeight = 960;
  bool pageAlignHorizontally = true;
  bool pageAlignVertically = true;
  bool forceOrientation = false;

  String splashKey = 'splashScreen';
  String splashImg = '';

  bool showPreloadBar = false;
  String preloadBarKey = 'preloadBar';
  String preloadBarImg = '';
  String preloadBgdKey = 'preloadBgd';
  String preloadBgdImg = '';

  var images = {};
  var sprites = {};
  var levels = {};

  String source;
  cordova.Device device;

  Config(String this.source, cordova.Device this.device) {

    print("Class Config initialized");

    var raw = loadYaml(source);

    this
      ..name = raw['name']
      ..minWidth = raw['minWidth']
      ..minHeight = raw['minHeight']
      ..maxWidth = raw['maxWidth']
      ..maxHeight = raw['maxHeight']
      ..pageAlignHorizontally = raw['pageAlignHorizontally']
      ..pageAlignVertically = raw['pageAlignVertically']
      ..forceOrientation = raw['forceOrientation']
      ..splashKey = raw['splashKey']
      ..splashImg = raw['splashImg']
      ..showPreloadBar = raw['showPreloadBar']
      ..preloadBarKey = raw['preloadBarKey']
      ..preloadBarImg = raw['preloadBarImg']
      ..preloadBgdKey = raw['preloadBgdKey']
      ..preloadBgdImg = raw['preloadBgdImg']
      ..images = raw['images']
      ..sprites = raw['sprites']
      ..levels = raw['levels']
      ..creditsText = raw['creditsText']
      ..copyrightText = raw['copyrightText'];

  }

}
