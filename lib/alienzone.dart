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
import 'dart:js';
import 'dart:js' as js;
import 'dart:async' as async;
import 'dart:math' as Math;
import 'dart:convert';

import 'package:dartemis/dartemis.dart' as Artemis;
import 'package:play_phaser/phaser.dart' as Phaser;
import 'package:play_phaser/arcade.dart' as Arcade;
import "package:dilithium/dilithium.dart" as Li2;
import 'package:match3/match3.dart' as Match3;
import 'package:mt19937/mt19937.dart';

part 'src/alien_zone_application.dart';
part 'src/cocoon_services.dart';
part 'src/game.dart';
part 'src/game_model.dart';
part 'src/game_services.dart';
part 'src/gem.dart';


/**
 * Artemis:
 */
part 'src/engine/abstract_entity.dart';
part 'src/engine/base_level.dart';
part 'src/engine/context.dart';
part 'src/engine/entity_factory.dart';
part 'src/engine/system_factory.dart';
/**
 * Components
 */
part 'src/components/animation.dart';
part 'src/components/action.dart';
part 'src/components/bonus.dart';
part 'src/components/bounce.dart';
part 'src/components/count.dart';
part 'src/components/gravity.dart';
part 'src/components/immovable.dart';
part 'src/components/number.dart';
part 'src/components/opacity.dart';
part 'src/components/position.dart';
part 'src/components/scale.dart';
part 'src/components/state.dart';
part 'src/components/text.dart';
part 'src/components/sprite.dart';
part 'src/components/velocity.dart';
/**
 * Entities
 */
part 'src/entities/button_entity.dart';
part 'src/entities/gem_entity.dart';
part 'src/entities/image_entity.dart';
part 'src/entities/input_entity.dart';
part 'src/entities/legend_entity.dart';
part 'src/entities/option_entity.dart';
part 'src/entities/player_entity.dart';
part 'src/entities/score_entity.dart';
part 'src/entities/string_entity.dart';
/**
 * Systems
 */
//part 'src/systems/arcade_physics_system.dart';
part 'src/systems/button_render_system.dart';
part 'src/systems/legend_render_system.dart';
//part 'src/systems/gems_render_system.dart';
part 'src/systems/option_control_system.dart';
part 'src/systems/player_control_system.dart';
part 'src/systems/score_render_system.dart';
part 'src/systems/sprite_render_system.dart';
part 'src/systems/string_render_system.dart';

CocoonServices cocoon;

const DEBUG = false;
//const CLIENT_ID               = '889085837789-drspvmoknah1sf8kdojb09gf034c2b07.apps.googleusercontent.com';
//
//const DEFAULT_LEADERBOARD     = 'CgkI3YOVjfAZEAIQBg';
//const ACHIEVMENT_LEVEL1       = 'CgkI3YOVjfAZEAIQAQ';
//const ACHIEVMENT_LEVEL2       = 'CgkI3YOVjfAZEAIQAg';
//const ACHIEVMENT_LEVEL3       = 'CgkI3YOVjfAZEAIQAw';
//const ACHIEVMENT_LEVEL4       = 'CgkI3YOVjfAZEAIQBA';
//const ACHIEVMENT_LEVEL5       = 'CgkI3YOVjfAZEAIQBQ';
//
//Map<String,String> ACHIEVMENT_IDS = {
//    'ACHIEVMENT_LEVEL1': ACHIEVMENT_LEVEL1, // Combo
//    'ACHIEVMENT_LEVEL2': ACHIEVMENT_LEVEL2, // Cascading
//    'ACHIEVMENT_LEVEL3': ACHIEVMENT_LEVEL3, // Triple
//    'ACHIEVMENT_LEVEL4': ACHIEVMENT_LEVEL4, // Quad
//    'ACHIEVMENT_LEVEL5': ACHIEVMENT_LEVEL5  // Cascading Combo
//};
//
//Map<String,String> LEADERBOARD_IDS = {
//    'DEFAULT_LEADERBOARD': DEFAULT_LEADERBOARD
//};
//
//var LEADERBARDS = {
//  DEFAULT_LEADERBOARD: {
//      'id':   DEFAULT_LEADERBOARD,
//      'name': 'Alien Zone',
//      'url':  'https://lh4.ggpht.com/lx1MbVNJhwuFzw2HlavoORtSLflngcKQmUyahywjoApp-q3HHhUUvP86hV1P7HyYoXo=h150-rw'
//  }
//}
//
