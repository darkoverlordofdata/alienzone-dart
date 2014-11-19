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
import 'dart:async' as async;

import 'package:dartemis/dartemis.dart';
import 'package:play_phaser/phaser.dart' as Phaser;
import 'package:play_phaser/arcade.dart' as Arcade;
import "package:dilithium/dilithium.dart";
import 'package:match3/match3.dart';

part 'src/AlienZoneApplication.dart';
//part 'src/Game.dart';
part 'src/classes/Gem.dart';
part 'src/classes/GemGroup.dart';

/**
 * Game States
 */
part 'src/states/Preferences.dart';
part 'src/states/Menu.dart';
part 'src/states/Credits.dart';
part 'src/states/Scores.dart';
part 'src/states/Levels.dart';
part 'src/states/GameOver.dart';

part 'src/states/demo.dart';
part 'src/context.dart';

part 'src/abstract_entity.dart';
part 'src/entity_factory.dart';
part 'src/game.dart';
/**
 * Components
 */
part 'src/components/animation.dart';
part 'src/components/bounce.dart';
part 'src/components/count.dart';
part 'src/components/gravity.dart';
part 'src/components/immovable.dart';
part 'src/components/position.dart';
part 'src/components/scale.dart';
part 'src/components/text.dart';
part 'src/components/sprite.dart';
part 'src/components/velocity.dart';
/**
 * Entities
 */
part 'src/entities/background_entity.dart';
part 'src/entities/platform_entity.dart';
part 'src/entities/player_entity.dart';
part 'src/entities/score_entity.dart';
part 'src/entities/star_entity.dart';
/**
 * Systems
 */
part 'src/systems/arcade_physics_system.dart';
part 'src/systems/background_render_system.dart';
part 'src/systems/platform_render_system.dart';
part 'src/systems/player_control_system.dart';
part 'src/systems/score_render_system.dart';
part 'src/systems/stars_render_system.dart';


