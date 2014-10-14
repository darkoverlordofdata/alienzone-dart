/*


       _____  .__  .__                __________
      /  _  \ |  | |__| ____   ____   \____    /____   ____   ____
     /  /_\  \|  | |  |/ __ \ /    \    /     //  _ \ /    \_/ __ \
    /    |    \  |_|  \  ___/|   |  \  /     /(  <_> )   |  \  ___/
    \____|__  /____/__|\___  >___|  / /_______ \____/|___|  /\___  >
            \/             \/     \/          \/          \/     \/


Copyright (c) 2014 Bruce Davidson <darkoverlordofdata@gmail.com>

This file is part of AlienZone.

AlienZone is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

AlienZone is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with AlienZone.  If not, see <http://www.gnu.org/licenses/>.
*/

library alienzone;

import 'dart:html';
import 'dart:math';
import 'dart:js';
import 'dart:async' as async;

import 'package:yaml/yaml.dart';
import 'package:rikulo_gap/device.dart' as cordova;
import 'package:play_phaser/phaser.dart';
import "package:dilithium/dilithium.dart";
import 'package:match3/match3.dart';

part 'src/AlienZoneApplication.dart';
part 'src/Game.dart';
part 'src/classes/Gem.dart';
part 'src/classes/GemGroup.dart';
part 'src/screens/Preferences.dart';
part 'src/screens/Menu.dart';
part 'src/screens/Credits.dart';
part 'src/screens/Scores.dart';
part 'src/screens/Levels.dart';
part 'src/screens/GameOver.dart';

