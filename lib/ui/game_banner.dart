/**
 *--------------------------------------------------------------------+
 * game-banner.dart
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

import 'dart:html';
import 'package:polymer/polymer.dart';

@CustomTag('game-banner')
class GameBanner extends PolymerElement {

  @observable String copyright = '';
  @observable String title = '';
  @observable String build = '';

  GameBanner.created() : super.created();

  /**
   * Hide the Banner
   */
  void hide() {
    $["logo"].hidden = true;
  }
}
