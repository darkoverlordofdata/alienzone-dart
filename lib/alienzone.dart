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
import 'dart:js' as js show context;
import 'dart:js' hide context;
import 'dart:async' as async;
import 'dart:math' as Math;
import 'dart:convert';

import 'package:dartemis/dartemis.dart' as Artemis;
import 'package:play_phaser/phaser.dart' as Phaser;
import "package:dilithium/dilithium.dart" as Li2;
import 'package:match3/match3.dart' as Match3;
import 'package:mt19937/mt19937.dart';

import 'package:alienzone/ui/game_ui.dart';
export 'package:polymer/init.dart';

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
part 'src/components/lock.dart';
part 'src/components/number.dart';
part 'src/components/opacity.dart';
part 'src/components/position.dart';
part 'src/components/scale.dart';
part 'src/components/state.dart';
part 'src/components/text.dart';
part 'src/components/time.dart';
part 'src/components/sprite.dart';
part 'src/components/user.dart';
part 'src/components/velocity.dart';
/**
 * Entities
 */
part 'src/entities/achievement_entity.dart';
part 'src/entities/button_entity.dart';
part 'src/entities/gem_entity.dart';
part 'src/entities/image_entity.dart';
part 'src/entities/input_entity.dart';
part 'src/entities/leader_entity.dart';
part 'src/entities/legend_entity.dart';
part 'src/entities/option_entity.dart';
part 'src/entities/player_entity.dart';
part 'src/entities/score_entity.dart';
part 'src/entities/string_entity.dart';
part 'src/entities/timer_entity.dart';
part 'src/entities/user_entity.dart';
/**
 * Systems
 */
part 'src/systems/achievement_render_system.dart';
part 'src/systems/button_render_system.dart';
part 'src/systems/leader_render_system.dart';
part 'src/systems/legend_render_system.dart';
part 'src/systems/option_control_system.dart';
part 'src/systems/play_games_system.dart';
part 'src/systems/player_control_system.dart';
part 'src/systems/score_render_system.dart';
part 'src/systems/sprite_render_system.dart';
part 'src/systems/string_render_system.dart';
part 'src/systems/timer_control_system.dart';


const DEBUG = false;

