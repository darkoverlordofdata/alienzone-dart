loading = {
     init: function() {
          game.log();
     },

     preload: function(){
          game.load.image("blackfade","assets/sprites/blackfade.png");
          game.load.spritesheet("snowflakes", "assets/sprites/snowflakes.png", 17, 17);
          game.load.spritesheet("snowflakes_large", "assets/sprites/snowflakes_large.png", 64, 64);
	},
  	create: function(){
		game.state.start("GameTitle");
	}
};