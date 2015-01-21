var game = new Phaser.Game(640, 960, Phaser.CANVAS, "");

game.log = function(){
	console.log("%c  Running "+game.state.getCurrentState().state.current+" state  ","color:white;background:red");
};

game.state.add("Boot", boot);
game.state.add("Loading", loading);
game.state.add("GameTitle", gameTitle);
game.state.start("Boot");