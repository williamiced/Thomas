ArrayList<GaussSense> gsList;

void setupGauss() {
	gsList = new ArrayList<GaussSense>();

	if (Serial.list().length == 0) {
		println("Gauss Device is not dected");
		isGaussMode = false;
		return;
	}
	gsList.add(new GaussSense(this, GaussSense.GSType.GAUSSSENSE_STAGE, Serial.list()[Serial.list().length - 2], 115160));
	gsList.add(new GaussSense(this, GaussSense.GSType.GAUSSSENSE_STAGE, Serial.list()[Serial.list().length - 1], 115160));
}

void checkGaussEvent() {
	for (int i=0; i<gsList.size(); i++) {
		GaussSense gs = gsList.get(i);
		if (gs.isTagOn()) {
			int[] tag = gs.getTagID();
			doTagThing(i, tag);
		}
	}
}

void doTagThing(int playerID, int[] tag) {
	for (int i=0; i<game.playerCounter; i++) {
		for (int j=0; j<TAG_GAUSS[i].length; j++) {
			boolean isSame = true;
			for (int k=0; k<5; k++) {
				if (tag[k] != TAG_GAUSS[i][j][k]) {
					isSame = false;
					break;
				}
			}

			if (isSame) {
				if (playerID != i) // You use the enemy's tag?
					return;
				if (j == 0) { // Rail I tag
					// [TODO] do Things
				} else if (j == 1) { // Rail L tag
					// [TODO] do Things
				}
			}
		}
	}
}