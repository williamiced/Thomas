
/** 0 as brick, -1 as coin, -2 as bomb */
public class Game {
	public int board[][];
	public int size = 10;
	public int playerCounter = 0;

	private int bombGeneraterCounter = 0;
	private ArrayList<Player> playerList;
	private Player playerBlue;
	private Player playerRed;

	public Game() {
		initBoard();
		setupGoldAndBomb();
		setupPlayers();
	}

	private void initBoard() {
		// Initialize the board to zero
		board = new int[size][];
		for (int i=0; i<size; i++) {
			board[i] = new int[size];
			for (int j=0; j<size; j++)
				board[i][j] = 0;
		}
	}

	private void setupGoldAndBomb() {
		// Setup a randomList to represent the board
		IntList randomList = new IntList();
		for (int i=0; i<size*(size-2); i++) 
			randomList.append(i);
		randomList.shuffle();

		// For first 10 locations, put golds on them
		for (int i=0; i<size; i++) {
			int targetLoc = randomList.get(i);
			board[targetLoc/size][targetLoc%size] = -1;
		}

		// For second 10 locations, put bombs on them
		for (int i=size; i<size*2; i++) {
			int targetLoc = randomList.get(i);
			board[targetLoc/size][targetLoc%size] = -2;
		}
	}

	private void setupPlayers() {
		playerCounter = 0;
		playerList = new ArrayList<Player>();
		playerList.add(new Player(new Location(0, size), size, IMAGE_THOMAS_BLUE, playerCounter++));
		playerList.add(new Player(new Location(size-1, size), size, IMAGE_THOMAS_RED, playerCounter++));
	}

	private void drawBoard() {
		// Draw blank bricks first
		for (int i=0; i<size; i++) 
			for (int j=0; j<size; j++) 
				image(imageList.get(IMAGE_BRICK), board_x + icon_x*j ,board_y + icon_y*i, icon_x, icon_y);

		// Draw golds and bombs
		for (int i=0; i<size; i++) 
			for (int j=0; j<size; j++) 
				if (board[i][j] == -1) // -1 is coin
					image(imageList.get(IMAGE_COIN), board_x + icon_x*j ,board_y + icon_y*i, icon_x, icon_y);
				else if (board[i][j] == -2) // -2 is bomb
					image(imageList.get(IMAGE_BOMB), board_x + icon_x*j ,board_y + icon_y*i, icon_x, icon_y);
	}

	private void drawPlayer() {
		for (int i=0; i<playerList.size(); i++) {
			Player player = playerList.get(i);
			Location loc = player.getLoc();
			image(imageList.get(player.getImageIdx()), board_x + icon_x*loc.x ,board_y + icon_y*loc.y, icon_x, icon_y);
		}
	}

	private void drawDirection() {
		for (int i=0; i<playerList.size(); i++) {
			Player player = playerList.get(i);
			Location dirLoc = player.getDirLoc();
			image(imageList.get(IMAGE_SELECTED_BRICK), board_x + icon_x*dirLoc.x ,board_y + icon_y*dirLoc.y, icon_x, icon_y);
		}
	}

	private void drawHoldedRail() {
		for (int i=0; i<playerList.size(); i++) {
			Player player = playerList.get(i);
			Location dirLoc = player.getDirLoc();
			int holdedRail = player.getHoldedRail();
			image(imageList.get(holdedRail), board_x + icon_x*dirLoc.x , board_y + icon_y*dirLoc.y, icon_x, icon_y);
		}
	}

	private void randomAddBomb() {
	    bombGeneraterCounter = bombGeneraterCounter >= BOMB_GENERATER_TIME ? 0 : (bombGeneraterCounter+1);
	    if (bombGeneraterCounter == 0) { // Generate a bomb
			IntList candidateList = new IntList();
			// Put blank spaces into the candidate list
			for (int i=0; i<size; i++) {
				for (int j=0; j<size; j++) {
					if (board[i][j] == 0 && !isClosePlayer(i, j))
				    	candidateList.append( (i * 1000 + j) );
				}
			}

			// Choose one candidate to put bomb on
			int targetIndex = (int)random(candidateList.size());
			int targetI = candidateList.get(targetIndex) / 1000;
			int targetJ = candidateList.get(targetIndex) % 1000;
			board[targetI][targetJ] = -2;
		}
    }

    private boolean isClosePlayer(int y, int x) {
    	for (int i=0; i<playerList.size(); i++) {
    		Location loc = playerList.get(i).getLoc();
    		if (abs(loc.x - x) + abs(loc.y - y) <= 1)
    			return true;
    	}
    	return false;
    }

    private void decreasePlayersCD() {
    	for (int i=0; i<playerList.size(); i++) 
    		playerList.get(i).decreaseCD();
    }

    private void drawPlayersCD () {
    	for (int i=0; i<playerList.size(); i++) {
    		Player player = playerList.get(i);
    		int id = player.getID();

    		pushStyle();
		    textSize(textcdsize);
		    fill(200,200,200);
		    text("Player" + (id+1), PLAYER_CD_LOC[id][0]-textcd_x, PLAYER_CD_LOC[id][1]-textcd_y);
		    popStyle();

		    for (int j=1; j<=5; j++) {
		    	if (player.getCD() < j * 20)
		    		image(imageList.get(IMAGE_CD), PLAYER_CD_LOC[id][0], PLAYER_CD_LOC[id][1]-icon_y*(j-1),icon_x,icon_y);
		    }
    	}    
  	}

  	private void switchPlayerRail(int playerID) {
  		playerList.get(playerID).switchRail();
  	}

  	private void rotatePlayerRail(int playerID) {
  		playerList.get(playerID).rotateRail();
  	}

  	private void makePlayerProgress(int playerID) {
  		Player player = playerList.get(playerID);
  		if (player.getCD() != 0)
  			return;
  		Location nextLoc = player.getDirLoc();
  		if (board[nextLoc.y][nextLoc.x] == -1) { // is Gold
  			player.eatCoin();
  			board[nextLoc.y][nextLoc.x] = 0;
  		} else if (board[nextLoc.y][nextLoc.x] == -2) { // is Bomb
  			player.eatBomb();
  			board[nextLoc.y][nextLoc.x] = 0;
  		}
  		boolean isGoodMove = player.makeProgress();
  		player.fillCD();
  		if (!isGoodMove) 
  			player.gotoStart();
  			//player.killPlayer();
  	}

  	private int checkGameState() {
  		// Check if there are more than one player survive
  		IntList aliveList = new IntList();
  		for (int i=0; i<playerList.size(); i++)
  			if (playerList.get(i).isAlive())
  				aliveList.append(playerList.get(i).getID());
  		if (aliveList.size() == 0)
  			return -2;
  		else if (aliveList.size() == 1)
  			return aliveList.get(0);

  		// Check if any player get the target number of coins
  		aliveList.clear();
  		for (int i=0; i<playerList.size(); i++)
  			if (playerList.get(i).getScore() > SCORE_LIMIT)
  				aliveList.append(playerList.get(i).getID());
  		if (aliveList.size() == 0)
  			return -1;
  		else if (aliveList.size() == 1)
  			return aliveList.get(0);
  		else
  			return -2;
  	}
}