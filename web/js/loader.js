/**
 *--------------------------------------------------------------------+
 * loader.js
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
(function() {

    var base = 'app/packages/alienzone/res/',
        sprite1 = 'stars',
        sprite2 = 'stars_large',
        width = 320,
        height = 512;
    /**
     * Create splash screen / background animations
     * @type {Game}
     */
    new Phaser.Game(width, height, Phaser.CANVAS, '', {

        /**
         * Preload the images
         */
        preload: function() {

            this.load.spritesheet(sprite1, base + "images/" + sprite1 + ".png", 17, 17);
            this.load.spritesheet(sprite2, base + "images/" + sprite2 + ".png", 64, 64);

        },

        /**
         * Configure the game engine
         * Create the game objects
         */
        create: function() {

            this.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT;
            this.scale.pageAlignHorizontally = true;
            this.scale.pageAlignVertically = true;
            this.scale.setScreenSize(true);
            this.physics.startSystem(Phaser.Physics.ARCADE);

            /**
             * background particles
             */
            var backStars = this.add.emitter(160, -32, 600);
            backStars.makeParticles(sprite1, [0, 1, 2, 3, 4, 5]);
            backStars.maxParticleScale = 0.6;
            backStars.minParticleScale = 0.2;
            backStars.setYSpeed(20, 100);
            backStars.setXSpeed(-15, 15);
            backStars.gravity = 0;
            backStars.width = width;
            backStars.minRotation = 0;
            backStars.maxRotation = 40;
            backStars.start(false, 14000, 200);

            /**
             * midground particles
             */
            var frontStars = this.add.emitter(160, -32, 50);
            frontStars.makeParticles(sprite2, [0, 1, 2, 3, 4, 5]);
            frontStars.maxParticleScale = 0.75;
            frontStars.minParticleScale = 0.5;
            frontStars.setYSpeed(50, 150);
            frontStars.setXSpeed(-20, 20);
            frontStars.gravity = 0;
            frontStars.width = width;
            frontStars.minRotation = 0;
            frontStars.maxRotation = 40;
            frontStars.start(false, 14000, 1000);
        },

        /**
         * clock tick...
         */
        update: function() {

        }
    });

    /**
     * Load the game
     */
    Cocoon.App.WebView.on('load', {
        success : function(){
            Cocoon.App.showTheWebView();
        },
        error : function(){
            console.log(JSON.stringify(arguments));
        }
    });
    Cocoon.App.loadInTheWebView("app/index.html");

})();
