public class Player {
	private int id;
	private boolean isAlive;

	private int boardSize;
	private int locX;
	private int locY;
	private int imageIdx;

	private int dir;
	private int holdedRail;

	private float cdCounter;
	private float cdMultiplier;

	private int score;

	public Player(Location loc, int size, int imgIdx, int num) {
		id = num;
		isAlive = true;
		score = 0;

		locX = loc.x;
		locY = loc.y;
		boardSize = size;
		imageIdx = imgIdx;
		dir = DIR_NORTH;
		holdedRail = RAIL_I;
		cdCounter = 0;
		cdMultiplier = 1;
	}

	public int getImageIdx() {
		return imageIdx;
	}

	public Location getLoc() {
		return new Location(locX, locY);
	}

	public Location getDirLoc() {
		int xOffset = 0;
		int yOffset = 0;
		if (dir == DIR_EAST)
			xOffset = 1;
		else if (dir == DIR_WEST)
			xOffset = -1;
		else if (dir == DIR_SOUTH)
			yOffset = 1;
		else if (dir == DIR_NORTH)
			yOffset = -1;
		return new Location(locX + xOffset, locY + yOffset);
	}

	public int getDir() {
		return dir;
	}

	public int getHoldedRail() {
		return holdedRail;
	}

	public void decreaseCD() {
		cdCounter = (cdCounter - cdMultiplier) > 0 ? (cdCounter - cdMultiplier) : 0;
	}

	public void speedUp() {
		cdMultiplier *= 2;
	}

	public void slowDown() {
		cdMultiplier /= 2;
	}

	public int getID() {
		return id;
	}

	public float getCD() {
		return cdCounter;
	}

	public void switchRail() {
		if (holdedRail == RAIL_I || holdedRail == RAIL_I2)
			holdedRail = RAIL_L;
		else
			holdedRail = RAIL_I;
	}

	public void rotateRail() {
		switch (holdedRail) {
			case RAIL_I:
				holdedRail = RAIL_I2;
				break;
			case RAIL_I2:
				holdedRail = RAIL_I;
				break;
			case RAIL_L:
				holdedRail = RAIL_L2;
				break;
			case RAIL_L2:
				holdedRail = RAIL_L3;
				break;
			case RAIL_L3:
				holdedRail = RAIL_L4;
				break;
			case RAIL_L4:
				holdedRail = RAIL_L;
				break;
		}
	}

	private boolean makeProgress() {
		// Check if holdedRail is a valid one for current direction
		if (!isValidRail())
			return false;

		// Move forward first
		Location nextLoc = getDirLoc();
		locX = nextLoc.x;
		locY = nextLoc.y;

		// Then change the direction due to holdedRail
		changeDirIfNeeded();

		// Check if the nextMove is inside the board or not
		return isNextMoveInsideBoard();
	}

	private boolean isValidRail() {
		if (dir == DIR_NORTH && (holdedRail == RAIL_I || holdedRail == RAIL_L || holdedRail == RAIL_L2))
			return true;
		else if (dir == DIR_SOUTH && (holdedRail == RAIL_I || holdedRail == RAIL_L3 || holdedRail == RAIL_L4))
			return true;
		else if (dir == DIR_EAST && (holdedRail == RAIL_I2 || holdedRail == RAIL_L2 || holdedRail == RAIL_L3))
			return true;
		else if (dir == DIR_WEST && (holdedRail == RAIL_I2 || holdedRail == RAIL_L || holdedRail == RAIL_L4))
			return true;
		return false;
	}

	private void changeDirIfNeeded() {
		switch(holdedRail) {
			case RAIL_L:
				dir = (dir == DIR_NORTH) ? DIR_EAST : DIR_SOUTH;
				break;
			case RAIL_L2:
				dir = (dir == DIR_NORTH) ? DIR_WEST : DIR_SOUTH;
				break;
			case RAIL_L3:
				dir = (dir == DIR_SOUTH) ? DIR_WEST : DIR_NORTH;
				break;
			case RAIL_L4:
				dir = (dir == DIR_SOUTH) ? DIR_EAST : DIR_NORTH;
				break;
		}
	}

	private boolean isNextMoveInsideBoard() {
		Location nextLoc = getDirLoc();
		return (nextLoc.x >= 0 && nextLoc.x < boardSize && nextLoc.y >= 0 && nextLoc.y < boardSize);
	}

	private void fillCD() {
		cdCounter = 100;
	}

	private void killPlayer() {
		isAlive = false;
	}

	private boolean isAlive() {
		return isAlive;
	}

	private void eatCoin() {
		score += 1;
		speedUp();
	}

	private void eatBomb() {
		// [TODO] Do explode effect
		slowDown();
	}

	private int getScore() {
		return score;
	}
}