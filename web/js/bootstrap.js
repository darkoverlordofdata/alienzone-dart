/**
 *--------------------------------------------------------------------+
 * bootstrap.js
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
var game = (function() {

    /**
     * bootstrap the game
     */

    var VERSION = '0.0.30',
        base = 'app/packages/alienzone/res/',
        sprite1 = 'star17',
        sprite2 = 'bucky',
        logo = 'd16a',
        //sprite2 = 'stars_large',
        width = 320,
        height = 512,
        game = {

            msg: [
                'Alien Zone',
                'Build '+VERSION,
                'copyright 2014 Dark Overlord of Data'
            ],
            logo: undefined,
            title: [],
            /**
             * Preload the images
             */
            preload: function() {

                this.load.spritesheet(sprite1, base + "images/" + sprite1 + ".png", 17, 17);
                this.load.spritesheet(sprite2, base + "images/" + sprite2 + ".png", 64, 64);
                this.load.image(logo, base + "images/" + logo + ".png");

            },

            /**
             * Configure the game engine
             * Create the game objects
             */
            create: function() {
                var line = '',
                    i = 0,
                    row = 400,
                    style = {
                        fill: '#fff',
                        font: '12pt opendyslexic'
                    };


                this.scale.scaleMode = Phaser.ScaleManager.EXACT_FIT;
                this.scale.pageAlignHorizontally = true;
                this.scale.pageAlignVertically = true;
                this.scale.setScreenSize(true);
                this.physics.startSystem(Phaser.Physics.ARCADE);

                this.logo = this.game.add.sprite(160, 240, logo);
                this.logo.anchor.setTo(0.5, 0.5);
                for (i=0; i<this.msg.length; i++) {
                    line = this.msg[i];
                    this.title.push(this.game.add.text(10, row, line, style));
                    row += 30;
                }
            },

            /**
             * clock tick...
             */
            update: function() {

            },

            onload: function() {
                var i = 0,
                    backStars = undefined,
                    frontStars = undefined,
                    title = undefined;

                //this.logo.destroy();
                this.game.add.tween(this.logo).to({alpha:0}, 1000, Phaser.Easing.Linear.None,true);

                for (i=0; i<this.title.length; i++) {
                    this.game.add.tween(this.title[i]).to({alpha:0}, 1000, Phaser.Easing.Linear.None,true);
                    //title = this.title[i];
                    //title.destroy();
                }

                /**
                 * background particles
                 */
                backStars = this.add.emitter(160, -32, 600);
                backStars.makeParticles(sprite1, [0]);
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
                frontStars = this.add.emitter(160, -32, 50);
                frontStars.makeParticles(sprite2, [0]);
                frontStars.maxParticleScale = 0.75;
                frontStars.minParticleScale = 0.5;
                frontStars.setYSpeed(50, 150);
                frontStars.setXSpeed(-20, 20);
                frontStars.gravity = 0;
                frontStars.width = width;
                frontStars.minRotation = 0;
                frontStars.maxRotation = 40;
                frontStars.start(false, 14000, 1000);

            }


        };

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

    new Phaser.Game(width, height, Phaser.CANVAS, '', game);
    return game;

})();

function game_onload() {
    try {
        game.onload();
    } catch (e) {
        console.log(e);
    }
}