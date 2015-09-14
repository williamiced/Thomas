void loadImages() {
	String[] fileNames = {"brick.png", "selectedBrick.png", "coin.png", "showBomb.png", "thomasBlue.png", "thomasRed.png", "thomas.jpg", "rail-I.png", "rail-I-2.png", "rail-L.png", "rail-L-2.png", "rail-L-3.png", "rail-L-4.png", "cool_down.png"};

	for (int i=0; i<fileNames.length; i++) 
		imageList.add(loadImage(fileNames[i]));
}

void initParams() {
	size(window_width, window_height);

	imageList = new ArrayList<PImage>();
	game = new Game();
}

void drawBackground() {
	background(0, 0, 0);
}

void drawEndView() {
	pushStyle();
    textSize(textwinsize);
    fill(256,256,256);
    if (gameState < 0)
    	text("=== TIE ===", textwin_x, textwin_y);
    else
    	text("Player"+(gameState+1)+" Win~~!!", textwin_x, textwin_y);
    popStyle();    
}

void resetGame() {
	gameState = 0;
	game = new Game();
}


class Location {
	public int x;
	public int y;

	public Location(int _x, int _y) {
		x = _x;
		y = _y;
	}
}