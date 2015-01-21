boot = {
     init: function() {
          game.log();
     },

     create: function() {
          game.scale.scaleMode = Phaser.ScaleManager.SHOW_ALL;
          game.scale.pageAlignHorizontally = true;
          game.scale.pageAlignVertically = true;
          game.scale.setScreenSize(true);
          game.physics.startSystem(Phaser.Physics.ARCADE);
          game.state.start("Loading");
     }
};