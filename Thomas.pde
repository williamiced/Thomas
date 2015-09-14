import gausstoys.core.*;
import processing.serial.*;

ArrayList<PImage> imageList;
Game game;
int gameState; // 0 for not end, negative for tie, else the gameState indicate the winner player ID

boolean isGaussMode = false;

void setup() {
	initParams();
	loadImages();

	if (isGaussMode)
		setupGauss();
}

void draw() {
	if (isGaussMode)
		checkGaussEvent();

	drawBackground();
	
	game.drawBoard();
	game.drawPlayer();
	game.drawDirection();
	game.drawHoldedRail();
	game.drawPlayersCD();

	gameState = game.checkGameState();
	if (gameState == 0) { // Not ended
		game.randomAddBomb();
		game.decreasePlayersCD();
	} else {
		drawEndView();
	}
}

/*
	Player 1:
		Q: Switch the rail
		W: Rotate the rail
		E: Build the rail
	Player 2:
		I: Switch the rail
		O: Rotate the rail
		P: Build the rail

*/
void keyPressed() {
	if (gameState == 0) {
		if (key >= 'a' && key <= 'z')
			key = Character.toUpperCase(key);
		switch(key) {
			case 'Q':
				game.switchPlayerRail(0);
				break;
			case 'W':
				game.rotatePlayerRail(0);
				break;
			case 'E':
				game.makePlayerProgress(0);
				break;
			case 'I':
				game.switchPlayerRail(1);
				break;
			case 'O':
				game.rotatePlayerRail(1);
				break;
			case 'P':
				game.makePlayerProgress(1);
				break;
		}	
	} else {
		if (key >= 'a' && key <= 'z')
			key = Character.toUpperCase(key);
		if (key == 'R')
			resetGame();
	}
	
}

