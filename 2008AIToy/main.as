stop();
function initArray() {
	charNamesAry = new Array('None', 'Nero', 'Charon', 'Cadfael', 'Iphigenia', 'Yun', 'Blanche', 'Lina', 'Senka', 'Quinton', 'Yong', 'Cillian', 'Sequoia', 'Belle', 'Diamanto', 'Conleth', 'Tsukiko', 'Nereida', 'Gilbert', 'Brutus', 'Qing', 'Daisuke', 'Aamina', 'Deror', 'Grigol', 'Bertram', 'Corinna', 'Elette', 'Khazo', 'Lyall', 'Everard', 'Eloise', 'Dmitriy', 'Alfhild', 'Farran', 'Vasil', 'Hazae', 'Khazak', 'Kasumi', 'Shell', 'Shell 2', 'Svarog', 'Ulrich', 'Nayeli', 'Zan Jia', 'Larien', 'Tyr', 'Shichirou', 'Iva', 'Saphira', 'Varfolomei', 'Miroslav', 'Aithne', 'Buenasdias', 'Echbert', 'Klytie', 'Hjalmar', 'Fleurette', 'Medino', 'Ceiva', 'Siofra', 'Ludolf', 'Xolani', 'Argyris', 'Jin Shui', 'Kong Sang', 'Vulgaris', 'Maximilian', 'Finley', 'Hallbjorn', 'Alcippe', 'Brenton', 'Ingrid', 'Refilwe', 'Temperance', 'Pascal', 'Walter', 'Riko', 'Joceline', 'Myung', 'Parth', 'Zlatan', 'Aniketos', 'Hiko', 'Aubrey', 'Nathaniel', 'Yasu', 'Winter', 'Ottavia', 'Wolf', 'Swanhild', 'Yevgeniy', 'Roshan', 'Marnix', 'Efthalia', 'Moana', 'Heinrich', 'Broen', 'Odalis', 'Zora', 'Ionna', 'Iwatani', 'WBC 1146', 'Chaz', 'Andrews', 'Brando', 'Chika', 'Clyde', 'Fubuki', 'Kenobi', 'Arue');
	charNamesAry2 = new Array('None', 'Nero', 'Charon', 'Cadfael', 'Iphigenia', 'Yun', 'Blanche', 'Lina', 'Senka', 'Quinton', 'Yong', 'Cillian', 'Sequoia', 'Belle', 'Diamanto', 'Conleth', 'Tsukiko', 'Nereida', 'Gilbert', 'Brutus', 'Qing', 'Daisuke', 'Aamina', 'Deror', 'Grigol', 'Bertram', 'Corinna', 'Elette', 'Khazo', 'Lyall', 'Everard', 'Eloise', 'Dmitriy', 'Alfhild', 'Farran', 'Vasil', 'Hazae', 'Khazak', 'Kasumi', 'Shell', 'Shell 2', 'Svarog', 'Ulrich', 'Nayeli', 'Zan Jia', 'Larien', 'Tyr', 'Shichirou', 'Iva', 'Saphira', 'Varfolomei', 'Miroslav', 'Aithne', 'Buenasdias', 'Echbert', 'Klytie', 'Hjalmar', 'Fleurette', 'Medino', 'Ceiva', 'Siofra', 'Ludolf', 'Xolani', 'Argyris', 'Jin Shui', 'Kong Sang', 'Vulgaris', 'Maximilian', 'Finley', 'Hallbjorn', 'Alcippe', 'Brenton', 'Ingrid', 'Refilwe', 'Temperance', 'Pascal', 'Walter', 'Riko', 'Joceline', 'Myung', 'Parth', 'Zlatan', 'Aniketos', 'Hiko', 'Aubrey', 'Nathaniel', 'Yasu', 'Winter', 'Ottavia', 'Wolf', 'Swanhild', 'Yevgeniy', 'Roshan', 'Marnix', 'Efthalia', 'Moanaa', 'Heinrich', 'Broen', 'Odalis', 'Zora', 'Ionna', 'Iwatani', 'WBC 1146', 'Chaz', 'Andrews', 'Brando', 'Chika', 'Clyde', 'Fubuki', 'Kenobi', 'Arue');
}
function initTeams() {
	team1Ary = new Array(0, 0, 0);
	team2Ary = new Array(0, 0, 0);
	team3Ary = new Array(0, 0, 0);
}
initTeams();
initArray();
//This array reserves 10 places for displaying health bars, etc
infoSpotAry = new Array(null, null, null, null, null, null, null, null, null, null);
//Array for holding the chars
charsAry = new Array();
//Variables
MAX_CHAR = 2500;

_root.numCharsAry = charNamesAry.length - 1;
nameCounter = 1;
charNum = 0;
maxChar = 10;
maxiPad.gotoAndStop(10);
damageNum = 1;
bestKiller = "";
bestKills = 0;
stataddamt = 4;
hpaddamt = 100;
_root.playerSpawned = false;
_root.maxProj = 30;
_root.projectiles = 1;
lvloption = "Kill";
//Make the combo box operational
var cbListener:Object = new Object();
cbListener.change = function(evt_obj:Object) {
	var item_obj:Object = charBox.selectedItem;
	var i:String;
	for (i in item_obj) {
		nameCounter = item_obj[i];
	}
};

charBox.addEventListener("change",cbListener);


//RandomNumberFunction
function getRandomBetween(lowInt, highInt) {
	return (lowInt + Math.floor(Math.random() * (highInt - lowInt + 1)));
}
// highest killer
function getHighestKiller () {
	var temp = 0;
	var tempName = "";
	for (var i = 0; i < _root.charsAry.length; i++ ) {
		if (_root.charsAry[i].Kills > temp) {
			temp = _root.charsAry[i].Kills;
			tempName = _root.charsAry[i].name;
		}
	}
	return tempName;
}
//Spawning Functions
function spawnChar(nameIn, posX, posY) {
	if (nameIn == null) {
		charName = charNamesAry[nameCounter];
	} else {
		charName = nameIn;
	}
	attachMovie(charName,"mc" + charNum,charNum);
	//Placement, check random or placed
	if (posX == null && posY == null) {
		if (_root.spawnPoint._currentframe == 1) {
			ranChance = int(Math.random() * 100) + 1;
			if (ranChance <= 25) {
				//NW
				xCoord = 21;
				yCoord = 90;
			} else if (ranChance > 25 && ranChance <= 50) {
				//NE
				xCoord = 675;
				yCoord = 90;
			} else if (ranChance > 50 && ranChance <= 75) {
				//SW
				xCoord = 21;
				yCoord = 428;
			} else if (ranChance > 75) {
				//SE
				xCoord = 675;
				yCoord = 428;
			}
			//And if the spawn randomizer is on a specific setting...                                                                                                                                                                                                     
		} else if (_root.spawnPoint._currentframe == 2) {
			//NW
			xCoord = 21;
			yCoord = 90;
		} else if (_root.spawnPoint._currentframe == 3) {
			//NE
			xCoord = 675;
			yCoord = 90;
		} else if (_root.spawnPoint._currentframe == 4) {
			//SW
			xCoord = 21;
			yCoord = 428;
		} else if (_root.spawnPoint._currentframe == 5) {
			//SE
			xCoord = 675;
			yCoord = 428;
		} else if (_root.spawnPoint._currentframe == 6) {
			//SE
			xCoord = int(Math.random() * 699) + 2;
			yCoord = int(Math.random() * 20) - 25;
		}
	} else {
		xCoord = posX;
		yCoord = posY;
	}
	this["mc" + charNum]._x = xCoord;
	this["mc" + charNum]._y = yCoord;
	//Give chars their stats here
	this["mc" + charNum].name = charName;
	this["mc" + charNum].Age = 0;
	this["mc" + charNum].Kills = 0;
	this["mc" + charNum].guardChance = 10;
	this["mc" + charNum].lvl = 1;
	this["mc" + charNum].experience = 0;
	this["mc" + charNum].expTotal = 0;
	this["mc" + charNum].walkable = true;
	this["mc" + charNum].vetNum = _root.vetMode._currentframe;
	if (_root.vetMode._currentframe == 1) {
		//this["mc" + charNum].lvl = 15;
		this["mc" + charNum].HP = getRandomBetween(900, 1400);
		this["mc" + charNum].STR = getRandomBetween(9, 16);
		this["mc" + charNum].VIT = getRandomBetween(9, 16);
		this["mc" + charNum].CON = getRandomBetween(9, 16);
		this["mc" + charNum].AGI = getRandomBetween(9, 16);

	} else if (_root.vetMode._currentframe == 2) {
		this["mc" + charNum].lvl = 14;
		this["mc" + charNum].HP = getRandomBetween(2000, 2500);
		this["mc" + charNum].STR = getRandomBetween(16, 22);
		this["mc" + charNum].VIT = getRandomBetween(16, 22);
		this["mc" + charNum].CON = getRandomBetween(16, 22);
		this["mc" + charNum].AGI = getRandomBetween(16, 22);

	} else if (_root.vetMode._currentframe == 3) {
		this["mc" + charNum].lvl = 15;
		this["mc" + charNum].HP = getRandomBetween(4000, 4200);
		this["mc" + charNum].STR = getRandomBetween(22, 32);
		this["mc" + charNum].VIT = getRandomBetween(22, 32);
		this["mc" + charNum].CON = getRandomBetween(22, 32);
		this["mc" + charNum].AGI = getRandomBetween(22, 32);

	} else if (_root.vetMode._currentframe == 4) {
		this["mc" + charNum].lvl = 20;
		this["mc" + charNum].HP = getRandomBetween(8000, 9000);
		this["mc" + charNum].STR = getRandomBetween(40, 59);
		this["mc" + charNum].VIT = getRandomBetween(40, 59);
		this["mc" + charNum].CON = getRandomBetween(40, 59);
		this["mc" + charNum].AGI = getRandomBetween(40, 59);
	} else if (_root.vetMode._currentframe == 5) {
		this["mc" + charNum].lvl = 25;
		this["mc" + charNum].HP = getRandomBetween(10000, 13000);
		this["mc" + charNum].STR = getRandomBetween(67, 80);
		this["mc" + charNum].VIT = getRandomBetween(67, 80);
		this["mc" + charNum].CON = getRandomBetween(67, 80);
		this["mc" + charNum].AGI = getRandomBetween(67, 80);
	} else if (_root.vetMode._currentframe == 6) {
		this["mc" + charNum].lvl = 30;
		this["mc" + charNum].HP = getRandomBetween(15000, 17000);
		this["mc" + charNum].STR = getRandomBetween(90, 129);
		this["mc" + charNum].VIT = getRandomBetween(90, 129);
		this["mc" + charNum].CON = getRandomBetween(90, 129);
		this["mc" + charNum].AGI = getRandomBetween(90, 129);
	}
	totalStat = this["mc" + charNum].AGI + this["mc" + charNum].VIT + this["mc" + charNum].CON + this["mc" + charNum].STR;
	this["mc" + charNum].STRpercent = this["mc" + charNum].STR / totalStat;
	this["mc" + charNum].VITpercent = this["mc" + charNum].VIT / totalStat;
	this["mc" + charNum].CONpercent = this["mc" + charNum].CON / totalStat;
	this["mc" + charNum].AGIpercent = this["mc" + charNum].AGI / totalStat;
	this["mc" + charNum].aDEF = 0;
	this["mc" + charNum].highestHP = this["mc" + charNum].HP;
	//put on some fucntions, y0 
	if (nameIn == "Hunter") {
		this["mc" + charNum].onEnterFrame = scoutAI;
		this["mc" + charNum].targetChar = null;
		this["mc" + charNum].targetCharName = getHighestKiller();
	} else {

		this["mc" + charNum].onEnterFrame = charAI;
	}
	this["mc" + charNum].charDie = charDieF;
	this["mc" + charNum].levelUp = levelUpF;
	this["mc" + charNum].trapTimer = 0;

	//this["mc"+charNum].Team =
	this["mc" + charNum].walkSpeed = 5;
	this["mc" + charNum].Team = 0;
	for (t = 0; t < 3; t++) {
		if (team1Ary[t] == nameCounter) {
			this["mc" + charNum].Team = 1;
		} else if (team2Ary[t] == nameCounter) {
			this["mc" + charNum].Team = 2;
		} else if (team3Ary[t] == nameCounter) {
			this["mc" + charNum].Team = 3;
		}
	}
	this["mc" + charNum].TeamC.gotoAndStop(this["mc" + charNum].Team + 1);
	this["mc" + charNum].Buff = "None";
	this["mc" + charNum].disposition = "Normal";
	this["mc" + charNum].initChared = false;
	//this["mc"+charNum].initChar();
	//These are for AI purposes only
	this["mc" + charNum].walkTimer = 0;
	this["mc" + charNum].frozen = false;
	this["mc" + charNum].damageAccu = 0;
	this["mc" + charNum].attackAccu = 0;
	
	report("reportSpawn", charName, 0, 0);

	//Add to array
	_root.charsAry.push(this["mc" + charNum]);
	//INIT
	//Add to info Displays
	for (var j = 0; j < infoSpotAry.length; j++) {
		//find the first open spot
		if (infoSpotAry[j] == null) {
			this["mc" + charNum].infoIndex = j;
			//index to hold the spot
			infoSpotAry[j] = this["mc" + charNum];
			_root["status" + j].Cover.gotoAndStop(1);
			//Veteran?
			if (_root.vetMode._currentframe != 1) {
				_root["status" + j].portrait.vetIcon.gotoAndStop(2);
				this["mc" + charNum].veteran = true;
			} else {
				_root["status" + j].portrait.vetIcon.gotoAndStop(1);
				this["mc" + charNum].veteran = false;
			}
			break;
		}
		//end if                                                                                                                                                                                                                              
	}
	charNum++;
	//name1 = charNamesAry[nameCounter];
	name1 = charName;
	if (_root.charChange._currentframe == 1) {
		nameCounter = int(Math.random() * _root.numCharsAry) + 1;
	}
	name2 = charNamesAry[nameCounter];
	nameDisplay = "Last: " + name1 + " Next: " + name2;
	
	if (charNum >= MAX_CHAR) {
		_root.autoSpawn.gotoAndStop(1);
	}
}
//Spawn PLAYER
function spawnPlayer(charName) {
	attachMovie(charName,"mc" + charNum,charNum);
	_root.playerSpawned = true;
	//Placement, check random or placed
	if (_root.spawnPoint._currentframe == 1) {
		ranChance = int(Math.random() * 100) + 1;
		if (ranChance <= 25) {
			//NW
			xCoord = 21;
			yCoord = 90;
		} else if (ranChance > 25 && ranChance <= 50) {
			//NE
			xCoord = 675;
			yCoord = 90;
		} else if (ranChance > 50 && ranChance <= 75) {
			//SW
			xCoord = 21;
			yCoord = 428;
		} else if (ranChance > 75) {
			//SE
			xCoord = 675;
			yCoord = 428;
		}
		//And if the spawn randomizer is on a specific setting...                                                                                                                                                                                                     
	} else if (_root.spawnPoint._currentframe == 2) {
		//NW
		xCoord = 21;
		yCoord = 90;
	} else if (_root.spawnPoint._currentframe == 3) {
		//NE
		xCoord = 675;
		yCoord = 90;
	} else if (_root.spawnPoint._currentframe == 4) {
		//SW
		xCoord = 21;
		yCoord = 428;
	} else if (_root.spawnPoint._currentframe == 5) {
		//SE
		xCoord = 675;
		yCoord = 428;
	} else if (_root.spawnPoint._currentframe == 6) {
		//SE
		xCoord = int(Math.random() * 699) + 2;
		yCoord = int(Math.random() * 20) - 25;
	}

	this["mc" + charNum]._x = xCoord;
	this["mc" + charNum]._y = yCoord;
	//Give chars their stats here
	this["mc" + charNum].name = charName;
	this["mc" + charNum].Age = 0;
	this["mc" + charNum].Kills = 0;
	this["mc" + charNum].guardChance = 10;
	this["mc" + charNum].lvl = 1;
	this["mc" + charNum].experience = 0;
	this["mc" + charNum].expTotal = 0;
	this["mc" + charNum].walkable = true;
	this["mc" + charNum].vetNum = _root.vetMode._currentframe;
	if (_root.vetMode._currentframe == 1) {
		//this["mc" + charNum].lvl = 15;
		this["mc" + charNum].HP = getRandomBetween(900, 1400);
		this["mc" + charNum].STR = getRandomBetween(9, 16);
		this["mc" + charNum].VIT = getRandomBetween(9, 16);
		this["mc" + charNum].CON = getRandomBetween(9, 16);
		this["mc" + charNum].AGI = getRandomBetween(9, 16);

	} else if (_root.vetMode._currentframe == 2) {
		this["mc" + charNum].lvl = 14;
		this["mc" + charNum].HP = getRandomBetween(2000, 2500);
		this["mc" + charNum].STR = getRandomBetween(16, 22);
		this["mc" + charNum].VIT = getRandomBetween(16, 22);
		this["mc" + charNum].CON = getRandomBetween(16, 22);
		this["mc" + charNum].AGI = getRandomBetween(16, 22);

	} else if (_root.vetMode._currentframe == 3) {
		this["mc" + charNum].lvl = 15;
		this["mc" + charNum].HP = getRandomBetween(4000, 4200);
		this["mc" + charNum].STR = getRandomBetween(22, 32);
		this["mc" + charNum].VIT = getRandomBetween(22, 32);
		this["mc" + charNum].CON = getRandomBetween(22, 32);
		this["mc" + charNum].AGI = getRandomBetween(22, 32);

	} else if (_root.vetMode._currentframe == 4) {
		this["mc" + charNum].lvl = 20;
		this["mc" + charNum].HP = getRandomBetween(8000, 9000);
		this["mc" + charNum].STR = getRandomBetween(40, 59);
		this["mc" + charNum].VIT = getRandomBetween(40, 59);
		this["mc" + charNum].CON = getRandomBetween(40, 59);
		this["mc" + charNum].AGI = getRandomBetween(40, 59);
	} else if (_root.vetMode._currentframe == 5) {
		this["mc" + charNum].lvl = 25;
		this["mc" + charNum].HP = getRandomBetween(10000, 13000);
		this["mc" + charNum].STR = getRandomBetween(67, 80);
		this["mc" + charNum].VIT = getRandomBetween(67, 80);
		this["mc" + charNum].CON = getRandomBetween(67, 80);
		this["mc" + charNum].AGI = getRandomBetween(67, 80);
	} else if (_root.vetMode._currentframe == 6) {
		this["mc" + charNum].lvl = 30;
		this["mc" + charNum].HP = getRandomBetween(15000, 17000);
		this["mc" + charNum].STR = getRandomBetween(90, 129);
		this["mc" + charNum].VIT = getRandomBetween(90, 129);
		this["mc" + charNum].CON = getRandomBetween(90, 129);
		this["mc" + charNum].AGI = getRandomBetween(90, 129);
	}
	totalStat = this["mc" + charNum].AGI + this["mc" + charNum].VIT + this["mc" + charNum].CON + this["mc" + charNum].STR;
	this["mc" + charNum].STRpercent = this["mc" + charNum].STR / totalStat;
	this["mc" + charNum].VITpercent = this["mc" + charNum].VIT / totalStat;
	this["mc" + charNum].CONpercent = this["mc" + charNum].CON / totalStat;
	this["mc" + charNum].AGIpercent = this["mc" + charNum].AGI / totalStat;
	this["mc" + charNum].aDEF = 0;
	this["mc" + charNum].highestHP = this["mc" + charNum].HP;
	//put on some fucntions, y0 
	this["mc" + charNum].onEnterFrame = charControl;
	this["mc" + charNum].charDie = charDieF;
	this["mc" + charNum].levelUp = levelUpF;
	this["mc" + charNum].trapTimer = 0;

	//this["mc"+charNum].Team =
	this["mc" + charNum].walkSpeed = 5;
	this["mc" + charNum].Team = 0;
	for (t = 0; t < 3; t++) {
		if (team1Ary[t] == nameCounter) {
			this["mc" + charNum].Team = 1;
		} else if (team2Ary[t] == nameCounter) {
			this["mc" + charNum].Team = 2;
		} else if (team3Ary[t] == nameCounter) {
			this["mc" + charNum].Team = 3;
		}
	}
	this["mc" + charNum].TeamC.gotoAndStop(this["mc" + charNum].Team + 1);
	this["mc" + charNum].Buff = "None";
	this["mc" + charNum].disposition = "Player";
	this["mc" + charNum].initChared = false;
	//this["mc"+charNum].initChar();
	//These are for AI purposes only
	this["mc" + charNum].walkTimer = 0;
	this["mc" + charNum].frozen = false;
	this["mc" + charNum].damageAccu = 0;
	this["mc" + charNum].attackAccu = 0;

	//Add to array
	_root.charsAry.push(this["mc" + charNum]);
	//INIT
	//Add to info Displays
	for (var j = 0; j < infoSpotAry.length; j++) {
		//find the first open spot
		if (infoSpotAry[j] == null) {
			this["mc" + charNum].infoIndex = j;
			//index to hold the spot
			infoSpotAry[j] = this["mc" + charNum];
			_root["status" + j].Cover.gotoAndStop(1);
			//Veteran?
			if (_root.vetMode._currentframe != 1) {
				_root["status" + j].portrait.vetIcon.gotoAndStop(2);
				this["mc" + charNum].veteran = true;
			} else {
				_root["status" + j].portrait.vetIcon.gotoAndStop(1);
				this["mc" + charNum].veteran = false;
			}
			break;
		}
		//end if                                                                                                                                                                                                                              
	}
	charNum++;
	//name1 = charNamesAry[nameCounter];
	name1 = charName;
	name2 = charNamesAry[nameCounter];
	nameDisplay = "Last: " + name1 + " Next: " + name2;
}
//Leveling stuff
//EXP to next level:
function getEXPreq(level) {
	if (level == 1) {
		return 0;
	} else {
		expneeded = (20 * level) * (1 + (level / 10)) + level - 35;
		return expneeded;
	}
}

function getEXPworth(level, kills) {
	expget = 5 * level + kills + 5;
	return expget;
}

function expPercent(level, exp) {
	if (level == 99) {
		return 100;
	}
	//EXP btwn curr and next                                             
	nextlvlexp = _root.getEXPreq(level + 1) - _root.getEXPreq(level);
	//Progress between next and current
	exp -= getEXPreq(level);
	binbin = Math.round((exp / nextlvlexp) * 100);
	if (binbin > 100) {
		binbin = 100;
	}
	return binbin;
}

//Player Control
function charControl() {
	//Well he's here, let's make 'em grow older.
	this.Age++;
	//The Control Function
	//First check if he's falling. If falling you can't do shit.
	if (!_root.Ground.hitTest(this._x, this._y + 3, true)) {
		this._y += 5;
		if (this._y > 450) {
			this._y = 0;
			//Random X If Desert arena
			if (_root.BG._currentframe == 2) {
				this._x = int(Math.random() * 699) + 2;
			}
			//Make sure s/he's not out of bounds               
			if (this._x > 700 || this._x < 0) {
				this._x = int(Math.random() * 699) + 2;
			}
		}
	} else {
		if (this._currentframe > 3) {
			this.play();
		}
		if (_root.Ground.hitTest(this._x, this._y, true)) {
			this._y--;
		}
		//Not falling, good to go .. that is if you're not TRAPPED         
		if (this.walkable == true) {
			//If idle, enable controls
			if (this._currentframe <= 3) {
				this.charAct = "Alert";
				if (this.HP < 1800) {
					this.HP += 1;
				}
				if (Key.isDown(65)) {
					//Main attack
					this.gotoAndPlay("Attack");
				} else if (Key.isDown(83)) {
					//Shooting
					this.gotoAndPlay("Shoot");
				} else if (Key.isDown(68)) {
					//Bash
					this.gotoAndPlay("Bash");
				} else if (Key.isDown(70)) {
					//Bash
					this.gotoAndPlay("Special");
				} else if (Key.isDown(37)) {
					//LEFT
					this._xscale = 100;
					this.dir = -(this._xscale / 100);
					_root.playerWalk(this,dir,1);
					this.gotoAndStop("Walk");
				} else if (Key.isDown(39)) {
					//RIGHT
					this._xscale = -100;
					this.dir = -(this._xscale / 100);
					_root.playerWalk(this,dir,1);
					this.gotoAndStop("Walk");
				} else {
					this.gotoAndStop("Stand");
				}
			} else {
				//If not idle, keep playing
				this.charAct = "Fighting";
				//play();
			}

		} else {
			this.trapTimer--;
			if (this.trapTimer <= 0) {
				this.walkable = true;
			}
		}
	}
	//Standard stuff
	//Poison                                                                                  
	if (this.buff == "Poison" && this.HP > 200) {
		this.HP -= 2;
	}
	if (this.buff == "Poison 2" && this.HP > 200) {
		this.HP -= 10;
	}
	//Change the char's alpha to represent HP loss                                                                                                                                                       
	wahmbolehngwah = (100 * (this.HP / this.highestHP));
	//if (wahmbolehngwah>100) {
	//wahmbolehngwah = 100;
	//}
	//this._alpha = wahmbolehngwah;
	if (wahmbolehngwah < 16) {
		this._alpha = (wahmbolehngwah * 5) + 20;
	} else {
		this._alpha = 100;
	}
	//Has HP Increased? If so, change the maxHP
	if (this.HP > this.highestHP) {
		this.highestHP = this.HP;
	}
	//Desert Wind anybody?                                                                                                                                    
	if (_root.BG._currentframe == 2) {
		this._x -= 2;
	}
	//Print Stats                                                                                                                                                                              
	_root.printStats(this);
	//Depths
	this.swapDepths(6000 + this.infoIndex + this._y);
}

//AI - Two basic things. Fighting and idling
function charAI() {
	//Well he's here, let's make 'em grow older.
	this.Age++;
	//The Idle Function
	//First check if he's falling. If falling you can't do shit.
	if (!_root.Ground.hitTest(this._x, this._y + 3, true)) {
		this._y += 5;
		if (this._y > 450) {
			this._y = 0;
			//Random X If Desert arena
			if (_root.BG._currentframe == 2 || _root.BG._currentframe == 20) {
				this._x = int(Math.random() * 699) + 2;
			}
			//Make sure s/he's not out of bounds               
			if (this._x > 700 || this._x < 0) {
				this._x = int(Math.random() * 699) + 2;
			}
		}
	} else {
		if (_root.Ground.hitTest(this._x, this._y, true)) {
			this._y--;
		}
		if (this.charAct != "Fleeing" && this.charAct != "Sleeping") {
			this.charAct = "Idle";
			for (var q = 0; q <= _root.charsAry.length; q++) {
				//Check if they're on the team
				myTeam = checkTeams(this, charsAry[q]);
				if (myTeam == false) {
					//HP Lows means they may not fight
					fightChance = 100;
					if (this.HP < 800) {
						this.fightChance -= (this.HP / 8) - 10;
					}
					Bubbles = int(Math.random() * 100) + 1;
					if (Bubbles <= fightChance) {
						if (this.sightArea.hitTest(charsAry[q].bodyArea)) {
							if (this.charAct != "Fighting") {
								victim = charsAry[q];
								if (this.bodyArea.hitTest(victim.bodyArea)) {
									// too close
									if (int(Math.random() * 10) < 5) {
										this._xscale *= -1;
									}
									this.charAct = "Fleeing";
									this.walkTimer = 40;
								} else {
									this.charAct = "Chase";
								}
								
							}
						} else if (this.atkArea.hitTest(charsAry[q].bodyArea)) {
							this.charAct = "Fighting";
							victim = charsAry[q];
						} else if (this.sightArea2.hitTest(charsAry[q].bodyArea)) {
							if (this.charAct != "Fighting" && this.charAct != "Fleeing") {
								this._xscale *= -1;
								//this.charAct = "Chase";
							}
						}
					} else {
						this.charAct = "Fleeing";
						this.Emote.gotoAndStop("Fleeing");
						this.walkTimer = 40;
						this.HP += 10;
					}
				}
			}
		}
		if (this._currentframe > 2 && this.charAct != "Sleeping" && this.charAct != "Fleeing") {
			this.charAct = "Fighting";
		}
		//DIE BITCHES                                                                                                                                                                       
		if (this.charAct == "Fighting" && this.frozen == false) {
			this.play();
		}
		//THE CHASE IS ON!                                                                                                                                                                                    
		if (this.charAct == "Chase") {
			//this.gotoAndStop("Walk");
			this.Emote.gotoAndPlay("Chase");
			if (_root.wandering._currentframe == 1) {
				if (victim._x < this._x) {
					this._xscale = 100;
					_root.playerWalk(this,2,1.5);
					//this._x -= this.walkSpeed * 1.3;
				} else if (victim._x > this._x) {
					this._xscale = -100;
					_root.playerWalk(this,1,1.5);
					//this._x += this.walkSpeed * 1.3;
				}
			}
		}
		//RUNN TOO THEE HIIILLLSS!                                                                                                                                                                         
		if (this.charAct == "Fleeing") {
			if (_root.wandering._currentframe == 1) {
				this.walkTimer--;
				if (this.walkTimer <= 0) {
					this.charAct = "Idle";
					this.walkTimer = 20;
					this.Buff = "None";
				} else {
					if (this._xscale == -100) {
						_root.playerWalk(this,1,1);
					} else if (this._xscale == 100) {
						_root.playerWalk(this,2,1);
						//this._x -= 2;
					}
				}
			}
		}
		//Control walking                                                                                                                                                                                      
		if (this.charAct == "Idle" || this.charAct == "Fleeing") {
			this.gotoAndStop("Walk");
			if (_root.wandering._currentframe == 1) {
				if (this.walkTimer <= 0) {
					if (this.HP < 1800) {
						this.HP += 20;
					}
					this.flip = getRandomBetween(1, 2);
					if (this.flip == 1) {
						this._xscale *= -1;
					}
					this.walkTimer = getRandomBetween(7, 70);
					if (player.Buff == "Terror") {
						Bubbles = int(Math.random() * 10) + 1;
						if (Bubbles > 8) {
							suicide(this,this.STR * 2);
						}
					}
				} else {
					if (this.walkable == true) {

						this.dir = -(this._xscale / 100);
						_root.playerWalk(this,dir,1);
						//if (this.dir == 1) {
						//this._xscale = -100;
						//this._x += this.walkSpeed;
						//} else {
						//this._xscale = 100;
						//this._x -= this.walkSpeed;
						//}
					} else {
						this.trapTimer--;
						if (this.trapTimer <= 0) {
							this.walkable = true;
						}
					}
					this.walkTimer--;
				}
			}
		}
	}

	//Check for walls 
	//if (_root.Ground.hitTest(_parent._x, _parent._y, true)) {
	//}
	//Poison                                                                                  
	if (this.buff == "Poison" && this.HP > 200) {
		this.HP -= 2;
	}
	if (this.buff == "Poison 2" && this.HP > 200) {
		this.HP -= 10;
	}
	//Change the char's alpha to represent HP loss                                                                                                                                                        
	wahmbolehngwah = (100 * (this.HP / this.highestHP));
	//if (wahmbolehngwah>100) {
	//wahmbolehngwah = 100;
	//}
	//this._alpha = wahmbolehngwah;
	if (wahmbolehngwah < 16) {
		this._alpha = (wahmbolehngwah * 5) + 20;
	} else {
		this._alpha = 100;
	}
	//Has HP Increased? If so, change the maxHP
	if (this.HP > this.highestHP) {
		this.highestHP = this.HP;
	}
	//Desert Wind anybody?                                                                                                                                     
	if (_root.BG._currentframe == 2) {
		this._x -= 2;
	}
	//Print Stats                                                                                                                                                                               
	_root.printStats(this);
	//Depths
	this.swapDepths(6000 + this.infoIndex + this._y);
}
//Walk Function
function playerWalk(target, dirx, mod) {
	if (mod <= 5) {
		if (target._xscale == -100) {
			dir = 1;
		} else {
			dir = 2;
		}
	} else {
		if (target._xscale == -100) {
			dir = 2;
		} else {
			dir = 1;
		}
	}
	// else {
	//dir = dirx;
	//}
	//Increase mod if Agility Buff is there
	if (target.Buff == "Agility" && mod < 5) {
		mod++;
	}
	//Move the guys              
	if (mod <= 5) {
		movSpd = target.walkSpeed * mod;
		if (dir == 1) {
			//target._xscale = -100;
			if (!_root.Ground.hitTest(target._x + movSpd + 2, target._y - 2, true)) {
				target._x += movSpd;
			}
		} else {
			//target._xscale = 100;
			if (!_root.Ground.hitTest(target._x - movSpd + 2, target._y - 2, true)) {
				target._x -= movSpd;
			}
		}
	} else {
		//If speed over 5x, must be pixel size move
		if (dir == 1) {
			//target._xscale = -100;
			if (!_root.Ground.hitTest(target._x + mod + 2, target._y - 2, true)) {
				target._x += mod;
			}
		} else {
			//target._xscale = 100;
			if (!_root.Ground.hitTest(target._x - mod + 2, target._y - 2, true)) {
				target._x -= mod;
			}
		}
	}
	//Wall check
	if (_root.Ground.hitTest(target._x - 10, target._y - 2, true)) {
		//wall to the left
		//this.walkTimer = 0;
		target._xscale = -100;
		target._x += 5;
	} else if (_root.Ground.hitTest(target._x + 10, target._y - 2, true)) {
		//this.walkTimer = 0;
		target._xscale = 100;
		target._x -= 5;
	}
	//Check borders                    
	if (target._x > 700) {
		target._x = 0;
	} else if (target._x < 0) {
		target._x = 700;
	}
}
//Stat printing function
function printStats(target) {
	Yngwie = target.infoIndex;
	_root["status" + Yngwie].portrait.gotoAndStop(target.name);
	_root["status" + Yngwie].Age = Math.round(target.Age / 18);
	_root["status" + Yngwie].Kills = target.lvl;
	_root["status" + Yngwie].name = target.name;
	Store1 = target.HP;
	Store2 = target.highestHP;
	_root["status" + Yngwie].HP = Store1 + "/" + Store2;
	Percent = (Store1 / Store2) * 100;
	_root["status" + Yngwie].HPBar._xscale = Percent;
	if (_root.lvloption == "EXP") {
		_root["status" + Yngwie].EXPBar._xscale = _root.expPercent(target.lvl, target.experience);
	}
	_root.charNum2 = _root.charsAry.length;
	if (target.HP == 0) {
		_root["status" + Yngwie].Cover.gotoAndPlay("Dead");
	}
}
function suicide(player, damage) {
	damage -= player.VIT;
	niggs = player.aDEF;
	subtracting = damage * (niggs / 100);
	damage -= Math.round(subtracting);
	if (player.Buff == "Defender") {
		damage /= 2;
		pool = damage;
		damage = Math.round(pool);
	}
	if (damage < 1) {
		damage = 1;
	}
	player.HP -= damage;
	player.Emote.gotoAndPlay("Slashed");
	attachMovie("numberfly2","number" + damageNum,damageNum + 10000);
	_root["number" + damageNum]._x = player._x;
	_root["number" + damageNum]._y = player._y - 10;
	_root["number" + damageNum].var123 = Math.round(damage2 / 2);
	damageNum++;
	if (damageNum > 20) {
		damageNum = 1;
	}
	if (player.HP <= 0) {
		player.HP = 0;
		player.charDie(player);
	}
}
//A Character's Attack
function attack(player, damage, type) {
	player.attackAccu++;
	//Check enemies attacking
	hitDiv = 0;
	if (type != "Splash" && type != "Single") {
		for (var q = 0; q <= _root.charsAry.length; q++) {
			//Check if they're on the team
			myTeam = checkTeams(player, charsAry[q]);
			if (myTeam == false) {
				//Check hitTest
				if (player.atkArea.hitTest(charsAry[q].bodyArea)) {
					hitDiv++;
				}
			}
		}
	} else {
		hitDiv = 1;
	}
	//Terror?
	if (player.Buff == "Terror") {
		Bubbles = int(Math.random() * 100) + 1;
		if (Bubbles > 90) {
			suicide(player,damage);
		}
	}
	for (var q = 0; q <= _root.charsAry.length; q++) {
		//Check if they're on the team
		myTeam = checkTeams(player, charsAry[q]);
		if (myTeam == false) {
			//Check hitTest
			if (player.atkArea.hitTest(charsAry[q].bodyArea)) {
				if (player._xscale == charsAry[q]._xscale && charsAry[q].charAct != "Fleeing" && charsAry[q].disposition != "Player") {
					charsAry[q]._xscale *= -1;
				}
				if (type == "Trigger") {
					player.gotoAndPlay("Trigger");
				}
				if (victim.charAct == "Sleeping") {
					charsAry[q].charAct = "Fighting";
				}
				if (player.buff == "Locked") {
					type = "Blunt";
				}
				//Crit                                                                                                                
				//Hit or Miss?                                                     
				Stat1 = player.CON + player.Kills;
				if (type == "Critical") {
					chansu = 15;
				} else {
					chansu = 70;
				}
				Bubblez = int(Math.random() * chansu) + 1;
				if (Bubblez == 1) {
					crit = true;
					damage *= 8;
					Stat1 += 100;
				} else {
					crit = false;
				}
				wibbit = damage / hitDiv;
				damage = Math.round(wibbit);
				Stat2 = charsAry[q].AGI + charsAry[q].Kills;
				Conv = 80 + Stat1 - (Stat2 / 1.5);
				if (Conv < 5) {
					Conv = 5;
				}
				Bubbles = int(Math.random() * 100) + 1;
				if (player.Buff == "Bound") {
					Bubbles += 60;
				}
				if (player.Buff == "Targeting" || player.disposition == "Hero" || player.disposition == "Daemon") {
					Conv *= 2;
				}
				if (type == "Guided" || victim.Buff == "Bide") {
					Conv *= 20;
				}
				if (victim.Buff == "Agility") {
					Conv /= 2;
				}
				if (type == "Wild") {
					Conv /= 4;
				}
				if (type == "Heating") {
					Conv = 100 + Stat1 - (Stat2 / 10);
				}
				//If miss                                                                                                             
				if (Bubbles > Conv) {
					attachMovie("numberfly2","number" + damageNum,damageNum + 10000);
					_root["number" + damageNum]._x = player._x;
					_root["number" + damageNum]._y = player._y - 10;
					_root["number" + damageNum].var123 = "MISS!";
					damageNum++;
					if (damageNum > 20) {
						damageNum = 1;
					}
					//Counter                                                                                   
					if (victim.disposition == "Counter" || victim.Buff == "Counter") {
						if (victim._currentframe < 10) {
							victim.combo = damage2;
							victim.gotoAndPlay("Counter");
						}
					}
					break;

				}
				//                                                                                                                                                                             
				//break;
				victim = charsAry[q];
				victim.prevFrame();
				victim.Flincher.play();
				//Calculate Damage
				vicDef = victim.VIT;
				if (victim.Buff == "Poison") {
					vicDef /= 2;
				}
				damage += Math.round((player.STR / 20) * (damage / 4));
				if (victim.Buff == "Defender" || victim.Buff == "Full") {
					damage /= 2;
					pool = damage;
					damage = Math.round(pool);
				}
				if (player.Buff == "Strength" || player.Buff == "Full") {
					damage += 50 + (player.STR * 2);
				} else if (player.Buff == "Crippled") {
					damage -= 50 + (player.STR);
				} else if (player.Buff == "Strength+") {
					damage *= 2;
				}
				if (type != "Sharp" && type != "Pierce") {
					niggs = victim.aDEF;
					subtracting = damage * (niggs / 100);
					damage -= Math.round(subtracting);
				}
				if (type == "Blunt" || type == "Push" || type == "Push2" || type == "Party" || type == "Scatter" || type == "Shackle") {
					perDef = 1 - (vicDef / 1000);
					bloof = Math.round(damage * perDef);
					damage2 = bloof - vicDef;
				} else if (type == "Blade" || type == "Guided" || type == "Critical" || type == "Trigger" || type == "Single") {
					wookee = Math.round(vicDef / 2);
					damage2 = damage - wookee;
				} else if (type == "Sharp" || type == "Splash") {
					damage2 = damage;
				} else if (type == "Date") {
					if (victim.gender == player.gender) {
						damage *= 2;
						type = "Scatter";
					} else {
						damage /= 4;
					}
					damage2 = Math.round(damage);
				} else if (type == "Vital") {
					wooo = Math.round(victim.HP / 15);
					damage2 = damage + wooo - 100;
				} else if (type == "Judo") {
					wooo = Math.round(((victim.aDEF * 2.5) / 100) + 1);
					damage2 = damage * wooo;
				} else if (type == "HighGround") {
					wooo = Math.round((450 - player._y) / 2);
					trace('playerY ' + player._y);
					damage2 = damage + wooo;
				} else if (type == "Pierce") {
					wooo = victim.VIT * 2;
					damage2 = damage + wooo;
				} else if (type == "Heating") {
					woo = victim.VIT * 2;
					damage2 = damage + woo + victim.AGI;
				} else if (type == "Turn") {
					victim._xscale *= -1;
					damage2 = damage;
				} else if (type == "Curse") {
					if (victim.Buff == "Curse") {
						victim.Buff = "Dual Curse";
					} else if (victim.Buff == "Dual Curse") {
						victim.Buff = "None";
					} else {
						victim.Buff = "Curse";
					}
					victim.Emote.gotoAndStop("Curse");
					damage2 = damage;
				} else if (type == "Avenge") {
					jingjong = victim.Kills * 2;
					damage2 = damage + jingjong;
				} else if (type == "Antivet") {
					damage2 = damage;
					if (victim.veteran == true) {
						damage2 *= 2;
					}
				} else if (type == "Gender") {
					if (victim.gender == player.gender) {
						damage *= 1.5;
					}
					damage2 = Math.round(damage);
				} else if (type == "Bind") {
					if (victim.Buff != "Locked") {
						victim.Buff = "Bound";
						victim.Emote.gotoAndStop("Bound");
					}
					damage2 = damage;
				} else if (type == "Warp") {
					damage2 = damage;
					victim._y = -100;
				} else if (type == "Suicide") {
					damage2 = damage;
					player.Buff = "Dual Curse";
				} else if (type == "Poison") {
					victim.Buff = "Poison";
					victim.Emote.gotoAndStop("Poison");
					damage2 = damage;
				} else if (type == "Lock") {
					victim.Buff = "Locked";
					victim.Emote.gotoAndStop("Locked");
					damage2 = damage;
				} else if (type == "Cripple") {
					damage2 = damage;
					victim.Buff = "Crippled";
					victim.Emote.gotoAndStop("Crippled");
				} else if (type == "Stats") {
					damage += (victim.STR + victim.CON + victim.VIT + victim.AGI) * 2;
					damage2 = Math.round(damage);
				} else if (type == "Fate") {
					victim.Buff = "Dual Curse";
					player.Buff = "Curse";
					wookee = Math.round(vicDef / 2);
					damage2 = damage - wookee;
				} else if (type == "Terror") {
					victim.Buff = "Terror";
					victim.Emote.gotoAndStop("Terror");
					wookee = Math.round(vicDef / 2);
					damage2 = damage - wookee;
				} else if (type == "Lift") {
					victim._y -= 80;
					wookee = Math.round(vicDef / 2);
					damage2 = damage - wookee;
				} else if (type == "Caprice") {
					Bubbles = int(Math.random() * 100) + 1;
					if (Bubbles > 80) {
						victim.Buff = "Terror";
						victim.Emote.gotoAndStop("Terror");
					} else if (Bubbles > 60) {
						victim.Buff = "Crippled";
						victim.Emote.gotoAndStop("Crippled");
					} else if (Bubbles > 40) {
						victim.Buff = "Locked";
						victim.Emote.gotoAndStop("Locked");
					} else if (Bubbles > 20) {
						victim.Buff = "Poison";
						victim.Emote.gotoAndStop("Poison");
					} else if (Bubbles > 0) {
						victim.Buff = "Curse";
						victim.Emote.gotoAndStop("Curse");
					}
					damage2 = Math.round(damage / 2);
				} else if (type == "Drain") {
					wookee = Math.round(vicDef / 2);
					damage2 = damage - wookee;
					_root.buff(player,Math.round(damage2 / 2),"Heal");
				} else if (type == "Poison2") {
					victim.Buff = "Poison 2";
					victim.Emote.gotoAndStop("Poison");
					damage2 = damage;
				} else if (type == "Mute") {
					victim.Buff = "Mute";
					victim.Emote.gotoAndStop("Mute");
					damage2 = damage;
				}
				if (damage2 < 1) {
					damage2 = 1;
				}
				victim.HP -= Math.round(damage2);
				player.damageAccu += Math.round(damage2);
				trace("player damage accu add " + damage2 + " now at " + player.damageAccu);
				//Pushing
				if (type == "Push" || type == "Push2" || type == "Scatter") {
					amount = 80;
					if (type == "Push2") {
						amount = 100;
					} else if (type == "Scatter") {
						amount = _root.getRandomBetween(50, 180);
					}
					if (victim.disposition == "Defender") {
						amount -= 80;
					}
					if (_root.BG._currentframe == 9) {
						amount += 20;
					}
					if (victim._x < player._x) {
						_root.playerWalk(victim,1,amount);
						//victim._x -= amount;
					} else {
						_root.playerWalk(victim,2,amount);
						//victim._x += amount;
					}
				}
				//Shackling                        
				if (type == "Shackle") {
					victim.walkable = false;
					victim.trapTimer = 60;
					//damage2 = damage;
				}
				//Biding                                                                                   
				if (victim.Buff == "Bide") {
					victim.combo += damage2;
				}
				//Counter                                                                                   
				if (victim.disposition == "Counter" || victim.Buff == "Counter") {
					if (victim._currentframe < 10) {
						victim.combo = damage2;
						victim.gotoAndPlay("Counter");
					}
				}
				if (victim.disposition == "Guard") {
					Bubblez = int(Math.random() * 100) + 1;
					if (victim._currentframe < 10 && Bubblez < victim.guardChance) {
						damage2 = 0;
						victim.Emote.gotoAndPlay("Guarded");
						victim.gotoAndPlay("Guard");
					}
				}
				if (victim.Buff == "En Garde") {
					Bubblez = int(Math.random() * 100) + 1;
					if (victim._currentframe < 10 && Bubblez < victim.guardChance) {
						damage2 = 0;
						victim.Emote.gotoAndPlay("Guarded");
						victim.gotoAndPlay("Walk");
					}
				}
				//Complete Guard                                                                           
				//Party ATK               
				if (type == "Party") {
					for (var t = 0; t <= _root.charsAry.length; t++) {
						//Check if they're on the team
						myTeam = checkTeams(victim, charsAry[t]);
						if (myTeam == true) {
							charsAry[t].HP -= damage2;
							attachMovie("numberfly","number" + damageNum,damageNum + 10000);
							_root["number" + damageNum]._x = charsAry[t]._x;
							_root["number" + damageNum]._y = charsAry[t]._y - 10;
							_root["number" + damageNum].var123 = Math.round(damage2);
						}
					}
				}
				//damageFinal =                                                                                                                                                             
				//damage display numbers
				attachMovie("numberfly","number" + damageNum,damageNum + 10000);
				_root["number" + damageNum]._x = victim._x;
				_root["number" + damageNum]._y = victim._y - 10;
				_root["number" + damageNum].var123 = Math.round(damage2);
				if (crit == true) {
					_root["number" + damageNum].gotoAndPlay("Crit");
				}
				damageNum++;
				if (damageNum > 20) {
					damageNum = 1;
				}
				//Curse Effects                                                                                                                                  
				if (player.Buff == "Curse" || player.Buff == "Dual Curse") {
					player.HP -= Math.round(damage2 / 2);
					attachMovie("numberfly2","number" + damageNum,damageNum + 10000);
					_root["number" + damageNum]._x = player._x;
					_root["number" + damageNum]._y = player._y - 10;
					_root["number" + damageNum].var123 = Math.round(damage2 / 2);
					damageNum++;
					if (damageNum > 20) {
						damageNum = 1;
					}
				} else {
					if (_root.HPDrain._currentframe == 2) {
						player.HP += Math.round(damage2 / 2);
					}
				}
				//Are they stacked?
				if (player.bodyArea.hitTest(victim.bodyArea) && victim.disposition != "Player") {
					victim.charAct = "Fleeing";
					victim.walkTimer = 12;
					//victim.Emote.gotoAndPlay("Flee");
					victim._xscale *= -1;
				}
				//Kill of victim if applicable                                                                                              
				if (victim.HP <= 0) {
					if (victim.Buff == "Protection") {
						_root.buff(victim,Math.round(victim.highestHP / 2),"HealSelf");
						victim.Buff = "None";
					} else {
						victim.HP = 0;
						victim.charDie(player);
					}
				}
				if (player.HP <= 0) {
					player.HP = 0;
					player.charDie(player);
				}
				if (victim.Buff == "Autoheal") {
					_root.buff(victim,50,"Heal");
				}
				//Victim decides if they wish to flee                                                                                                                                                                            
				if ((victim.HP < 800 || victim.disposition == "Coward") && victim.disposition != "Player") {
					Bubbles = (int(Math.random() * (victim.HP / 2)) + victim.STR);
					if (victim.disposition == "Coward") {
						Bubbles -= 100;
					}
					if (Bubbles <= 25 && victim.disposition != "Fearless") {
						victim.charAct = "Fleeing";
						victim.walkTimer = 40;
						victim.Emote.gotoAndPlay("Flee");
						victim._xscale *= -1;
					}
				}
				if (type == "Single") {
					break;
				}
			}
		}
		//break;                                                                                                       
	}
}
//ranged
function attack2(player, damage, type) {
	player.attackAccu++;
	//Check enemies attacking
	hitDiv = 0;
	for (var q = 0; q <= _root.charsAry.length; q++) {
		//Check if they're on the team
		myTeam = checkTeams(player.caster, charsAry[q]);
		if (myTeam == false) {
			//Check hitTest
			if (player.atkArea.hitTest(charsAry[q].bodyArea)) {
				hitDiv++;
			}
		}
	}
	for (var q = 0; q <= _root.charsAry.length; q++) {
		//Check if they're on the team
		myTeam = checkTeams(player.caster, charsAry[q]);
		if (myTeam == false) {
			//Check hitTest
			if (player.atkArea.hitTest(charsAry[q].bodyArea)) {
				if (player.caster._xscale == _root.charsAry[q]._xscale && _root.charsAry[q].charAct != "Fleeing") {
					_root.charsAry[q]._xscale *= -1;
				}
				//Hit or Miss?                                                                                                                                                                    
				Stat1 = player.caster.CON + player.caster.Kills;
				Bubblez = int(Math.random() * 50) + 1;
				if (Bubblez == 1) {
					crit = true;
					damage *= 4;
					Stat1 += 100;
				} else {
					crit = false;
				}
				if (victim.charAct == "Sleeping") {
					charsAry[q].charAct = "Fighting";
				}
				wibbit = damage / hitDiv;
				damage = Math.round(wibbit);
				Stat2 = _root.charsAry[q].AGI + charsAry[q].Kills;
				Conv = 80 + Stat1 - (Stat2 / 1.5);
				if (Conv < 5) {
					Conv = 5;
				}
				if (type == "Guided" || type == "Trigger" || type == "Trigger2" || victim.Buff == "Bide") {
					Conv = 100000;
				}
				if (player.caster.Buff == "Targeting" || player.caster.disposition == "Hero" || player.caster.disposition == "Daemon") {
					Conv *= 2;
				}
				if (victim.Buff == "Agility") {
					Conv /= 2;
				}
				if (type == "Trigger") {
					player.atkArea.play();
					player.stop();
				}
				if (type =="Trigger2") {
					player.atkArea.play();
				}
				Bubbles = int(Math.random() * 100) + 1;
				//If miss
				if (Bubbles > Conv) {
					attachMovie("numberfly2","number" + damageNum,damageNum + 10000);
					_root["number" + damageNum]._x = player.caster._x;
					_root["number" + damageNum]._y = player.caster._y - 10;
					_root["number" + damageNum].var123 = "MISS!";
					damageNum++;
					if (damageNum > 20) {
						damageNum = 1;
					}
					if (type != "Trigger2") {
						player.removeMovieClip();
					}
					break;
				}
				//                                                                                                                                                                             
				//break;
				victim = _root.charsAry[q];
				victim.prevFrame();
				victim.Flincher.play();
				//Calculate Damage
				damage += Math.round((player.caster.CON / 20) * (damage / 4));
				if (victim.Buff == "Defender" || victim.Buff == "Full") {
					damage /= 8;
					pool = damage;
					damage = Math.round(pool);
				}
				if (victim.Buff == "Strength" || victim.disposition == "Defender") {
					damage /= 4;
					pool = damage;
					damage = Math.round(pool);
				}
				if (player.caster.Buff == "Strength" || player.caster.Buff == "Full") {
					damage += 50 + (player.caster.CON * 2);
				} else if (player.caster.Buff == "Strength+") {
					damage *= 2;
				}
				if (type != "Sharp") {
					niggs = victim.aDEF;
					subtracting = damage * (niggs / 100);
					damage -= Math.round(subtracting);
				}
				if (type == "Blunt" || type == "Push" || type == "Trigger2") {
					perDef = 1 - (victim.VIT / 1000);
					bloof = Math.round(damage * perDef);
					damage2 = bloof - victim.VIT;
				} else if (type == "Blade" || type == "Guided") {
					wookee = Math.round(victim.VIT / 2);
					damage2 = damage - wookee;
				} else if (type == "Sharp") {
					damage2 = damage;
				} else if (type == "Vital") {
					wooo = Math.round(victim.HP / 10);
					damage2 = damage + wooo;
				} else if (type == "Terror") {
					victim.Buff = "Terror";
					victim.Emote.gotoAndStop("Terror");
					damage2 = damage;
				} else if (type == "Enslave") {
					if (victim.Buff != "Locked") {
						victim.Buff = "Bound";
						victim.Emote.gotoAndStop("Bound");
					}
					damage2 = damage;
				} else if (type == "Poison") {
					victim.Buff = "Poison";
					victim.Emote.gotoAndStop("Poison");
					damage2 = damage;
				} else if (type == "Trap") {
					victim.walkable = false;
					victim.trapTimer = 30;
					damage2 = damage;
				} else if (type == "Trap2") {
					victim.walkable = false;
					victim.trapTimer = 50;
					damage2 = damage;

				} else if (type == "Release") {
					victim.walkable = true;
					damage2 = damage;
				}
				if (damage2 < 1) {
					damage2 = 1;
				}
				testDam = damage2 * 0;
				if (testDam != 0) {
					damage2 = 100;
				}
				victim.HP -= damage2;
				player.caster.damageAccu += damage2;
				//Biding 
				if (victim.Buff == "Bide") {
					victim.combo += damage2;
				}
				//Counter                                                                                   
				if (victim.disposition == "Counter") {
					if (victim._currentframe < 10) {
						victim.combo = damage2;
						victim.gotoAndPlay("Counter");
					}
				}
				//Pushing                                                                                  
				if (type == "Push" || type == "PushM") {
					amount = 80;
					if (type == "PushM") {
						amount /= 2;
					}
					if (victim.disposition == "Defender") {
						amount -= 80;
					}
					if (_root.BG._currentframe == 9) {
						amount = 100;
					}
					if (victim._x < player._x) {
						victim._x -= amount;
					} else {
						victim._x += amount;
					}
				} else {
					if (type != "Trigger" && type != "Trap" && victim.walkable == true) {
						pushAmount = 6;
					} else {
						pushAmount = 0;
					}
				}
				if (victim._x < player._x) {
					_root.playerWalk(victim,2,pushAmount);
					//victim._x -= amount;
				} else {
					_root.playerWalk(victim,1,pushAmount);
					//victim._x += amount;
				}                            
				//damage display numbers
				_root.attachMovie("numberfly","number" + damageNum,damageNum + 10000);
				_root["number" + damageNum]._x = victim._x;
				_root["number" + damageNum]._y = victim._y - 10;
				_root["number" + damageNum].var123 = Math.round(damage2);
				if (crit == true) {
					_root["number" + damageNum].gotoAndPlay("Crit");
				}
				damageNum++;
				if (damageNum > 20) {
					damageNum = 1;
				}
				if (player.caster.Buff == "Curse" || player.caster.Buff == "Dual Curse") {
					player.caster.HP -= Math.round(damage2 / 2);
					attachMovie("numberfly2","number" + damageNum,damageNum + 10000);
					_root["number" + damageNum]._x = player.caster._x;
					_root["number" + damageNum]._y = player.caster._y - 10;
					_root["number" + damageNum].var123 = Math.round(damage2 / 2);
					damageNum++;
					if (damageNum > 20) {
						damageNum = 1;
					}
				} else {
					if (_root.HPDrain._currentframe == 2) {
						player.caster.HP += Math.round(damage2 / 2);
					}
				}
				//Kill off the victim                                                  
				if (victim.HP <= 0) {
					if (victim.Buff == "Protection") {
						_root.buff(victim,Math.round(victim.highestHP / 2),"HealSelf");
						victim.Buff = "None";
					} else {
						victim.HP = 0;
						victim.charDie(player.caster);
					}
				}
				if (player.caster.HP <= 0) {
					player.caster.HP = 0;
					player.caster.charDie(player.caster);
				}
				if (victim.Buff == "Autoheal") {
					_root.buff(victim,20,"Heal");
				}
				//Victim decides if they wish to flee                                                                                                                                                                            
				if (victim.HP < 800 && victim.disposition != "Player") {
					Bubbles = (int(Math.random() * (victim.HP / 2)) + victim.STR);
					if (Bubbles <= 25 && victim.disposition != "Fearless") {
						victim.charAct = "Fleeing";
						victim.walkTimer = 40;
						victim.Emote.gotoAndPlay("Flee");
						victim._xscale *= -1;
					}
				}
				if (type != "Trigger" && type != "Trap" && type != "Trap2" && type != "Trigger2" && type != "Enslave") {
					player.removeMovieClip();
				}
			}
		}
	}
}
function buff(player, healAmount, type) {
	if (player.Buff != "Mute") {
		for (var q = 0; q <= _root.charsAry.length; q++) {
			//Check if they're on the team
			//if (_root.charsAry[q] != this) {
			myTeam = checkTeams(player, charsAry[q]);
			if (myTeam == true) {
				//if (player.healArea.hitTest(charsAry[q].bodyArea)) {
				if (type == "Heal") {
					charsAry[q].Emote.gotoAndPlay("Heal");
					juun = charsAry[q].highestHP;
					bloop = charsAry[q].HP;
					bing = bloop + healAmount;
					if (bing >= juun) {
						charsAry[q].HP = juun;
						report("reportHealing", charsAry[q].name, 0, juun);
					} else {
						charsAry[q].HP += healAmount;
						report("reportHealing", charsAry[q].name, 0, healAmount);
					}
					_root.attachMovie("numberfly3","number" + damageNum,damageNum + 10000);
					_root["number" + damageNum]._x = charsAry[q]._x;
					_root["number" + damageNum]._y = charsAry[q]._y - 10;
					_root["number" + damageNum].var123 = healAmount;
					damageNum++;
					if (damageNum > 20) {
						damageNum = 1;
					}
				} else if (type == "Defender") {
					charsAry[q].Emote.gotoAndPlay("Defender");
					charsAry[q].Buff = "Defender";
				} else if (type == "Strength") {
					charsAry[q].Emote.gotoAndPlay("Strength");
					charsAry[q].Buff = "Strength";
				} else if (type == "Levelup") {
					//charsAry[q].Emote.gotoAndPlay("Strength");
					//charsAry[q].levelUp();
					charsAry[q].levelUp();
				} else if (type == "Autoheal") {
					charsAry[q].Emote.gotoAndPlay("Heal");
					charsAry[q].Buff = "Autoheal";
				} else if (type == "Targeting") {
					charsAry[q].Emote.gotoAndPlay("Targeting");
					charsAry[q].Buff = "Targeting";
				} else if (type == "Full") {
					charsAry[q].Emote.gotoAndPlay("Full");
					charsAry[q].Buff = "Full";
					suicide(player,player.STR * 2);
				} else if (type == "Counter") {
					player.Emote.gotoAndPlay("Guarded");
					player.Buff = "Counter";
				} else if (type == "En Garde") {
					player.Emote.gotoAndPlay("Guarded");
					player.Buff = "En Garde";
				} else if (type == "Divinity") {
					charsAry[q].Emote.gotoAndStop("Divinity");
					charsAry[q].Buff = "Divinity";
				} else if (type == "Protection") {
					charsAry[q].Emote.gotoAndStop("Protection");
					charsAry[q].Buff = "Protection";
				} else if (type == "HealSelf") {
					//player.Emote.gotoAndPlay("Heal");
					juun = player.highestHP;
					bloop = player.HP;
					bing = bloop + healAmount;
					if (bing >= juun) {
						player.HP = juun;
					} else {
						player.HP += healAmount;
					}
					_root.attachMovie("numberfly3","number" + damageNum,damageNum + 10000);
					_root["number" + damageNum]._x = player._x;
					_root["number" + damageNum]._y = player._y - 10;
					_root["number" + damageNum].var123 = healAmount;
					damageNum++;
					if (damageNum > 20) {
						damageNum = 1;
					}
				} else if (type == "Strength+") {
					charsAry[q].Emote.gotoAndPlay("Strength");
					charsAry[q].Buff = "Strength+";
				} else if (type == "EXP") {
					_root.awardEXP(charsAry[q],healAmount);
				} else if (type == "Agility") {
					charsAry[q].Emote.gotoAndPlay("Agility");
					charsAry[q].Buff = "Agility";
				}
			}
			//}                                                                                                                                            
		}
	}
}
function awardEXP(player, amount) {
	player.experience += amount;

	if (player.experience >= _root.getEXPreq(player.lvl + 1) && player.lvl < 99) {
		_root.buff(player,20,"Levelup");
		player.lvl++;
		if (player.Buff == "Divinity") {
			_root.buff(player,20,"Levelup");
		}

	}
}
function charDieF(killer) {
	//reward with HP if he's not cursed
	if (killer.Buff != "Dual Curse") {
		killer.HP += (this.Kills * 210) + Math.round(this.highestHP / 10);
		killer.HP += 300;
	}
	killer.Kills++;
	if (killer.Kills == 10) {
		_root.buff(killer,4000,"HealSelf");
	} else if (killer.Kills == 5) {
		_root.buff(killer,1000,"HealSelf");
	} else if (killer.Kills == 20) {
		_root.buff(killer,8000,"HealSelf");
	}
	eyes = killer.infoIndex;
	_root["status" + eyes].Cover.gotoAndPlay("Kill");
	//
	//killer.levelUp();
	if (_root.lvloption == "Kill") {
		_root.buff(killer,0,"Levelup");
		killer.lvl++;
		if (player.Buff == "Divinity") {
			_root.buff(player,20,"Levelup");
		}
	} else {
		expamount = _root.getEXPworth(this.lvl, this.Kills);
		_root.buff(killer,Math.round(expamount / 4),"EXP");
		_root.awardEXP(killer,expamount);
	}
	//killer.buff(killer,this.maxHP,"HealSelf");
	//lvl again?  
	//Is the killer a new record setter?                     
	if (killer.Kills > bestKills) {
		bestKiller = killer.name;
		bestKills = killer.Kills;
		bestKillStat = bestKiller + ", " + bestKills + " kills";
	}
	//By the way if killer is a hunter...... 
	if (killer.name == "Hunter" && _root.checkScout(this, this) == true) {
		killer.gotoAndPlay("FunTime");
	}
	for (var i = 0; i < _root.charsAry.length; i++) {
		if (_root.charsAry[i] == this) {
			// delete self
			_root.charsAry.splice(i,1);
			//blobsAry.splice(i, 1);
		}
	}
	if (killer.Buff == "Terror") {
		Bubbles = int(Math.random() * 100) + 1;
		if (Bubbles > 90) {
			suicide(killer,200);
		}
	}
	
	// Reporting functions
	trace(killer.damageAccu + killer.name);
	if (this == killer) {
		report("reportTrapDeath", this.name, this.Kills, this.damageAccu, killer.name);
	} else {
		report("reportKill", killer.name, killer.Kills, killer.damageAccu);
		report("reportDeath", this.name, this.Kills, this.damageAccu, killer.name);
		killer.damageAccu = 0;
	}
	report("reportAttacks", killer.name, 0, killer.attackAccu);
	report("reportAttacks", this.name, 0, this.attackAccu);
	killer.attackAccu = 0;
	
	//If this is the player it means no more player's on        
	if (this.dispositon == "Player") {
		_root.playerSpawned = false;
	}
	this.HP = 0;
	_root.printStats(this);
	//Free up the info space and update displays
	this.HP = "0";
	infoSpotAry[this.infoIndex] = null;
	//Kill itself   
	this.swapDepths(999999999999999);
	this.removeMovieClip();
}
function levelUpF() {
	if (this.Kills > 300) {
		break;
	}
	if (_root.lvloption == "Kill") {
		hpaddamt2 = _root.hpaddamt;
		stataddamt2 = _root.stataddamt;
		if (this.Kills > 70) {
			modifier = 1.5;
			hpaddamt2 = Math.round(hpaddamt2 / modifier);
			stataddamt2 = Math.round(stataddamt2 / modifier);
		}
	} else {
		hpaddamt2 = Math.round((_root.hpaddamt / 2) * (this.lvl * 1.1));
		stataddamt2 = Math.round(_root.stataddamt + (this.lvl * 1.2));
	}
	this.highestHP += hpaddamt2;
	this.Emote.gotoAndStop("Levelup");
	if (_root.levelType._currentframe == 1) {
		Bubbles = int(Math.random() * 5) + 1;
		if (Bubbles == 1) {
			this.STR += stataddamt2;
			showLevelstat(this,"STR");
		} else if (Bubbles == 2) {
			this.VIT += stataddamt2;
			showLevelstat(this,"VIT");
		} else if (Bubbles == 3) {
			this.CON += stataddamt2;
			showLevelstat(this,"CON");
		} else if (Bubbles == 4) {
			this.AGI += stataddamt2;
			showLevelstat(this,"AGI");
		} else if (Bubbles == 5) {
			this.highestHP += hpaddamt2;
			showLevelstat(this,"HP");
		}
	} else {
		Bubbles2 = int(Math.random() * 100) + 1;
		statAGI = (this.STRpercent + this.VITpercent + this.CONpercent) * 100;
		statCON = (this.STRpercent + this.VITpercent) * 100;
		statVIT = this.STRpercent * 100;
		statSTR = 0;
		if (Bubbles2 > statAGI) {
			this.AGI += stataddamt2 / 2;
			showLevelstat(this,"AGI");
		} else if (Bubbles2 > statCON) {
			this.CON += stataddamt2 / 2;
			showLevelstat(this,"CON");
		} else if (Bubbles2 > statVIT) {
			this.VIT += stataddamt2 / 2;
			showLevelstat(this,"VIT");
		} else {
			this.STR += stataddamt2 / 2;
			showLevelstat(this,"STR");
		}
		Bubbles = int(Math.random() * 5) + 1;
		if (Bubbles >= 4) {
			this.highestHP += hpaddamt2;
		}
	}
	if (_root.lvloption != "Kill" && this.lvl > 5) {
		_root.buff(this,this.highestHP - this.HP,"HealSelf");
	}
}
//}
function showLevelstat(target, stat) {
	_root.attachMovie("numberfly4","number" + damageNum,damageNum + 11000);
	_root["number" + damageNum]._x = target._x;
	_root["number" + damageNum]._y = target._y - 10;
	_root["number" + damageNum].var123 = stat + " UP!";
	damageNum++;
	if (damageNum > 20) {
		damageNum = 1;
	}
}

function respawnChars() {
	for (var i = 0; i < _root.charsAry.length; i++) {
		ranChance = int(Math.random() * 150) + 1;
		if (ranChance <= 25) {
			//NW
			xCoord = 21;
			yCoord = 90;
		} else if (ranChance > 25 && ranChance <= 50) {
			//NE
			xCoord = 675;
			yCoord = 90;
		} else if (ranChance > 50 && ranChance <= 75) {
			//SW
			xCoord = 21;
			yCoord = 428;
		} else if (ranChance > 75 && ranChance <= 100) {
			//SE
			xCoord = 675;
			yCoord = 428;
		} else if (ranChance > 100) {
			xCoord = int(Math.random() * 699) + 2;
			yCoord = int(Math.random() * 20) - 25;
		}
		_root.charsAry[i]._x = xCoord;
		_root.charsAry[i]._y = yCoord;
	}
}

function checkTeams(guy1, guy2) {
	myTeam = false;
	if (guy1.name == "Hunter") {
		return false;
	}
	if (guy1 == guy2) {
		return true;
	}
	//If it's yourself and civil's off, true                                                                                    
	if (guy1.name == guy2.name && _root.civilWar._currentframe == 1) {
		myTeam = true;
	}
	//if it's a teammate, true                                                                                                           
	if (guy1.Team == guy2.Team && guy1.Team != 0) {
		myTeam = true;
	}
	//only enemy is daemon                                                                                                           
	if (_root.civilWar._currentframe == 3 && guy2.disposition != "Daemon" && guy1.disposition != "Daemon") {
		myTeam = true;
	}
	if (_root.civilWar._currentframe == 3 && guy1.disposition == "Daemon" && guy2.disposition == "Daemon") {
		myTeam = true;

	}
	//only enemy ss hero                                                                                                           
	if (_root.civilWar._currentframe == 4 && guy2.disposition != "Hero" && guy1.disposition != "Hero") {
		myTeam = true;
	}
	if (_root.civilWar._currentframe == 4 && guy1.disposition == "Hero" && guy2.disposition == "Hero") {
		myTeam = true;
	}
	//only enemy are aces      
	if (_root.civilWar._currentframe == 5 && guy2.disposition != "Player" && guy1.disposition != "Player") {
		myTeam = true;
	}
	if (_root.civilWar._currentframe == 5 && guy1.disposition == "Player" && guy2.disposition == "Player") {
		myTeam = true;
	}
	//Vulcan & Imp                                                                         
	if (((guy1.name == "Imp" && guy2.name == "Vulcan") || (guy2.name == "Imp" && guy1.name == "Vulcan")) && _root.civilWar._currentframe == 1) {
		myTeam = true;
	}
	//Drogo & Drogo Minion                                                                        
	if (((guy1.name == "Drogo" && guy2.name == "Drogo Minion") || (guy2.name == "Drogo" && guy1.name == "Drogo Minion")) && _root.civilWar._currentframe == 1) {
		myTeam = true;
	}
	//SHELL RULES                                                                                                           
	//if you're not a shell but he is, attack
	if (guy2.name == "Shell" && guy1.name != "Shell") {
		myTeam = false;
	}
	//if you're a shell and he isn't, attack                                                                                                           
	if (guy1.name == "Shell" && guy2.name != "Shell") {
		myTeam = false;
	}
	//If you're a shell and he is no matter what don't attack                                                                                                           
	if (guy1.name == "Shell" && guy2.name == "Shell") {
		myTeam = true;
	}
	//BINARY STAR RULES    
	//If you're not a star but he is
	if (guy2.name == "Binary Star" && guy1.name != "Binary Star") {
		myTeam = false;
	}
	//if you're a star and he isn't, attack                                                                                                           
	if (guy1.name == "Binary Star" && guy2.name != "Binary Star") {
		myTeam = false;
	}
	return myTeam;
}

function minionCount(minionName) {
	count = 0;
	for (var i = 0; i < _root.charsAry.length; i++) {
		if (_root.charsAry[i].name == minionName) {
			// delete self
			count++;
			//blobsAry.splice(i, 1);
		}
	}
	return count;
}

function scoutAI() {
	//Well he's here, let's make 'em grow older.
	this.Age++;
	//The Idle Function
	//First check if he's falling. If falling you can't do shit.
	if (!_root.Ground.hitTest(this._x, this._y + 3, true)) {
		this._y += 5;
		if (this._y > 450) {
			this._y = 0;
			//Random X If Desert arena
			if (_root.BG._currentframe == 2) {
				this._x = int(Math.random() * 699) + 2;
			}
			//Make sure s/he's not out of bounds               
			if (this._x > 700 || this._x < 0) {
				this._x = int(Math.random() * 699) + 2;
			}
		}
	} else {
		if (_root.Ground.hitTest(this._x, this._y, true)) {
			this._y--;
		}
		if (this.charAct != "Fleeing" && this.charAct != "Sleeping") {
			this.charAct = "Idle";
			for (var q = 0; q <= _root.charsAry.length; q++) {
				//Check if they're on the team
				myTeam = _root.checkScout(this, _root.charsAry[q]);
				if (myTeam == true) {
					//if (this.targetChar == null) {
						this.targetChar = charsAry[q];
					//}
					//HP Lows means they may not fight 
					fightChance = 100;
					if (this.HP < 800) {
						this.fightChance -= (this.HP / 8) - 10;
					}
					Bubbles = int(Math.random() * 100) + 1;
					if (Bubbles <= fightChance) {
						if (this.sightArea.hitTest(charsAry[q].bodyArea)) {
							if (this.charAct != "Fighting") {
								this.charAct = "Chase";
								victim = charsAry[q];
							}
						} else if (this.atkArea.hitTest(charsAry[q].bodyArea)) {
							this.charAct = "Fighting";
							victim = charsAry[q];
							this.targetChar = victim;
						} else if (this.sightArea2.hitTest(charsAry[q].bodyArea)) {
							if (this.charAct != "Fighting") {
								this._xscale *= -1;
								// this.textBubble._xscale *= -1;
								//this.charAct = "Chase";
							}
						}
						this.textBubble._xscale = this._xscale;
					} else {
						this.charAct = "Fleeing";
						this.Emote.gotoAndStop("Fleeing");
						this.walkTimer = 40;
						this.HP += 10;
					}
				}
			}
		}
		if (this._currentframe > 2 && this.charAct != "Sleeping") {
			this.charAct = "Fighting";
		}
		//DIE BITCHES                                                                                                                                                                       
		if (this.charAct == "Fighting") {
			this.play();
		}
		//THE CHASE IS ON!                                                                                                                                                                                    
		if (this.charAct == "Chase") {
			//this.gotoAndStop("Walk");
			this.targetChar = victim;
			this.Emote.gotoAndPlay("Chase");
			if (_root.wandering._currentframe == 1) {
				if (victim._x < this._x) {
					this._xscale = 100;
					// this.textBubble._xscale = 100;
					_root.playerWalk(this,2,1.5);
					//this._x -= this.walkSpeed * 1.3;
				} else if (victim._x > this._x) {
					this._xscale = -100;
					// this.textBubble._xscale = -100;
					_root.playerWalk(this,1,1.5);
					//this._x += this.walkSpeed * 1.3;
				}
				this.textBubble._xscale = this._xscale;
			}
		}
		//RUNN TOO THEE HIIILLLSS!                                                                                                                                                                         
		if (this.charAct == "Fleeing") {
			if (_root.wandering._currentframe == 1) {
				this.walkTimer--;
				if (this.walkTimer <= 0) {
					this.charAct = "Idle";
					this.walkTimer = 20;
					this.Buff = "None";
				} else {
					if (this._xscale == -100) {
						_root.playerWalk(this,1,1);
					} else if (this._xscale == 100) {
						_root.playerWalk(this,2,1);
						//this._x -= 2;
					}
				}
			}
		}
		//Control walking                                                                                                                                                                                      
		if (this.charAct == "Idle" || this.charAct == "Fleeing") {
			this.gotoAndStop("Walk");
			if (_root.wandering._currentframe == 1) {
				if (this.walkTimer <= 0) {
					if (this.HP < 1800) {
						this.HP += 20;
					}
					
					this.flip = getRandomBetween(1, 2);
					if (this.flip == 1) {
						this._xscale *= -1;
						// this.textBubble._xscale *= -1;
					}
					this.textBubble._xscale = this._xscale;
					this.walkTimer = getRandomBetween(7, 70);
					if (player.Buff == "Terror") {
						Bubbles = int(Math.random() * 10) + 1;
						if (Bubbles > 8) {
							suicide(this,this.STR * 2);
						}
					}
				} else {
					if (this.walkable == true) {

						this.dir = -(this._xscale / 100);
						_root.playerWalk(this,dir,1);
						//if (this.dir == 1) {
						//this._xscale = -100;
						//this._x += this.walkSpeed;
						//} else {
						//this._xscale = 100;
						//this._x -= this.walkSpeed;
						//}
					} else {
						this.trapTimer--;
						if (this.trapTimer <= 0) {
							this.walkable = true;
						}
					}
					this.walkTimer--;
				}
			}
		}
	}

	//Check for walls 
	//if (_root.Ground.hitTest(_parent._x, _parent._y, true)) {
	//}
	//Poison                                                                                  
	if (this.buff == "Poison" && this.HP > 200) {
		this.HP -= 2;
	}
	if (this.buff == "Poison 2" && this.HP > 200) {
		this.HP -= 10;
	}
	//Change the char's alpha to represent HP loss                                                                                                                                                        
	wahmbolehngwah = (100 * (this.HP / this.highestHP));
	//if (wahmbolehngwah>100) {
	//wahmbolehngwah = 100;
	//}
	//this._alpha = wahmbolehngwah;
	if (wahmbolehngwah < 16) {
		this._alpha = (wahmbolehngwah * 5) + 20;
	} else {
		this._alpha = 100;
	}
	//Has HP Increased? If so, change the maxHP
	if (this.HP > this.highestHP) {
		this.highestHP = this.HP;
	}
	//Desert Wind anybody?                                                                                                                                     
	if (_root.BG._currentframe == 2) {
		this._x -= 2;
	}
	//Print Stats                                                                                                                                                                               
	_root.printStats(this);
	//Depths
	this.swapDepths(6000 + this.infoIndex + this._y);
}

function checkScout(self, inChar) {
	targetNum = inChar.Kills;
	isTarget = true;
	for (var q = 0; q <= _root.charsAry.length; q++) {
		if (_root.charsAry[q].Kills > targetNum && _root.charsAry[q].name != "Hunter") {
			isTarget = false;
		}
	}
	return isTarget;
}

function trapAttack (trap, baseDamage, bonusType) {
	for (var q = 0; q<=_root.charsAry.length; q++) {
		if (trap.atkArea.hitTest(_root.charsAry[q].bodyArea) || bonusType == "AllHit") {
			if (_root.charsAry[q].Buff == "Defender" || _root.charsAry[q].Buff == "Full") {
				continue;
			}
			bonus = 0;
			if (bonusType == "Vit") {
				bonus = _root.charsAry[q].VIT;
			} else if (bonusType == "Kills") {
				bonus = (_root.charsAry[q].Kills * 100);
			} else if (bonusType == "VitKills") {
				bonus = _root.charsAry[q].VIT + (_root.charsAry[q].Kills * 100);
			} else if (bonusType == "HalfHP") {
				bonus = Math.round(_root.charsAry[q].highestHP / 2);
			}
			damage = baseDamage + bonus;
			niggs = _root.charsAry[q].aDEF;
			subtracting = Math.abs(damage * (niggs / 100));
			damage2 = Math.max(1, damage - Math.round(subtracting));
			trace("damage:"+damage+"niggs:"+niggs+"subtracting:"+subtracting+"damage2:"+damage2);
			_root.charsAry[q].HP -= damage2;
			_root.charsAry[q].Flincher.play();
	
			_root.attachMovie("numberfly2","number"+_root.damageNum,_root.damageNum+3000);
			_root["number"+_root.damageNum]._x = _root.charsAry[q]._x;
			_root["number"+_root.damageNum]._y = _root.charsAry[q]._y-10;
			_root["number"+_root.damageNum].var123 = damage2;
			_root.damageNum++;
			if (_root.damageNum>20) {
				_root.damageNum = 1;
			}
			
			if (_root.charsAry[q].HP <= 0) {
				if (_root.charsAry[q].Buff == "Protection") {
					_root.buff(_root.charsAry[q],Math.round(_root.charsAry[q].highestHP / 2),"HealSelf");
					_root.charsAry[q].Buff = "None";
				} else {
					_root.charsAry[q].HP = 0;
					_root.charsAry[q].charDie(_root.charsAry[q]);
				}
			}
		}
	}
}

function report (action, dataTag, data1, data2, data3) {
	if (_root.reporting._currentframe == 1) {
		return;
	}
	
	url = "http://localhost:4001/report?";
	url += "action=" + action + "&";
	url += "dataTag=" + dataTag + "&";
	url += "data1=" + data1 + "&";
	url += "data2=" + data2+ "&";
	url += "data3=" + data3;
	loadVariables(url, "");
}