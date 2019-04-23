stop();
_root.refreshWeapon(this);

function lvlUp(stats) {
	while (stats > 0) {
		chance = _root.getRandomUnder(100);
		addAmt = 2;
		if (chance > 75) {
			this.DEF += addAmt;
		} else if (chance > 50) {
			this.STR += addAmt;
		} else if (chance > 30) {
			this.SKL += addAmt;
		} else if (chance > 15) {
			this.maxHP += addAmt*2;
		} else if (chance > 5) {
			this.WIS += addAmt;
		} else {
			this.LUC += addAmt;
		}
		stats--;
	}
}

_root.attack(this,this.destinations[0],100,"Normal");