loops = 0;
randomGen = 0;
function getRandomUnder(highInt) {
	return int(Math.random() * highInt) + 1;
}
//displayBox
function getLevelEXP(level) {
	return Math.round((level * 10) + (500 * Math.pow(2, level / 4) /4) - 120);
}
while (loops <= 20) {
	displayBox.text += "Level " + loops + " needs: " + getLevelEXP(loops);
	randomGen = getRandomUnder(100);
	if (randomGen > 70) {
		displayBox.text += "..DEX Up!";
	} else if (randomGen > 60) {
		displayBox.text += "..STR Up!";
	} else if (randomGen > 20) {
		displayBox.text += "..VIT Up!";
	} else {
		displayBox.text += "..WIS Up!";
	}
	displayBox.text += "\n";
	loops++;
}