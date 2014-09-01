
part of alienzed;

class Hello extends State {

  preload() {

    game.load.image('logo', 'hellophaser/phaser.png');

  }

  create() {

    var logo = game.add.sprite(game.world.centerX, game.world.centerY, 'logo');
    logo.anchor.setTo(0.5, 0.5);

  }

}
