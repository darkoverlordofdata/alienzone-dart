gameTitle = {
	init: function() {
          game.log();
     },
  	create: function(){

          backSnow = game.add.emitter(320, -32, 600);
          backSnow.makeParticles("snowflakes", [0, 1, 2, 3, 4, 5]);
          backSnow.maxParticleScale = 0.6;
          backSnow.minParticleScale = 0.2;
          backSnow.setYSpeed(20, 100);
          backSnow.setXSpeed(-15, 15);
          backSnow.gravity = 0;
          backSnow.width = 960;
          backSnow.minRotation = 0;
          backSnow.maxRotation = 40;
          backSnow.start(false, 14000, 20);

          frontSnow = game.add.emitter(320, -32, 50);
          frontSnow.makeParticles("snowflakes_large", [0, 1, 2, 3, 4, 5]);
          frontSnow.maxParticleScale = 0.75;
          frontSnow.minParticleScale = 0.5;
          frontSnow.setYSpeed(50, 150);
          frontSnow.setXSpeed(-20, 20);
          frontSnow.gravity = 0;
          frontSnow.width = 960;
          frontSnow.minRotation = 0;
          frontSnow.maxRotation = 40;
          frontSnow.start(false, 14000, 1000);
		//

	}
};