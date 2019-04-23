// On Frame 1

stop();
//Run settings
//0: Debug off
//1: Display key choices only
//2: Display all decisions
//3: Shows sub-function decisions as well
debug = 1;
testTargets = false;
testItems = true;
startFame = 1;
facilityChance = 75;
topDropChance = 50;
//Runtime Vars
playPaused = false;
projectiles = 0;
itemNotif.itemAry = new Array();
latestNews = "Welcome to Silatria!";
newsTicker = 1;
//spawn floor normally 16
spawnFloorBottom = 15;
treeDistance = 250;
treeBonus = 8;
charNum = 0;
enemyNum = 0;
maxEnemies = 6;
questEnemy = null;
questingGuys = "";
_root.gameStage._y = -720;
//Initiation functions
//Init
function initiateTown() {
	monthlyIncome = 0;
	totalIncome = 0;
	monthlyExpenses = 0;
	totalExpenses = 0;
	fame = startFame;
	kills = 0;
	questsDone = 0;
	townName = "Hill Town";
	inventory = new Array();
	//Creates inventory: DOES NOT LOAD FROM SAVES
	initInventory();
	//Init weapon levels: knife-sword-spear-bow-heavy
	weaponLevels = new Array(1, 1, 1, 1, 1);
	//Events in the game by fame
	fameEvents = new Array();
	setFameEvents();
	questQueue = new Array("Benjourn");
	//Soveran members training here
	townRoster = new Array();
	//All friendly characters
	players = new Array();
	//All unfriendly characters
	enemies = new Array();
	//Buildings List: There are 33 slots
	buildings = new Array(33);
	built = 0;
	linkBuildings();
	//Place starter facilities
	setFacility("Inn",27);
	setFacility("Weapon Shop",26,15);
	setFacility("Guard Post",29);
	//Introduce the initial character
	introduceChar("Aude Auteberry",1);
	introduceChar("Kavaan Rhiordall",1);
	introduceChar("Quinton Gerrart",1);
	//introduceChar("Armadus Broghton",1);
	//introduceChar("Elias Odremont",1);
	//introduceChar("Kazash Amir",1);
	//introduceChar("Hora Danibel",1);
	//townRoster[1] = "Elias Odremont";
	//townRoster[2] = "Kavaan Rhiordall";
	//basic vars for town startup
	money = 3000;
	townDate = new Array(1, 1, 5685, 1);
	medalsLeft = 0;
	healthKits = 10;
	//Make some enemies
	spawnRandomMob(true);
	spawnRandomMob(true);
	spawnRandomMob(true);
	spawnRandomMob(true);
	spawnRandomMob(true);
	spawnRandomMob(true);
	//spawnRandomMob(false, 200, 785, "Crescent");
	if (testItems) {
		getItem("Elixir",5);
		//getItem("Herbs",5);
		getItem("Archers' Codex",3);
		getItem("Power Compendium",3);
		//getItem("Distilled Boredom",1);
	}
}
//Functions for init
function linkBuildings() {
	for (i = 0; i < buildings.length; i++) {
		buildings[i] = _root.gameStage["building" + i];
		buildings[i].ID = i;
		buildings[i].buildType = "Empty";
	}
	//Also initiate caves and fields
	_root.gameStage.cave0.buildType = "Ice Pit";
	_root.gameStage.cave1.buildType = "Cavern";
	_root.gameStage.cave2.buildType = "Bloody Hole";
	_root.gameStage.cave3.buildType = "Hell's Entrance";
	_root.gameStage.field.buildType = "City Gates";
	_root.gameStage.field.oType = "Landmark";
}
/*Set characters only has a list of names.
It will check the roster initially and add characters
to the stage based on the roster. It assumes characters
are initiated*/
function setCharacters() {
	for (i = 0; i < townRoster.length; i++) {
		//place on stage based on x/y saved
		//give them a starting walk timer

		//glue functions, init Vars

		//refresh weapon
	}
}
/*Glue function: adds runtime vars and functions to char*/
function glueFunctions(target) {
	target.canMove = true;
	target.statusEffect = "Nothing";
	target.curState = "Idle";
	target.reviveTimer = 1000;
	target.pureIdle = 0;
	if (target.charName == "Aude Auteberry") {
		target.onEnterFrame = audeAI;
	} else {
		target.onEnterFrame = charAI;
	}
	//target.setTarget = setTargetF;
	//target.attack = attackF;
	//target.killed = killedP;

}
/*Introduce characters for the first time. Sets x/y to the
town entrance. Initiates their stats and runtime variables.
*/
function introduceChar(charName, initType) {
	//Declare this player has joined the town's ranks
	townRoster.push(charName);
	//Make the player object
	_root.gameStage.attachMovie(charName,"playerMC" + charNum,charNum + 50);
	_root.gameStage.attachMovie("damageNum2","HeroNumMC" + charNum,charNum + 7050);
	_root.gameStage["playerMC" + charNum].charName = charName;
	_root.gameStage["playerMC" + charNum].ID = charNum;
	//Set stats with character's unique init function
	_root.initStats(_root.gameStage["playerMC" + charNum]);
	//Sets constant vars, unique for each char
	_root.initVars(_root.gameStage["playerMC" + charNum]);
	glueFunctions(_root.gameStage["playerMC" + charNum]);
	//Make them walk right initially
	_root.gameStage["playerMC" + charNum].movDir = 1;
	_root.gameStage["playerMC" + charNum].movTime = 12;
	//Place coordinates
	//305 465
	if (charName == "Aude Auteberry") {
		_root.gameStage["playerMC" + charNum]._x = 305;
		_root.gameStage["playerMC" + charNum]._y = 465;
	} else {
		_root.gameStage["playerMC" + charNum]._x = 10 - getRandomBetween(1, 40);
		_root.gameStage["playerMC" + charNum]._y = 865;
	}
	//Weapon graphic
	refreshWeapon(_root.gameStage["playerMC" + charNum]);
	//Push to players objects array
	players.push(_root.gameStage["playerMC" + charNum]);
	//Introductory dialogue box, if initType isn't 1
	if (initType != 1) {
		_root.useMenu("Welcome","char",_root.gameStage["playerMC" + charNum]);
	}
	//Add depth value                                                                                           
	charNum++;
}
//AI "gameplay" functions
//Character's AI
function charAI() {
	//Only act if game is running
	if (!_root.playPaused) {
		//Check if character is healthy
		//Character will only determine new course of action
		//If HP > 20%
		charHealth = (this.curHP / this.maxHP) * 100;
		firstGoal = this.destinations[0];
		if (charHealth <= 0) {
			//We're fucking dead!
			if (this._currentframe == 1) {
				this.gotoAndStop("Dead");
			}
			this.timerBar._xscale = reviveTimer / 20;
			if (reviveTimer <= 0) {
				_root.buff(this,"Heal",_root.getRandomBetween(20, this.maxHP));
				traceF(this.charName + " is back in action!",1);
				_root.speech(this,"Heal");
				this.gotoAndStop("Stand");
				reviveTimer = 1000;
			} else if (reviveTimer == 800 || reviveTimer == 700) {
				_root.callForHelp(this);
			}
			reviveTimer--;
			return;
		}
		if (charHealth < 40 && firstGoal.oType != "Enemy") {
			//char has little health. Go to inn
			firstGoal = this.destinations[0];
			if (firstGoal.buildType != "Inn") {
				traceF(this.charName + " is low on health!",1);
				_root.addDestination(this,_root.buildings[_root.findBuildID("Inn")],1);
				determineTownGoals(this);
			}
			//Character has a goal (The Inn). Get to it                                                                                                                                                                                                                                                                                      
			//trace("Travel");
			_root.chaseGoal(this);
		} else {
			//trace ("Healthy");
			//Check if the character has current destinations
			//If yes, the focus should be getting there
			if (firstGoal != null) {
				//Character has a goal. Get to it
				//trace("Travel");
				_root.chaseGoal(this);
				//Will continue to chase goal until no goals
			} else {
				//No goals.. Let's idle.
				//curState = "Idling";
				_root.idleAbout(this);
			}
		}
	}
}
//Character's AI
function audeAI() {
	//Only act if game is running
	if (!_root.playPaused) {
		//Check if character is healthy
		//Character will only determine new course of action
		//If HP > 20%
		charHealth = (this.curHP / this.maxHP) * 100;
		firstGoal = this.destinations[0];
		if (charHealth <= 0) {
			//We're fucking dead!
			//if (this.curState != "Climbing") {
			//this.gotoAndStop("Dead");
			//}
			this.timerBar._xscale = reviveTimer / 20;
			if (reviveTimer <= 0) {
				_root.buff(this,"Heal",_root.getRandomBetween(20, this.maxHP));
				traceF(this.charName + " is back in action!",1);
				_root.speech(this,"Heal");
				this.gotoAndStop("Stand");
				reviveTimer = 1000;
			} else if (reviveTimer == 800 || reviveTimer == 700) {
				_root.callForHelp(this);
			}
			reviveTimer -= 2;
			return;
		}
		if (charHealth < 40 && firstGoal.oType != "Enemy") {
			//char has little health. Go to inn
			if (firstGoal.buildType != "Inn") {
				//traceF(this.charName + " is low on health!",1);
				_root.addDestination(this,_root.buildings[_root.findBuildID("Inn")],1);
				_root.determineTownGoals(this);
			}
			//Character has a goal (The Inn). Get to it                                                                                                                                                                                                                                                                                      
			//curState = "Traveling";
			//trace("Travel");
			_root.chaseGoal(this);
		} else {
			//trace ("Healthy");
			//Check if the character has current destinations
			//If yes, the focus should be getting there
			if (firstGoal != null) {
				//Character has a goal. Get to it
				//trace("Travel");
				_root.chaseGoal(this);
				//Will continue to chase goal until no goals
			} else {
				//No goals.. Let's idle.
				if (this._currentframe != 1) {
					return;
				}
				//Idling means no destinations                              
				this.destinations.splice(0,this.destinations.length);
				//curState = "Idling";                                
				if (this.movTime <= 0) {
					curState = "Idling";
					//Make some decisions of where to go
					decision = _root.getRandomUnder(10);
					if (decision >= 6) {
						//Stand
						this.movDir = 2;
					} else if (decision >= 3) {
						//Go Left
						this.movDir = 0;
					} else {
						//Go Right
						this.movDir = 1;
					}
					this.movTime = _root.getRandomBetween(15, 50);
					//traceF(target.charName + " wanders around.",2);
					choice = _root.getRandomUnder(21);
					if (choice > 20) {
						pickOne = _root.getRandomBetween(1, _root.enemies.length) - 1;
						_root.addDestination(this,_root.enemies[pickOne],1);
						_root.speech(this,"Let's go fight!");
						_root.addDestination(this,_parent.cave2,2);
						return;
					} else if (choice > 18) {
						_root.determineTownGoals(this);
					} else if (choice > 15) {
						for (k = 0; k < _root.players.length; k++) {
							xDis = Math.round(_root.players[k]._x - this._x);
							yDis = Math.round(_root.players[k]._y - this._y);
							distCalc = Math.round(Math.sqrt((xDis * xDis) + (yDis * yDis)));
							if (distCalc < 450 && _root.players[k].curHP <= 0 && this.hKits > 0 && this.destinations[0].oType != "Hero") {
								_root.addDestination(this,_root.players[k],1);
								_root.speech(this,"I'm coming!");
							}
						}
						return;
					}
				} else {
					if (this.movDir == 0) {
						//Moving LEFT
						//traceF("Move Left");
						_root.moveLeft(this,this.walkSpeed);
						//We've passed the stairs
						if (this._x <= 35) {
							//Re-analyze
							this.movDir = 1;
						}
					} else if (this.movDir == 1) {
						//Moving RIGHT
						_root.moveRight(this,this.walkSpeed);
						//Passed Stairs
						if (this._x >= 360) {
							this.movDir = 0;
						}
					} else {
						//Standing
						if (_root.buildings[_root.findBuildID("Inn")]._y != this._y && this.destinations[0] == null) {
							//if (firstGoal.buildType != "Inn") {
							_root.addDestination(this,_root.buildings[_root.findBuildID("Inn")],1);

							return;
							//}
						}
					}
					//Check for enemies
					for (k = 0; k < _root.enemies.length; k++) {
						if (this.frontSight.hitTest(_root.enemies[k].bodyArea)) {
							//MAYBE add to attack list
							if (_root.getRandomUnder(10) > 2) {
								_root.addDestination(this,enemies[k],1);
								break;
							}
						}
						if (this.rearSight.hitTest(_root.enemies[k].bodyArea)) {
							if (_root.getRandomUnder(10) > 6) {
								this._xscale *= -1;
								this.movTime = 0;
								break;
							}
						}
					}

				}
				this.movTime--;
			}
		}
	}
}
//ROAMING AI
function idleAbout(target) {
	//If not free, don't walk
	if (target._currentframe != 1) {
		return;
	}
	target.pureIdle++;
	if (target.pureIdle > 500) {
		traceF(target.charName + " is bored.",1);
		choice = getRandomUnder(20);
		if (choice > 6 && choice < 15) {
			pID = findBuildID("Pharmacy");
			if (target.hKits <= 0 && pID != null) {
				speech(target,"Need Health Kits");
				addDestination(this,buildings[pID],2);
			} else {
				addDestination(target,target._parent.field,2);
			}
		} else if (choice > 15) {
			pickOne = getRandomBetween(0, enemies.length - 1);
			addDestination(target,enemies[pickOne],2);
		} else {
			determineTownGoals(target);
			addDestination(target,target._parent.cave2,2);
		}
	}
	if (target.movTime <= 0) {
		target.curState = "Idling";
		if (target.questing == true && questEnemy != null) {
			//if (target.curHP < target.maxHP) {
			//addDestination(target,findBuildID("Inn"),1);
			//addDestination(target,questEnemy,2);
			//} else {
			addDestination(target,questEnemy,1);
			//}
			return;
		}
		//Make some decisions of where to go                                                                         
		decision = getRandomUnder(10);
		if (decision <= 2) {
			//Stand
			target.destinations.splice(0,target.destinations.length);
			target.movDir = 2;
		} else if (decision <= 6) {
			//Go Left
			target.movDir = 0;
		} else {
			//Go Right
			target.movDir = 1;
		}
		target.movTime = getRandomBetween(5, 50);
		traceF(target.charName + " wanders around.",2);
	} else {
		if (target.movDir == 0) {
			//Moving LEFT
			//traceF("Move Left");
			moveLeft(target,target.walkSpeed);
			//We've passed the stairs
			if (target._x <= 35) {
				shouldClimb = getRandomUnder(100);
				//Stairdir 1-UP 2-DOWN
				stairDir = determineStairs(35, target._y);
				curFloor = getFloor(target._y);
				shouldClimb += climbChance(curFloor, stairDir);
				if (stairDir == 1 && shouldClimb < 40) {
					//go Up
					climbStair(target,1);
					target.pureIdle -= 40;
					traceF(target.charName + " idly climbs up to " + (getFloorWName(target._y - 80)) + ".",2);
				} else if (stairDir == 2 && shouldClimb < 40) {
					//go down
					climbStair(target,2);
					target.pureIdle -= 40;
					traceF(target.charName + " idly climbs down to " + (getFloorWName(target._y + 80)) + ".",2);

				} else {
					//Re-analyze
					target.movDir = 1;
				}
			}
		} else if (target.movDir == 1) {
			//Moving RIGHT
			moveRight(target,target.walkSpeed);
			//Passed Stairs
			if (target._x >= 360) {
				shouldClimb = getRandomUnder(100);
				stairDir = determineStairs(360, target._y);
				curFloor = getFloor(target._y);
				shouldClimb += climbChance(curFloor, stairDir);
				if (stairDir == 1 && shouldClimb < 40) {
					//go Up
					climbStair(target,1);
					target.pureIdle -= 40;
					traceF(target.charName + " idly climbs up to " + (getFloorWName(target._y - 80)) + ".",2);
				} else if (stairDir == 2 && shouldClimb < 40) {
					//go down
					climbStair(target,2);
					target.pureIdle -= 40;
					traceF(target.charName + " idly climbs down to " + (getFloorWName(target._y + 80)) + ".",2);

				} else {
					//Re-analyze
					target.movDir = 0;
				}
			}
		} else {
			//Standing
		}
		//Check for enemies
		for (k = 0; k < enemies.length; k++) {
			if (target.frontSight.hitTest(enemies[k].bodyArea)) {
				//MAYBE add to attack list
				if (getRandomUnder(10) > 2) {
					addDestination(target,enemies[k],1);
				}
			}
			if (target.rearSight.hitTest(enemies[k].bodyArea)) {
				if (getRandomUnder(10) > 6) {
					target._xscale *= -1;
					target.movTime = 0;
					break;
				}
			}
		}

	}
	target.movTime--;
}
//PATHFINDING AI
function chaseGoal(target) {
	guy = target.charName;
	//Only walk if not doing anything else
	if (target._currentframe != 1) {
		return;
	}
	//First determine if stairs are needed                                                                                                                                                                                                                                                                                                                
	destY = target.destinations[0]._y;
	curY = target._y;
	//trace("Chase goal y: " + destY + "\nMy y: " + curY);
	//Perform locational check if done walking
	if (target.movTime <= 0) {
		target.pureIdle = 0;
		traceF(guy + " is analyzing...",2);
		if (target.charName == "Aude Auteberry" && target.destinations[0].oType != "Hero" && target.destinations[0].buildType != "Inn" && target.hKits > 0) {
			for (k = 0; k < players.length; k++) {
				xDis = Math.round(players[k]._x - target._x);
				yDis = Math.round(players[k]._y - target._y);
				distCalc = Math.round(Math.sqrt((xDis * xDis) + (yDis * yDis)));
				if (distCalc < 250 && players[k].curHP <= 0) {
					addDestination(target,players[k],1);
					speech(target,"I'm coming!");
				}
			}
		}
		//speech(target,"Where to go..");                                                            
		if (destY > curY) {
			//Target is lower than the character
			//Find Stairs DOWN (0)
			heightMatch = 0;
			curState = "Traveling";
		} else if (destY < curY) {
			//Target is higher than the character
			//Find Stairs UP (1)
			heightMatch = 1;
			curState = "Traveling";
		} else if (destY == curY) {
			//Same floor
			heightMatch = 3;
			curState = "Approaching";
		} else {
			//Can't find a match.. fuck it!
			target.destinations.shift();
		}
		if (heightMatch != 3) {
			stairDir = getStairs(curY, heightMatch);
			if (stairDir == 0) {
				//stairs to Left, go Left
				_root.moveLeft(target,target.walkSpeed);
				///Time is max distance over speed
				target.movDir = 0;
				target.movTime = Math.round(400 / target.walkSpeed);
				//trace("Setting movTime to " + target.movTime);
				traceF(guy + " goes left",2);
			} else {
				//Stairs to right, go right
				_root.moveRight(target,target.walkSpeed);
				target.movDir = 1;
				target.movTime = Math.round(400 / target.walkSpeed);
				//trace("Setting movTime to " + target.movTime);
				traceF(guy + " goes right",2);
			}
		} else {
			//Target and Character on the same floor
			destX = target.destinations[0]._x;
			curX = target._x;
			traceF(guy + " is on the target floor, with " + target.destinations[0],2);
			//Move towards target on X plane
			if (destX < curX) {
				//Target is to the left
				_root.moveLeft(target,target.walkSpeed);
				///Time is max distance over speed
				target.movDir = 0;
				traceF(guy + " needs to move left to: " + destX,2);
				target.movTime = Math.round(50 / target.walkSpeed);
			} else {
				//Target is to the right
				_root.moveRight(target,target.walkSpeed);
				///Time is max distance over speed
				traceF(guy + " needs to move right to: " + destX,2);
				target.movDir = 1;
				target.movTime = Math.round(50 / target.walkSpeed);
			}
		}
	} else {
		//movTime > 0.. Let's act
		target.movTime--;
		//Besides moving, check for targets.                              
		goalMC = target.destinations[0];
		if (target.bodyArea.hitTest(goalMC.bodyArea) && goalMC.oType != "Enemy") {
			//We've reached the destination. Building? Enter it.
			if (goalMC.oType == "Building") {
				if (goalMC.curHP > 0) {
					//target.gotoAndPlay("building");
					useFacility(target,goalMC);
					//curState = "Indoors";
				} else {
					speech(target,"Destroyed!");
					subtractSatisfaction(target,1);
					if (goalMC.buildType == "Inn") {
						target.curHP = target.maxHP;
					}
				}
			}
			//Subtract it from the array                                                                                                                                                                                                                                                                
			//remove if not an enemy
			if (target.destinations.length > 1) {
				//There are more destinations. Simply check off
				traceF(target.charName + " has reached a target, the " + findBuildType(target.destinations[0]),1);
				target.destinations.shift();
				traceF("Next Destination: " + findBuildType(target.destinations[0]) + " on " + getFloorWName(target.destinations[0]._y),1);
				traceF("Remaining destinations: " + target.destinations.length);
				//traceF(target.destinations,1);
			} else {
				//That was the last destination.
				if (target.destinations[0].oType != "Landmark" && target.charName != "Aude Auteberry") {
					//If the last destination wasn't a field, make it one
					target.destinations.push(target._parent.field);
					traceF(target.charName + " looks to the battlefield.",1);
				} else {
					if (target.destinations[0].buildType == "Bloody Hole") {
						//Spawn something if it's a bloody hole
						spawnRandomMob(true,target.destinations[0]._x,target.destinations[0]._y,getBloodHoleMob(target.experience[0]));
					}
					traceF(target.charName + " is ready to battle!",1);
					target.pureIdle = 0;
				}
				target.destinations.shift();
			}

			//set MovTime to 0 so char can reanalyze goals
			target.movTime = 0;
			//we've reached the target and acted so we can end this as well
			//return;
		}
		//Player targets      : help with a healthKit                                                                                                                                                                                              
		if (goalMC.oType == "Hero" && goalMC._y == target._y) {
			distance = Math.abs(goalMC._x - target._x);
			//weaponRange = 50;
			if (distance <= 50) {
				if (goalMC.curHP <= 0) {
					target.destinations.shift();
					if (target.hKits >= 1) {
						target.hKits--;
						speech(target,"Help");
						speech(goalMC,"Thanks");
						amount = Math.round(goalMC.maxHP * .8);
						buff(goalMC,"Heal",amount);
						traceF(target.charName + " helps " + goalMC.charName + ". Kits remaining: " + target.hKits,1);
					} else {
						speech(target,"Sorry no health kits.");
						pID = findBuildID("Pharmacy");
						if (target.hKits <= 0 && pID != null) {
							addDestination(this,buildings[pID],2);
						}
					}
					return;
				} else {
					speech(target,"Huh?");
					target.destinations.shift();
					return;
				}
			}
		}
		//Check for enemies                                                                                                                                                                                                                                    
		if (goalMC.oType == "Enemy" && goalMC._y == target._y) {
			//Check for allies to help as entering fight
			//Check for enemies to attack 
			distance = Math.abs(goalMC._x - target._x);
			weaponRange = target.weaponMC.range;
			if (distance <= 6) {
				//if (goalMC != questTarget) {
				target.destinations.shift();

				target.movTime = 3;
				if (target._x < 200) {
					target.movDir = 1;
				} else {
					target.movDir = 0;
				}
				return;

			}
			if (distance <= weaponRange) {
				if (target.frontSight.hitTest(goalMC.bodyArea)) {
					traceF(target.charName + " attacks!",2);
					target.gotoAndPlay(target.weaponMC.usage);
					curState = "Fighting";
					if (getRandomUnder(100) < 10) {
						speech(target,"Chase");
					}
				} else if (target.frontSight.hitTest(goalMC.bodyArea)) {
					target._xscale *= 1;
					traceF(target.charName + " attacks!",2);
					target.gotoAndPlay(target.weaponMC.usage);
					if (getRandomUnder(100) < 10) {
						speech(target,"Chase");
					}
				}
				return;
			}
			//If stacked with target, move a little                                                                                                                                                             
			//Check character-enemy distance relation
		}
		if (target.movDir == 0) {
			//Moving LEFT
			//traceF("Move Left");
			moveLeft(target,target.walkSpeed);
			//We've passed the stairs
			if (target._x <= 35) {
				//Stairdir 1-UP 2-DOWN
				stairDir = determineStairs(35, target._y);
				if (destY < curY && stairDir == 1) {
					//go Up
					climbStair(target,1);
					traceF(target.charName + " is climbing stairs up to " + (getFloorWName(target._y - 80)) + ".",2);
				} else if (destY > curY && stairDir == 2) {
					//go down
					climbStair(target,2);
					traceF(target.charName + " is climbing stairs down to " + (getFloorWName(target._y + 80)) + ".",2);
				} else {
					//Re-analyze
					target.movTime = 0;
				}
			}
		} else if (target.movDir == 1) {
			//Moving RIGHT
			moveRight(target,target.walkSpeed);
			//Passed Stairs
			if (target._x >= 360) {
				stairDir = determineStairs(360, target._y);
				if (destY < curY && stairDir == 1) {
					//go Up
					climbStair(target,1);
					traceF(target.charName + " is climbing stairs up to " + (getFloorWName(target._y - 80)) + ".",2);
				} else if (destY > curY && stairDir == 2) {
					//go down
					climbStair(target,2);
					traceF(target.charName + " is climbing stairs down to " + (getFloorWName(target._y + 80)) + ".",2);
				} else {
					//Re-analyze
					target.movTime = 0;
				}
			}
		}
	}
}
//enemyAI
function enemyAI() {
	//Operates when unpaused only
	if (!_root.playPaused) {
		if (this._currentframe > 2) {
			return;
		}
		if (this.curHP <= 0) {
			_root.die(_root.findCharacter("Aude Auteberry"),this);
		}
		if (this.destinations[0] == null) {
			//Idling, no target to attack
			//Check movTime                      
			if (this.movTime <= 0) {
				//Check for buildings to attack, if yPos < 900        
				if (this._y < 900) {
					for (b = 0; b < _root.buildings.length; b++) {
						//Don't bother hitTesting if we aren't on the same level
						//if (_root.buildings[b]._y == this._y) {
						//Attack it if it's a building in sight
						if (this.frontSight.hitTest(_root.buildings[b].bodyArea) && _root.buildings[b].oType == "Building" && _root.buildings[b].curHP > 0) {
							this.destinations.push(_root.buildings[b]);
						}
						//}    
					}
				}
				//Make some decisions of where to go                                                                                                                      
				decision = getRandomUnder(this.actionChance);
				if (decision <= 5) {
					//Stand
					this.movDir = 1;
					this.gotoAndStop("Stand");
				} else if (decision <= 10) {
					//Go Left
					this.movDir = 0;
					this.gotoAndStop("Stand");
				} else {
					//Go Right
					this.movDir = 2;
					this.gotoAndStop("Static");
				}
				this.movTime = getRandomBetween(5, 50);
			} else {

				if (this.movDir == 0) {
					//moving LEFT
					_root.moveLeft(this,this.walkSpeed);
					if (this._x <= 35) {
						this.movDir = 1;
					}
					if (this.aggression > 1) {
						for (i = 0; i < players.length; i++) {
							if (this.frontSight.hitTest(players[i].bodyArea)) {
								this.destinations[0] = players[i];
								break;
							}
						}
					}
				} else if (this.movDir == 1) {
					//moving RIGHT
					_root.moveRight(this,this.walkSpeed);
					if (this._x >= 360) {
						this.movDir = 0;
					}
					if (this.aggression > 1) {
						for (i = 0; i < players.length; i++) {
							if (this.frontSight.hitTest(players[i].bodyArea)) {
								this.destinations[0] = players[i];
								break;
							}
						}
					}
				} else {
					//Standing, most likely
					if (this.aggression > 0) {
						for (i = 0; i < players.length; i++) {
							if (this.rearSight.hitTest(players[i].bodyArea)) {
								this.destinations[0] = players[i];
								break;
							}
							if (this.frontSight.hitTest(players[i].bodyArea)) {
								this.destinations[0] = players[i];
								break;
							}
						}
					}
				}
				this.movTime--;
				//If aggressive, check for enemies
			}
		} else {
			//has a "destination"
			destX = this.destinations[0]._x;
			curX = this._x;
			//Follow-through
			if (this.weaponMC.hitTest(this.destinations[0].bodyArea)) {
				//We've reached the destination. Attack everything!
				traceF(this.charName + " attacks!",2);
				this.gotoAndPlay("Attack");
				return;
			}
			if (this.rearSight.hitTest(this.destinations[0].bodyArea)) {
				this._xscale *= -1;
			}
			if (this.movTime <= 0) {
				//Make a decision
				if (destX < curX) {
					this.movDir = 0;
				} else if (destX > curX) {
					this.movDir = 1;
				}
				this.movTime = 10;
				if (this.destinations[0]._y != this._y) {
					this.destinations.shift();
				}
			} else {
				if (this.movDir == 0) {
					//moving LEFT
					_root.moveLeft(this,this.walkSpeed);
					if (this._x <= 35) {
						this.movDir = 1;
					}
				} else if (this.movDir == 1) {
					//moving RIGHT
					_root.moveRight(this,this.walkSpeed);
					if (this._x >= 360) {
						this.movDir = 0;
					}
				}
				this.movTime--;
			}
		}
	}
}
//Moving functions
function moveLeft(target, speed) {
	if ((target._x - speed) > 15) {
		target._xscale = 100;
		//target.movTime--;
		target._x -= speed;
	} else {
		target._x += 3;
		target.movDir = 1;

	}
}
function moveRight(target, speed) {
	if ((target._x + speed) < 375) {
		target._xscale = -100;
		//target.movTime--;
		target._x += speed;
		//trace("Moving Right");
	} else {
		target.movDir = 0;
		target._x -= 3;
	}
}
//Shoot an arrow
function shootArrow(char, target, dmg, fx, spd, type) {
	_root.gameStage.attachMovie(type,"projectileMC" + projectiles,6050 + projectiles);
	obj = _root.gameStage["projectileMC" + projectiles];
	obj._x = char._x;
	obj._y = char._y;
	if (char._xscale == 100) {
		obj.movDir = 0;
	} else {
		obj.movDir = 1;
	}
	obj.char = char;
	obj.victim = target;
	obj.attack = dmg;
	obj.effect = fx;
	obj.movSpeed = spd;
	projectiles++;
	if (projectiles > 40) {
		projectiles = 0;
	}
}
//Attacking function
function attack(char, target, damage, effect, range) {
	if (playPaused) {
		return;
	}
	hitTester = "bodyArea";
	if (effect == "Splash") {
		for (op = 0; op < players.length; op++) {
			if (players[op].bodyArea.hitTest(char.splashArea)) {
				attack(char,players[op],damage,"Normal");
			}
		}
		return;
	} else if (effect == "SplashMagical") {
		for (op = 0; op < players.length; op++) {
			if (players[op].bodyArea.hitTest(char.splashArea)) {
				attack(char,players[op],damage,"Magical");
			}
		}
		return;
	}
	//First check dodging                   
	if (target.oType != "Building") {
		//Check physical hitTest
		if (range != null) {
			if (!range.weaponMC.hitTest(target.bodyArea)) {
				return;
			} else {
				range.spent == true;
			}
		} else {
			if (!char.weaponMC.hitTest(target[hitTester])) {
				return;
			}
		}
		hitFormula = (165 + char.SKL + int(char.STR / 4)) - (100 + target.SKL + int(target.WIS / 4));
		dodgeRate = 100 - hitFormula;
		if (getRandomUnder(100) > dodgeRate) {
			if (range != null) {
				if (effect == "Normal") {
					atkStat = char.SKL;
				} else {
					atkStat = char.STR;
				}
				range.play();
			} else {
				atkStat = char.STR;
			}
			if (effect == "Magical") {
				atkStat = char.WIS;
				defStat = Math.round(target.WIS + (target.DEF / 3));
			} else {
				defStat = target.DEF;
			}
			//Successful hit!  
			if (getRandomUnder(100) < (Math.round(char.LUC / 5) + 1)) {
				//Critical hit!
				speech(char,"Critical!");
				atkFormula = atkStat;
				damage += 50;
			} else {
				atkFormula = atkStat - defStat;
				if (atkFormula < 1) {
					atkFormula = 1;
				}
			}
			//if (char.weapon == null) {
			//weaponAdd = atkFormula + 10;
			//} else {
			weaponAdd = atkFormula * (getWeaponDamage(char.weapon)) + (getWeaponDamage(char.weapon) * 2);
			//}
			gobbler = atkFormula + char.WIS;
			if (gobbler > weaponAdd) {
				gobbler = weaponAdd;
			}
			prefDam = getRandomBetween(gobbler, weaponAdd) * (damage / 100);
			//Calculate armor defense
			damage2 = int(prefDam - (prefDam * (target.aDEF / 100)));
			if (damage2 < 1) {
				damage2 = 1;
			}
			//Drain if drain  
			if (effect == "Drain") {
				buff(char,"Heal",damage2);
			}
			//Done with numbers.                                                                                                                                                                                                                                                     
			traceF("Ouch! " + char.charName + " hits " + target.charName + " for damage: " + damage2,2);
			target.curHP -= damage2;
			traceF(target.charName + "'s health is now " + target.curHP,2);
			if (target.curHP <= 0) {
				target.curHP = 0;
				die(char,target);
			}
			//Display the number                                                                                                                                                                                                                                                  
			infoDisplay("Damage",target,damage2);
			if (target.destinations[0] == null) {
				target.destinations[0] = char;
			} else {
				//Compare HPs
				enemysTargetHP = target.destinations[0].maxHP;
				if (char.maxHP > enemysTargetHP) {
					target.destinations[0] = char;
				}
			}
		} else {
			//Miss.
			infoDisplay("Miss",char,0);
		}
	} else {
		//Attacking a building
		//We must be an enemy
		if (!char.weaponMC.hitTest(target.bodyArea) || char.oType != "Enemy") {
			return;
		}
		atkForm = char.STR - target.DEF;
		if (atkForm < 1) {
			atkForm = 1;
		}
		target.curHP -= atkForm;
		if (target.curHP <= 0) {
			target.curHP = 0;
			target.gotoAndStop("Rubble");
		}
		char.destinations.shift();
	}
}
function buff(target, type, amount) {
	if (type == "Heal") {
		//Wake them up if they're dead
		if (target.curHP <= 0) {
			target.gotoAndStop("Stand");
			//speech(target,"Heal");
		}
		//if (target.charName == "Quinton Gerrart") {                    
		//subtractSatisfaction(target, 20);
		//}
		infoDisplay("Heal",target,amount);
		target.curHP += amount;
		if (target.curHP > target.maxHP) {
			target.curHP = target.maxHP;
		}
	}
}
//Death function
function die(char, target) {
	if (target.oType == "Enemy") {
		//add EXP, add gold, chance for items, kill count etc.
		//itemDropitemChance
		if (getRandomUnder(topDropChance) < target.itemChance) {
			ita = dropItem(target.itemDrop);
			infoDisplay("Item",target,ita);
		}
		earnGold(char,target.goldWorth + (char.LUC * 2));
		speech(char,"Win");
		addEXP(findCharacter("Aude Auteberry"),Math.round(target.expWorth / 4));
		//Facilitate the death
		target.gotoAndPlay("Dead");
		if (questEnemy == target) {
			completeQuest(target,char);
		}
		char.victories++;
		char.chainChance = 0;
		kills++;
		traceF("A " + target.charName + " has died.",1);
		for (j = 0; j < players.length; j++) {
			traceF("Finding self on others' lists...",2);
			if (players[j].destinations[0] == target) {
				// delete self
				//Give them EXP
				addEXP(players[j],target.expWorth);
				traceF("Removed " + target + " from " + players[j].charName + "'s list.",2);
				players[j].destinations.shift();
				players[j].movTime = 0;
				//blobsAry.splice(i, 1);
			}
		}
		//Remove self from array
		for (i = 0; i < enemies.length; i++) {
			if (enemies[i] == target) {
				// delete self
				traceF("Removed " + target + " from enemies list.",2);
				enemies.splice(i,1);
				//blobsAry.splice(i, 1);
			}
		}
	} else if (target.oType == "Hero") {
		for (i = 0; i < enemies.length; i++) {
			traceF("Finding self on others' lists...",2);
			if (enemies[i].destinations[0] == target) {
				// delete self
				traceF("Removed " + target + " from " + enemies[i].charName + "'s list.",2);
				enemies[i].destinations.shift();
				enemies[i].movTime = 0;
				//blobsAry.splice(i, 1);
			}
		}
		if (target._currentframe == 1 || target._currentframe >= 30) {
			target.gotoAndStop("Dead");
		}
		if (char == questEnemy && getRandomUnder(100) > 80) {
			addDestination(findCharacter("Aude Auteberry"),questTarget,2);
			speech(target,"We need backup..");
		} else {
			speech(target,"Die");
		}
		target.reviveTimer = 1000;
		target.defeats++;
		traceF(target.charName + " has fallen! :(",1);
		//Call for help
		//callForHelp(target);
	}
}
//Display number
function infoDisplay(type, target, damage) {
	numDis = _root.gameStage[target.oType + "NumMC" + target.ID];
	numDis._x = target._x;
	numDis._y = target._y;
	//numDis._alpha = 100;
	if (type == "Miss") {
		numDis.miss.gotoAndPlay(2);
	} else if (type == "Damage") {
		numDis.hits++;
		if (numDis.hits > 1) {
			numDis.combo = numDis.hits + " hit!";
		} else {
			numDis.combo = "";
		}
		//traceF(numDis,2);
		numDis.damageCount += damage;
		numDis.gotoAndPlay(2);
		numDis.HPBar.gotoAndPlay(2);
		HPBarratio = 100 * (target.curHP / target.maxHP);
		numDis.HPBar.HPBar._xscale = HPBarratio;
	} else if (type == "Stat") {
		numDis.statUp.play();
		numDis.statUp.statDisplay = damage;
	} else if (type == "Money") {
		numDis.moneyUp.play();
		numDis.moneyUp.statDisplay = damage;
	} else if (type == "Heal") {
		numDis.heal.gotoAndPlay(2);
		numDis.heal.healAmt += damage;
		//numDis.gotoAndPlay(2);
		numDis.HPBar.gotoAndPlay(2);
		HPBarratio = 100 * (target.curHP / target.maxHP);
		numDis.HPBar.HPBar._xscale = HPBarratio;
	} else if (type == "Item") {
		numDis.itemDrop.gotoAndPlay(2);
		numDis.itemDrop.iconDisplay.gotoAndStop(damage);
	}
}
function callForHelp(target) {
	distance = 2000;
	closest = null;
	//find the closest ally to call for help
	for (k = 0; k < players.length; k++) {
		//If target isn't self, is alive and willing, mark them down
		if (players[k] != target && players[k].curHP > 0 && (getRandomUnder(140) < players[k].friendliness)) {
			xDis = Math.round(players[k]._x - target._x);
			yDis = Math.round(players[k]._y - target._y);
			distCalc = Math.round(Math.sqrt((xDis * xDis) + (yDis * yDis)));
			if (distCalc < distance) {
				distance = distCalc;
				closest = k;
			}
		}
	}
	//Call the closest alive and willing ally
	if (closest != null) {
		//If ally has no health kits, don't bother
		if ((players[closest].hKits > 0)) {
			traceF(target.charName + " called " + players[closest].charName + " for help!",1);
			addDestination(players[closest],target,1);
			speech(target,"Someone help me!");
			speech(players[closest],getFirstName(target) + ", I'm coming!");
			break;
		}
	}
}
function getFirstName(input) {
	fullName = input.charName.split(" ");
	return fullName[0];
}
function findCharacter(charName) {
	for (i = 0; i < players.length; i++) {
		if (players[i].charName == charName) {
			return players[i];
		}
	}
}
//Returns information on stairs needed
function getStairs(targetY, dir) {
	//0 = Down, 1 = Up
	//First find the character's floor
	//First floor _y is 145. Each Floor +80
	curFloor = getFloor(targetY);
	traceF("Current Floor is " + curFloor,3);
	oddEven = getOddEven(curFloor);
	//0 is EVEN, 1 is ODD
	//Stairs down are on right if odd. Left if even
	if (dir == 0) {
		traceF("Wanna go down",3);
		//Char wants to go down. Return appropriate direction
		//0 L 1 R
		if (oddEven == 0) {
			//Wants down and on even floor. Go L
			return 0;
		} else {
			return 1;
		}
	} else {
		traceF("Wanna go up",3);
		//Char wants to go up.
		if (oddEven == 0) {
			traceF("Even floor so go RIGHT",3);
			return 1;
		} else {
			traceF("Odd floor so go LEFT",3);
			return 0;
		}
	}

}
//Are the stairs here going up or down?
function determineStairs(targetX, targetY) {
	//35, 360: L, R
	//First Find the Floor
	curFloor = getFloor(targetY);
	traceF("Cur Floor is " + curFloor,3);
	oddEven = getOddEven(curFloor);
	//0 is EVEN, 1 is ODD
	//Stairs down are on right if odd. Left if even
	//Return states: 1 is UP 2 is DOWN
	if (targetX < 100) {
		//Left field
		//Even(0): Down(2). Odd(1): Up(1)
		if (oddEven == 0) {
			return 2;
		} else {
			return 1;
		}
	} else {
		//Right field
		//Even(0): Up(1). Odd(1): Down(2)
		return oddEven + 1;
	}
}
//gets current floor
function getFloor(input) {
	return int((input - 65) / 80);
}
//Alter chance char takes the steps
function climbChance(curLvl, stairDir) {
	//Floor 11 and up, go down likely, up unlikely
	//Floor 12 to 16, 
	//Floor 19, don't go down
	if (stairDir == 1) {
		//Stairs up encountered
		if (curLvl <= 12) {
			return 50;
		} else if (curLvl <= 16 && curLvl > 12) {
			return 0 - ((curLvl - 10) * 4);
		} else if (curLvl >= 18) {
			return -30;
		} else {
			return 0;
		}
	} else if (stairDir == 2) {
		//Stairs down encountered
		if (curLvl <= 11) {
			return -70;
		} else if (curLvl > 11 && curLvl < 17) {
			return -50 + ((curLvl - 10) * 4);
		} else if (curLvl >= 18) {
			return 90;
		} else {
			return 0;
		}
	} else {
		return 0;
	}
}
function getFloorWName(input) {
	curFloor = getFloor(input);
	if (curFloor == 1) {
		return "S";
	}
	if (curFloor <= 9) {
		return "F" + (10 - curFloor);
	}
	if (curFloor == 10) {
		return "GF";
	}
	if (curFloor > 10) {
		return "B" + (curFloor - 10);
	}
}
//Simply determines if number is odd or even
function getOddEven(input) {
	if (input % 2 == 0) {
		//0 is EVEN
		traceF("Even number",3);
		return 0;
	} else {
		//1 is ODD
		traceF("Odd number",3);
		return 1;
	}
}
function climbStair(char, dir) {
	char.curState = "Climbing";
	if (dir == 1) {
		//going up. char._y - 80
		char.gotoAndPlay("StairsUp");
	} else {
		//going down. char._y + 80
		char.gotoAndPlay("StairsDown");
	}
	if (char._x < 30) {
		char._x += char.walkSpeed;
	} else if (char._x > 365) {
		char._x -= char.walkSpeed;
	}
	//Reset movTime so char can analyze goals after climbing                                                                                                                                                           
	char.movTime = 0;
}
function randomName() {
	return players[getRandomUnder(players.length) - 1].charName;
}
//Speech
function speech(target, msg) {
	//textBox, dialogue
	ID = target.ID;
	if (target.oType == "Enemy") {
		_root.gameStage.attachMovie("speechBox","speech" + ID,8000 + ID);
		_root.gameStage["speech" + ID]._alpha = 60;
	} else {
		_root.gameStage.attachMovie("speechBox","speech" + ID,8050 + ID);
	}
	theBox = _root.gameStage["speech" + ID];
	theBox.onEnterFrame = followFunc;

	theBox.sayer = target;
	rand = getRandomBetween(0, 2);
	if (msg == "Die") {
		msg = target.quotes[0][rand];
	} else if (msg == "Chase") {
		msg = target.quotes[1][rand];
	} else if (msg == "Help") {
		msg = target.quotes[2][rand];
	} else if (msg == "Win") {
		msg = target.quotes[3][rand];
	} else if (msg == "Heal") {
		msg = target.quotes[4][rand];
	} else if (msg == "Thanks") {
		msg = target.quotes[5][rand];
	}
	theBox.dialogue = msg;
	theBox.textBox._xscale = msg.length * 4 + 8;
}
function followFunc() {
	this._x = this.sayer._x;
	this._y = this.sayer._y;
}
//Upgrade somebody's weapon
function equipWeapon(target, type) {
	atkNow = getWeaponDamage(target.weapon);
	if (atkNow < getWeaponDamage(type)) {
		addSatisfaction(target,5);
		speech(target,"Thank you!");
	} else {
		speech(target,"What...");
	}
	target.weapon = type;
	traceF("Equipped a " + type + " on " + target.charName + "!",1);
	refreshWeapon(target);
}
//Display correct weapon graphic
function refreshWeapon(target) {
	target.weaponMC.gotoAndStop(target.weapon);
	//traceF(target.charName + " equipped a " + target.weapon);
}
//Refine armor cost
function getRefineCost(input) {
	return int(700 * Math.pow(2, input / 8));
}

function determineTownGoals(target) {
	//scroll through buildings and see if char wants to get to them
	if (target.sex == "F") {
		//Girls like to shop
		maxShops = 8;
	} else {
		maxShops = 4;
	}
	added = 0;
	tempP = new Array();
	tempP = buildings.slice(0, buildings.length);
	//weed out the junk
	for (g = 0; g < tempP.length; g++) {
		if (tempP[g].oType != "Building") {
			tempP[g].splice(g,1);
		}
	}
	while (tempP.length > 1) {
		i = getRandomUnder(tempP.length) - 1;
		if (tempP[i].oType == "Building" && tempP[i].buildType != "Inn") {
			chance = getRandomUnder(facilityChance) + (built * 2) - specialAppeal(target, tempP[i].buildType);
			if (tempP[i].buildType == "Pharmacy" && target.hKits <= 1) {
				chance -= 20;
			}
			if (chance <= (tempP[i].appeal + tempP[i].baseAppeal)) {
				addDestination(target,tempP[i],2);
				added++;
				if (target.destinations.length > maxShops) {
					//if (target.charName == "Aude Auteberry") {
					//speech(target,"Shopping spree!");
					//}
					break;
				} else {
					if (target.charName == "Aude Auteberry") {
						speech(target,"Shopping time?");
					}
				}
			}

		}
		tempP.splice(i,1);
	}
	traceF(target.charName + "'s destinations: " + target.destinations,2);
}
function addDestination(target, goal, priority) {
	if (priority == 1) {
		target.destinations.unshift(goal);
	} else {
		target.destinations.push(goal);
	}
	traceF(target.charName + " has decided to go to the " + findBuildType(goal),1);
}

//Find building ID
function findBuildID(targetName) {
	for (i = 0; i < buildings.length; i++) {
		if (buildings[i].buildType == targetName) {
			return i;
		}
	}
}
//Find building type
function findBuildType(target) {
	if (target.oType == "Building" || target.oType == "Landmark") {
		goalName = target.buildType;
		if (goalName == null) {
			goalName = "Empty Plot at Space #" + target.ID;
		}
	} else {
		//Not a building, must be enemy or character
		goalName = target.charName;
	}
	return goalName;
}
function setFacility(type, ID, mod) {
	if (mod == null) {
		mod = 0;
	}
	buildings[ID].buildType = type;
	buildings[ID].income = 0;
	buildings[ID].gotoAndStop(type);
	buildings[ID].appeal = getRandomBetween(10, 25) + mod;
	if (type == "Tree") {
		buildings[ID].oType = "Landmark";
		//if it's a tree, up nearby buildings' appeal
		for (i = 0; i < buildings.length; i++) {
			target = buildings[i];
			xDis = Math.round(buildings[ID]._x - target._x);
			yDis = Math.round(buildings[ID]._y - target._y);
			distCalc = Math.round(Math.sqrt((xDis * xDis) + (yDis * yDis)));
			if (distCalc < treeDistance) {
				target.appeal += treeBonus;
			}
		}
	} else {
		buildings[ID].oType = "Building";
		//If there's a tree nearby, up appeal
		for (i = 0; i < buildings.length; i++) {
			target = buildings[i];
			xDis = Math.round(buildings[ID]._x - target._x);
			yDis = Math.round(buildings[ID]._y - target._y);
			distCalc = Math.round(Math.sqrt((xDis * xDis) + (yDis * yDis)));
			if (distCalc < treeDistance && target.buildType == "Tree") {
				buildings[ID].appeal += treeBonus;
			}
		}
	}
	initBuilding(type,buildings[ID]);
	built++;
	traceF("An " + type + " has been built!",1);
}
function cloneFacility(inID, outID) {
	buildings[outID].gotoAndStop(buildings[inID].buildType);
	buildings[outID].buildType = buildings[inID].buildType;
	buildings[outID].income = buildings[inID].income;
	buildings[outID].oType = buildings[inID].oType;
	buildings[outID].appeal = buildings[inID].appeal;
	buildings[outID].cost = buildings[inID].cost;
	buildings[outID].baseAppeal = buildings[inID].baseAppeal;
	buildings[outID].upkeep = buildings[inID].upkeep;
	buildings[outID].DEF = buildings[inID].DEF;
	buildings[outID].aDEF = buildings[inID].aDEF;
	buildings[outID].curHP = buildings[inID].curHP;
	buildings[outID].maxHP = buildings[inID].maxHP;
}
function destroyFacility(ID) {
	if (buildings[ID].buildType == "Tree") {
		for (i = 0; i < buildings.length; i++) {
			target = buildings[i];
			xDis = Math.round(buildings[ID]._x - target._x);
			yDis = Math.round(buildings[ID]._y - target._y);
			distCalc = Math.round(Math.sqrt((xDis * xDis) + (yDis * yDis)));
			if (distCalc < treeDistance) {
				target.appeal -= treeBonus;
			}
		}
	}
	buildings[ID].gotoAndStop(1);
	buildings[ID].oType = "Building Site";
	buildings[ID].buildType = "Empty";
	for (j = 0; j < players.length; j++) {
		traceF("Finding self on others' lists...",2);
		if (players[j].destinations[0] == buildings[ID]) {
			// delete self
			traceF("Removed " + target + " from " + players[j].charName + "'s list.",2);
			players[j].destinations.splice(j,1);
			players[j].movTime = 0;
			//blobsAry.splice(i, 1);
		}
	}
	//buildings[i].splice(i,1);
}
function spawnRandomMob(exception, xPos, yPos, type, quest) {
	if (enemies.length > maxEnemies && exception) {
		return;
	}
	mobName = selectMob(type);
	//Make the player object 
	_root.gameStage.attachMovie(mobName,"enemyMC" + enemyNum,enemyNum);
	_root.gameStage.attachMovie("damageNum","EnemyNumMC" + enemyNum,enemyNum + 7000);
	_root.gameStage["enemyMC" + enemyNum].charName = mobName;
	_root.gameStage["enemyMC" + enemyNum].ID = enemyNum;
	_root.gameStage["enemyMC" + enemyNum].curHP = 4;
	_root.gameStage["enemyMC" + enemyNum].oType = "Enemy";
	_root.gameStage["enemyMC" + enemyNum].gotoAndPlay("Spawn");
	//Make them walk right initially
	_root.gameStage["enemyMC" + enemyNum].movDir = 1;
	_root.gameStage["enemyMC" + enemyNum].movTime = 0;
	_root.gameStage["enemyMC" + enemyNum].destinations = new Array();
	//Enemy AI
	_root.gameStage["enemyMC" + enemyNum].onEnterFrame = enemyAI;
	//Place coordinates
	if (xPos == null) {
		xPos = getRandomBetween(100, 300);
	}
	if (yPos == null) {
		yPos = randomSpawnY();
	}
	_root.gameStage["enemyMC" + enemyNum]._x = xPos;
	_root.gameStage["enemyMC" + enemyNum]._y = yPos;
	//Push to players objects array
	enemies.push(_root.gameStage["enemyMC" + enemyNum]);
	traceF("A " + mobName + " has appeared at " + xPos + ", " + yPos + ".",1);
	//Quest or not
	if (quest == true) {
		questEnemy = _root.gameStage["enemyMC" + enemyNum];
	}
	//Add depth value                                                                            
	enemyNum++;
	if (enemyNum > 45) {
		enemyNum = 0;
	}
}
//Generate a spawn point, floors 11-16
function randomSpawnY() {
	yPos = (getRandomBetween(11, spawnFloorBottom) * 80) + 65;
	return yPos;
}
//Earn Gold
function earnGold(target, amt) {
	infoDisplay("Money",target,"+" + amt + "G!");
	money += amt;
	target.income += amt;
	totalIncome += amt;
	monthlyIncome += amt;
}
function earnGold2(amt) {
	money += amt;
	totalIncome += amt;
	monthlyIncome += amt;
}
function spendGold(amt) {
	money -= amt;
	traceF("Spent " + amt + "G.",1);
	monthlyExpenses += amt;
	totalExpenses += amt;
}
//Add satisfaction
function addSatisfaction(target, amount) {
	target.satisfaction += amount;
	target.lvlUp(1);
	infoDisplay("Stat",target,"SAT Up!!");
}
function subtractSatisfaction(target, amount) {
	if (target.charName == "Aude Auteberry") {
		return;
	}
	target.satisfaction -= amount;
	if (target.satisfaction <= -10) {
		_root.useMenu("Goodbye","char",target);
	}
}
function addStat(target, stat, amount) {
	target[stat] += amount;
	infoDisplay("Stat",target,stat + " Up!!");
}
//Get requirements per level
function getLevelEXP(level) {
	return Math.round((level * 10) + (500 * Math.pow(2, level / 4) / 3) - 120);
}
//Add to Level
function addEXP(target, amt) {
	target.experience[1] += amt;
	//Check level up
	while (1) {
		if (target.experience[1] > getLevelEXP(target.experience[0])) {
			//Meets requirements to graduate this particular level
			target.lvlUp(4);
			target.experience[0] += 1;
			traceF(target.charName + " reached Level " + target.experience[0] + "!!",1);
			infoDisplay("Stat",target,"Level Up!!");
			if (target.curHP != target.maxHP) {
				buff(target,"Heal",target.maxHP - target.curHP);
			}
		} else {
			break;
		}
	}
}
//Figure out EXP to next level, and between levels
function findNeededExp(curLvl, exp) {
	//This finds EXP needed to attain next level
	nextEXP = getLevelEXP(curLvl);
	return nextEXP - exp;
}
function percentEXP(curLvl, exp) {
	//This finds % of current level's exp complete
	if (curLvl == 1) {
		lastEXP = 0;
	} else {
		lastEXP = getLevelEXP(curLvl - 1);
	}
	nextEXP = getLevelEXP(curLvl);
	nextEXP -= lastEXP;
	exp -= lastEXP;
	return Math.round(100 * (exp / nextEXP));
}
//find mob'
function findEnemy(charName) {
	for (i = 0; i < enemies.length; i++) {
		if (enemies[i].charName == charName) {
			return enemies[i];
		}
	}
}
//Inventory Functions

function addFame(amt) {
	fame += amt;
}

function endWeek() {
	townDate[0]++;
	//Week has ended
	//Check quest queue for adelains      
	for (q = 0; q < questQueue.length; q++) {
		if (questQueue[q] == "Arasof Eninsula") {
			fame--;
		}
	}
	if (townDate[0] == 5) {
		Aude = findCharacter("Aude Auteberry");
		Aude.hKits++;
		addFame(1);
		//Month Ended
		monthlyIncome = 0;
		monthlyExpenses = 0;
		townDate[1]++;
		townDate[0] = 1;
		//Calc facility expenses
		for (i = 0; i < buildings.length; i++) {
			if (buildings[i].oType == "Building") {
				expense = buildings[i].upkeep;
				spendGold(expense);
				monthlyExpenses += expense;
				totalExpenses += expense;
				buildings[i].income -= expense;
			}
			if (buildings[i].buildType == "Tree") {
				expense = 300;
				spendGold(expense);
				monthlyExpenses += expense;
				totalExpenses += expense;
				//buildings[i].income -= expense;
			}
		}
		if (townDate[1] == 13) {
			//Year ended
			townDate[2]++;
			townDate[1] = 1;
		}
	}
	if (fame >= fameEvents[0][1]) {
		useFameEvent();
	}
}
//Inventory functions
function dropItem(itemName) {
	ita = itemName;
	switch (itemName) {
		case "Fame" :
			chance = getRandomUnder(100);
			if (chance < 30) {
				ita = "Legendary Scriptures";
			} else {
				ita = "Famous Scrolls";
			}
			break;
		case "Gift" :
			chance = getRandomUnder(100);
			if (chance < 5) {
				ita = "Old Locket";
			} else if (chance < 10) {
				ita = "Cuddly Pillow";
			} else if (chance < 15) {
				ita = "Distilled Boredom";
			} else if (chance < 20) {
				ita = "Fancy Sword";
			} else if (chance < 25) {
				ita = "Naughty Book";
			} else if (chance < 30) {
				ita = "Atherios Toy";
			} else if (chance < 50) {
				ita = "Huge Gemstone";
			} else {
				ita = "Gold Bar";
			}
			break;
		case "Stat" :
			chance = getRandomBetween(1, 6);
			if (chance == 1) {
				ita = "Meat Stew";
			} else if (chance == 2) {
				ita = "Labor Manual";
			} else if (chance == 3) {
				ita = "Target Dummy";
			} else if (chance == 4) {
				ita = "4Leaf Clover";
			} else if (chance == 5) {
				ita = "Literature";
			} else {
				ita = "Elixir";
			}
			break;
		case "Herb" :
			ita = "Herbs";
			break;
		case "Codex" :
			lowest = 10;
			point = 0;
			for (i = 0; i < weaponLevels.length; i++) {
				if (weaponLevels[i] < lowest) {
					point = i;
					lowest = weaponLevels[i];
				}
			}
			switch (point) {
				case 0 :
					ita = "Dagger Atlas";
					break;
				case 1 :
					ita = "Sword Lexicon";
					break;
				case 2 :
					ita = "Spear Tome";
					break;
				case 3 :
					ita = "Archers' Codex";
					break;
				case 4 :
					ita = "Power Compendium";
					break;
				default :
			}
			break;
		default :
			break;
	}
	getItem(ita,1);
	return ita;
}
function addWeaponLevel(armType) {
	added = false;
	switch (armType) {
		case "Knife" :
			weaponLevels[0]++;
			added = true;
			menuMC.errorMC.gotoAndStop("Error");
			menuMC.errorMC.errorIcon.gotoAndStop("Dagger Atlas");
			menuMC.errorMC.errorMsg = "New dagger available!";
			break;
		case "Sword" :
			weaponLevels[1]++;
			added = true;
			menuMC.errorMC.gotoAndStop("Error");
			menuMC.errorMC.errorIcon.gotoAndStop("Sword Lexicon");
			menuMC.errorMC.errorMsg = "New sword available!";
			break;
		case "Spear" :
			weaponLevels[2]++;
			added = true;
			menuMC.errorMC.gotoAndStop("Error");
			menuMC.errorMC.errorIcon.gotoAndStop("Spear Tome");
			menuMC.errorMC.errorMsg = "New spear available!";
			break;
		case "Bow" :
			weaponLevels[3]++;
			added = true;
			menuMC.errorMC.gotoAndStop("Error");
			menuMC.errorMC.errorIcon.gotoAndStop("Archers' Codex");
			menuMC.errorMC.errorMsg = "New bow available!";
			break;
		case "Heavy" :
			weaponLevels[4]++;
			added = true;
			menuMC.errorMC.gotoAndStop("Error");
			menuMC.errorMC.errorIcon.gotoAndStop("Power Compendium");
			menuMC.errorMC.errorMsg = "New heavy weapon available!";
			break;
		default :
	}
	if (added == false) {
		earnGold2(10000);
	}
}
function getItemInfo(itemName, requested) {
	for (i = 0; i < inventory.length; i++) {
		if (inventory[i][0] == itemName) {
			if (requested == "ID") {
				return i;
			} else if (requested == "Quantity") {
				return inventory[i][1];
			} else if (requested == "Price") {
				return inventory[i][2];
			} else if (requested == "Info") {
				return inventory[i][3];
			}
		}
	}
}
function subtractItem(itemName, amt) {
	for (i = 0; i < inventory.length; i++) {
		if (inventory[i][0] == itemName) {
			traceF("Lost " + amt + " " + itemName + "s! Current: " + inventory[i][1],1);
			inventory[i][1] -= amt;
			if (inventory[i][1] < 0) {
				inventory[i][1] = 0;
			}
		}
	}
}
function getItem(itemName, amt) {
	for (i = 0; i < inventory.length; i++) {
		if (inventory[i][0] == itemName) {
			inventory[i][1] += amt;
			//iconDisplay, gotItem
			_root.itemNotif.gotoAndPlay(2);
			_root.itemNotif.itemAry.push([itemName, amt]);
			traceF("Gained " + amt + " " + itemName + "s! Current: " + inventory[i][1],1);
			if (inventory[i][1] > 99) {
				inventory[i][1] = 99;
			}
			break;
		}
	}
}
function initQuest(questName, spawnPlace, urgency) {
	//Find location
	switch (spawnPlace) {
		case "Ice Pit" :
			xPos = _root.gameStage.cave0._x;
			yPos = _root.gameStage.cave0._y;
			break;
		case "Cavern" :
			xPos = _root.gameStage.cave1._x;
			yPos = _root.gameStage.cave1._y;
			break;
		case "Bloody Hole" :
			xPos = _root.gameStage.cave2._x;
			yPos = _root.gameStage.cave2._y;
			break;
		case "Hell's Entrance" :
			xPos = _root.gameStage.cave3._x;
			yPos = _root.gameStage.cave3._y;
			break;
		default :
			xPos = getRandomBetween(100, 300);
			yPos = randomSpawnY();
	}
	spawnRandomMob(false,xPos,yPos,questName,true);
	//get some players to attack the monster
	joining = "";
	chance = urgency;
	tempP = new Array();
	tempP = players.slice(0, players.length);
	traceF(tempP,2);
	//questingGuys = "";
	while (tempP.length >= 1) {
		i = getRandomUnder(tempP.length) - 1;
		if (getRandomUnder(100) < chance) {
			if (tempP[i].charName != "Aude Auteberry") {
				traceF("Added to quest: " + tempP[i].charName,1);
				//addDestination(players[i],questEnemy,1);
				//addDestination(players[i],_root.buildings[_root.findBuildID("Inn")],1);
				tempP[i].questing = true;
				if (chance == urgency) {
					joining += " " + getFirstName(tempP[i]);
				} else {
					joining += ", " + getFirstName(tempP[i]);
				}
				chance -= 20;
				//addDestination(players[i],findBuildID("Inn"),1);
			}

		}
		tempP.splice(i,1);
		traceF("Remaining players: " + tempP.length,1);
	}
	traceF("Let's hunt some " + questName + " at the " + spawnPlace + "!",1);
	_root.useMenu("Event",null,null,true);
	//getItem("Sword Lexicon",3);
	_root.menuMC.nameDisplay.text = "Quest Begin!";
	_root.menuMC.textDisplay.text = "Joining the quest:" + joining + ".\nLet's pray for their safety!";
	questingGuys = joining;
}
function completeQuest(target, killer) {
	questName = target.charName;
	for (u = 0; u < questQueue.length; u++) {
		if (questQueue[u] == questName) {
			questQueue.splice(u,1);
		}
	}
	//questQueue.shift();
	questEnemy.gotoAndPlay("Dead");
	questsDone++;
	switch (questName) {
		case "Faint Man" :
			addFame(5);
			_root.useMenu("Event");
			//_root.menuMC.nameDisplay = "Quest Complete!";
			_root.menuMC.textDisplay.text = "Is that strange man dead? Good! The quest brought in an item as well.";
			break;
		case "Benjourn" :
			getItem("4Leaf Clover",1);
			getItem("Literature",1);
			_root.useMenu("Event");
			_root.menuMC.textDisplay.text = "Oh, so it wasn't a big deal after all. At least we found a clover and a book.";
			addFame(2);
			break;
		case "Crescent" :
			_root.useMenu("Event");
			_root.menuMC.textDisplay.text = "So the undead have risen. There's something.. something that needs answering..";
			addFame(5);
			break;
		case "Mountain Goat" :
			getItem("Meat Stew",3);
			_root.useMenu("Event");
			_root.menuMC.textDisplay.text = "Wonderful, now we have some meat stew.";
			break;
		case "Landfish" :
			//getItem("Meat Stew",3);
			_root.useMenu("Event");
			_root.menuMC.textDisplay.text = "Now we have luxurious dining with this disgusting delicacy.";
			_root.innEntertainment = "Luxury Week";
			break;
		case "Toad" :
			getItem("Elixir",2);
			_root.useMenu("Event");
			_root.menuMC.textDisplay.text = "Actually, I heard " + randomName() + " is afraid of warts. Not that they come from toads.";
			break;
		case "CoS Scrub" :
			smc = _root.menuMC.dialogue;
			smc.push([killer.charName, "-stab-"]);
			smc.push(["CoS Scrub", "Arrghh!! My friends will be here any minute now and you'll pay!"]);
			smc.push(["Aude Auteberry", "They looked like a part of some organization to me."]);
			smc.push(["Aude Auteberry", "We'd better watch out from here on out."]);
			_root.useMenu("Plot");
			addFame(4);
			break;
		case "CoS Member" :
			//getItem("Meat Stew",3);
			_root.useMenu("Event");
			_root.menuMC.textDisplay.text = "They just don't give up, do they?";
			earnGold(killer,500);
			addFame(2);
			break;
		case "CoS Captain" :
			//getItem("Meat Stew",3);
			_root.useMenu("Event");
			_root.menuMC.textDisplay.text = "I have a bad feeling about this now. That couldn't have been their strongest.";
			earnGold(killer,500);
			addFame(5);
			break;
		case "Spawn" :
			//getItem("Meat Stew",3);
			_root.useMenu("Event");
			_root.menuMC.textDisplay.text = "Can people really summon creatures like that?";
			addFame(2);
			break;
		case "Arasof Eninsula" :
			getItem("Potion",5);
			getItem("Elixir",3);
			_root.menuMC.dialogue = new Array();
			smc = _root.menuMC.dialogue;
			smc.push(["Arasof Eninsula", "Urghh..."]);
			smc.push(["Arasof Eninsula", "Sherat...s....ughh..."]);
			smc.push(["Aude Auteberry", "We did it! But don't get cocky, kids. He was going easy."]);
			if (findCharacter("Hora Danibel") != null) {
				smc.push(["Hora Danibel", "I-I'm no kid!"]);
			}
			_root.useMenu("Plot");
			addFame(10);
			break;
		default :
			break;
	}
	_root.menuMC.nameDisplay.text = "Quest Complete!";
	questEnemy = null;
}
function addQuest(qName) {
	if (_root.questEnemy == null) {
		questQueue.push(qName);
		_root.useMenu("Quest2");
	} else {
		//del = false;
		questQueue.push(qName);
		_root.useMenu("NewQuest");
	}
}
//UTILITY FUNCTIONS
//Random number function
function getRandomBetween(lowInt, highInt) {
	return (lowInt + Math.floor(Math.random() * (highInt - lowInt + 1)));
}
function getRandomUnder(highInt) {
	return int(Math.random() * highInt) + 1;
}
function hoverBox(target) {
	lax = _root.gameStage.infoBubble;
	lax.char = target;
	lax._x = target._x;
	lax._y = target._y;
	lax.nameDisplay = target.charName;
	lax.HPDisplay = target.curHP + "/" + target.maxHP;
	lax.HPBar._xscale = 100 * (target.curHP / target.maxHP);
	lax.gotoAndPlay(2);
}
function togglePlayPause(input) {
	if (input == 0) {
		//unpause
		playPaused = false;
		weekTimer.play();
	} else {
		//pause
		playPaused = true;
		weekTimer.stop();
	}
}
function useMenu(frame, char, target, overriding) {
	if (frame == "NewQuest") {
		_root.menuMC.errorMC.gotoAndStop("Error");
		_root.menuMC.errorMC.errorIcon.gotoAndStop(itemNeed);
		_root.menuMC.errorMC.errorMsg = "New quest available!";
	} else {
		if (overriding == true) {
			//19 - 28
			if (_root.menuMC._currentframe >= 19 && _root.menuMC._currentframe <= 28) {
				clearInterval(_root.menuMC.updater);
			}
			_root.menuMC.gotoAndStop(frame);
			_root.togglePlayPause(1);
			if (target != null && char != null) {
				_root.menuMC[char] = target;
			}
		} else {
			if (_root.menuMC._currentframe == 1) {
				_root.menuMC.gotoAndStop(frame);
				_root.togglePlayPause(1);
				if (target != null && char != null) {
					_root.menuMC[char] = target;
				}
			}
		}
	}
}
//Debug text readout function
function traceF(msg, messageType) {
	if (debug >= messageType) {
		trace(msg);
	}
	//if debug == -1, print to text readout area                                                                                                                                                                                                                                                                                       
}
function getNews() {
	//latestNews, newsTicker, questEnemy.charName, questingGuys
	//findBuildID("Pharmacy"), findCharacter("");
	if (newsTicker == 1) {
		newsTicker += 1;
		return "Latest: " + latestNews;
	} else if (newsTicker == 2) {
		//Print health kit info shit
		newsTicker += 1;
		if (findBuildID("Pharmacy") == null) {
			return randomName() + " is unable to find a pharmacy in town to stock up.";
		} else {
			return "Town's health kit stock: " + healthKits;
		}
	} else if (newsTicker == 3) {
		newsTicker += 1;
		//if questing, display quest
		if (questEnemy != null) {
			return questEnemy.charName + " hunting: " + questingGuys;
		} else {
			if (questQueue.length == 0) {
				return "There are no quests!";
			} else {
				return "Available quests: " + questQueue;
			}
		}
	} else if (newsTicker == 4) {
		//Random shit
		newsTicker = 1;
		return getRanEvent();
	}
}

//Init Stats, Init Vars
function initStats(target) {
	charName = target.charName;
	target.satisfaction = 0;
	target.experience = new Array(1, 0);
	target.skills = new Array(null, null, null);
	target.awards = 0;
	target.houseID = null;
	//Stats for fun
	target.defeats = 0;
	target.victories = 0;
	target.assists = 0;
	target.facilitiesUsed = 0;
	target.income = 0;
	switch (charName) {
		case "Kavaan Rhiordall" :
			target.STR = 12;
			target.DEF = 12;
			target.SKL = 15;
			target.LUC = 2;
			target.WIS = 2;
			target.maxHP = 298;
			target.curHP = target.maxHP;
			target.weapon = "Hatchet";
			target.aDEF = 10;
			target.hKits = 3;
			break;
		case "Quinton Gerrart" :
			target.STR = 13;
			target.DEF = 16;
			target.SKL = 11;
			target.LUC = 8;
			target.WIS = 7;
			target.maxHP = 420;
			target.curHP = target.maxHP;
			target.weapon = "Sword";
			target.aDEF = 15;
			target.hKits = 1;
			break;
		case "Armadus Broghton" :
			target.STR = 12;
			target.DEF = 25;
			target.SKL = 12;
			target.LUC = 1;
			target.WIS = 5;
			target.maxHP = 380;
			target.curHP = target.maxHP;
			target.weapon = "Staff";
			target.aDEF = 20;
			target.hKits = 1;
			break;
		case "Elias Odremont" :
			target.STR = 18;
			target.DEF = 6;
			target.SKL = 16;
			target.LUC = 5;
			target.WIS = 4;
			target.maxHP = 220;
			target.curHP = target.maxHP;
			target.weapon = "Knife";
			target.aDEF = 2;
			target.hKits = 1;
			break;
		case "Kazash Amir" :
			target.STR = 24;
			target.DEF = 12;
			target.SKL = 22;
			target.LUC = 1;
			target.WIS = 1;
			target.maxHP = 320;
			target.curHP = target.maxHP;
			target.weapon = "Sword";
			target.aDEF = 2;
			target.hKits = 1;
			break;
		case "Hora Danibel" :
			target.STR = 10;
			target.DEF = 10;
			target.SKL = 32;
			target.LUC = 14;
			target.WIS = 10;
			target.maxHP = 310;
			target.curHP = target.maxHP;
			target.weapon = "Self Bow";
			target.aDEF = 2;
			target.hKits = 3;
			break;
		case "Aude Auteberry" :
			target.STR = 15;
			target.DEF = 10;
			target.SKL = 45;
			target.LUC = 34;
			target.WIS = 20;
			target.maxHP = 410;
			target.curHP = target.maxHP;
			target.satisfaction = 20;
			target.weapon = "Aude's Hellebarde";
			target.aDEF = 5;
			target.hKits = 3;
			break;
		case "Mathias Adrichen" :
			target.STR = 45;
			target.DEF = 20;
			target.SKL = 36;
			target.LUC = 12;
			target.WIS = 30;
			target.maxHP = 480;
			target.curHP = target.maxHP;
			target.satisfaction = 0;
			target.weapon = "Cruciform";
			target.aDEF = 5;
			target.hKits = 1;
			break;
		case "Sola Calcifron" :
			target.STR = 52;
			target.DEF = 57;
			target.SKL = 25;
			target.LUC = 13;
			target.WIS = 45;
			target.maxHP = 674;
			target.curHP = target.maxHP;
			target.satisfaction = 0;
			target.weapon = "Sola's Sword";
			target.aDEF = 30;
			target.hKits = 1;
			break;
		case "Neria Cyonire" :
			target.STR = 12;
			target.DEF = 35;
			target.SKL = 65;
			target.LUC = 33;
			target.WIS = 27;
			target.maxHP = 434;
			target.curHP = target.maxHP;
			target.satisfaction = 0;
			target.weapon = "Recurve";
			target.aDEF = 5;
			target.hKits = 1;
			break;
		default :
			target.STR = 10;
			target.DEF = 10;
			target.SKL = 10;
			target.LUC = 10;
			target.WIS = 50;
			target.maxHP = 100;
			target.curHP = target.maxHP;
			target.weapon = "Sword";
			target.aDEF = 0;
			target.hKits = 1;
			break;
	}
}
function initVars(target) {
	charName = target.charName;
	target.oType = "Hero";
	target.questing = false;
	target.basicInfo = new Array();
	switch (charName) {
		case "Kavaan Rhiordall" :
			target.sex = "M";
			target.satReq = 30;
			target.friendliness = 40;
			target.walkSpeed = 5;
			target.quotes = new Array();
			target.quotes[0] = ["Ahh~!", "Wha..", "I'm dead?"];
			target.quotes[1] = ["Come here!", "You won't escape!", "Die!"];
			target.quotes[2] = ["I've got it.", "It's on me.", "All right."];
			target.quotes[3] = ["A-ha.", "Phew...", "Made it."];
			target.quotes[4] = ["All better.", "That's better.", "Much better."];
			target.quotes[5] = ["Wow, thanks!", "I'll repay you!", "Thank you!"];
			target.quotes[6] = ["", "", ""];
			target.basicInfo[0] = "Bishop, Acarime";
			target.basicInfo[1] = "5660";
			target.basicInfo[2] = "I like to socialize. Neighbors, feel free to talk to me!";
			target.basicInfo[3] = "Sharp stuff";
			target.destinations = new Array();
			break;
		case "Armadus Broghton" :
			target.sex = "M";
			target.satReq = 30;
			target.friendliness = 20;
			target.walkSpeed = 3;
			target.quotes = new Array();
			target.quotes[0] = ["Err..", "Ahahaha...", "HONEEY~!"];
			target.quotes[1] = ["Don't run away!", "C'mere!", "Stay put!"];
			target.quotes[2] = ["You called?", "Be careful.", "Get back!"];
			target.quotes[3] = ["It is done.", "Yes..!", "Gettin' stronger."];
			target.quotes[4] = ["I feel good.", "It's all good.", "Guuuuuhd."];
			target.quotes[5] = ["Why thank you.", "Appreciated.", "Just dandy."];
			target.quotes[6] = ["", "", ""];
			target.basicInfo[0] = "Eseroth, Silatria.";
			target.basicInfo[1] = "5664";
			target.basicInfo[2] = "Statues, architecture, quiet moments, salad, war tactics.";
			target.basicInfo[3] = "Swords.";
			target.destinations = new Array();
			break;
		case "Elias Odremont" :
			target.sex = "M";
			target.satReq = 30;
			target.friendliness = 25;
			target.walkSpeed = 5;
			target.quotes = new Array();
			target.quotes[0] = ["I'm out..", "Uh oh..", "I wanna go home.."];
			target.quotes[1] = ["Swing away!", "You're going down!", "Strike!"];
			target.quotes[2] = ["Yes.", "Okay.", "There."];
			target.quotes[3] = ["Ha!", "Win!", "Yes!"];
			target.quotes[4] = ["All ready.", "Good to go.", "Feeling good."];
			target.quotes[5] = ["Thanks.", "Phew, close one.", "Great, let's go."];
			target.quotes[6] = ["", "", ""];
			target.basicInfo[0] = "Illuman, Silatria.";
			target.basicInfo[1] = "5661";
			target.basicInfo[2] = "Stickball is my passion. Visiting high places is cool, too.";
			target.basicInfo[3] = "Polearms.";
			target.destinations = new Array();
			break;
		case "Kazash Amir" :
			target.sex = "M";
			target.satReq = 30;
			target.friendliness = 30;
			target.walkSpeed = 4;
			target.quotes = new Array();
			target.quotes[0] = ["I hate this job..", "Did not expect..", "Should've ran.."];
			target.quotes[1] = ["I'm on it!", "Yes.", "Take it down!"];
			target.quotes[2] = ["Here.", "Take it.", "Take this."];
			target.quotes[3] = ["It is done.", "Victory.", "You're done for."];
			target.quotes[4] = ["Yes.", "I'm ready.", "Bring it on."];
			target.quotes[5] = ["Thanks.", "That's great.", "Thank you."];
			target.quotes[6] = ["", "", ""];
			target.basicInfo[0] = "Unknown";
			target.basicInfo[1] = "Unknown";
			target.basicInfo[2] = "Unknown.. see a recurring theme?";
			target.basicInfo[3] = "Swords.";
			target.destinations = new Array();
			break;
		case "Hora Danibel" :
			target.sex = "F";
			target.satReq = 35;
			target.friendliness = 20;
			target.walkSpeed = 6;
			target.quotes = new Array();
			target.quotes[0] = ["How annoying!", "How bothersome.", "It hurts!"];
			target.quotes[1] = ["On it!", "Grrr..", "Why won't you die?!"];
			target.quotes[2] = ["Hmph.", "Hurry up!", "Just get up."];
			target.quotes[3] = ["Haha.", "That was too hard.", "How tiring."];
			target.quotes[4] = ["Okay.", "All right.", "Fine, then."];
			target.quotes[5] = ["I guess.", "That'll do.", "Thanks I guess."];
			target.quotes[6] = ["", "", ""];
			target.basicInfo[0] = "Silverden, Acarime.";
			target.basicInfo[1] = "5667";
			target.basicInfo[2] = "Not your business.";
			target.basicInfo[3] = "Bow or dagger.";
			target.destinations = new Array();
			break;
		case "Aude Auteberry" :
			target.sex = "F";
			target.satReq = 35;
			target.friendliness = 50;
			target.walkSpeed = 6;
			target.quotes = new Array();
			target.quotes[0] = ["Noooo!", "Oh no!", "Ahhhhh!"];
			target.quotes[1] = ["For " + _root.townName + "!", "You..!", "Go away!"];
			target.quotes[2] = ["There you go.", "You're welcome.", "Anytime."];
			target.quotes[3] = ["Enemy vanquished.", "Our foe has fallen.", "Okay!"];
			target.quotes[4] = ["Wonderful!", "Very well.", "Very good."];
			target.quotes[5] = ["Thank you!!", "Thanks!!", "So kind of you!"];
			target.quotes[6] = ["", "", ""];
			target.basicInfo[0] = "Lividell, Silatria.";
			target.basicInfo[1] = "5657";
			target.basicInfo[2] = "Lute music; management; blah!";
			target.basicInfo[3] = "Halberds.";
			target.destinations = new Array();
			break;
		case "Quinton Gerrart" :
			target.sex = "M";
			target.satReq = 20;
			target.friendliness = 40;
			target.walkSpeed = 4;
			target.quotes = new Array();
			target.quotes[0] = ["Not now!", "It's not that bad..not.", "No, no, no!"];
			target.quotes[1] = ["Glorryyyyyy!", "I don't think so!", "POOF begone!!"];
			target.quotes[2] = ["There we are.", "Yes, yes of course.", "Naturally."];
			target.quotes[3] = ["Are we done?", "We somehow came through.", "Lucky strike!"];
			target.quotes[4] = ["All napped up!", "Still got no hair back.", "-burp- Sorry."];
			target.quotes[5] = ["Aw da- I mean, thanks.", "Now let's get out of here.", "Indeed!"];
			target.quotes[6] = ["", "", ""];
			target.basicInfo[0] = "Lorlen, Acarime.";
			target.basicInfo[1] = "5653";
			target.basicInfo[2] = "Let's see.. Funnymen. Staying fit. Havin' hair.";
			target.basicInfo[3] = "Don't matter.";
			target.destinations = new Array();
			break;
		case "Mathias Adrichen" :
			target.sex = "M";
			target.satReq = 40;
			target.friendliness = 40;
			target.walkSpeed = 5;
			target.quotes = new Array();
			target.quotes[0] = ["L-Lin..!", "Damn.", "I can't!"];
			target.quotes[1] = ["Hmmm....", "Let's try...", "I can do this."];
			target.quotes[2] = ["Yes.", "Of course.", "Glad to help."];
			target.quotes[3] = ["We made it!", "Phooooo...", "Yes!"];
			target.quotes[4] = ["Let's do this!", "I have a plan.", "All packed, ready to go."];
			target.quotes[5] = ["Appreciated.", "Where is it?", "Not so early!"];
			target.quotes[6] = ["", "", ""];
			target.basicInfo[0] = "Foxcourt, Acarime.";
			target.basicInfo[1] = "5666";
			target.basicInfo[2] = "I enjoy woodworking and listening to stories.";
			target.basicInfo[3] = "Sword.";
			target.destinations = new Array();
			break;
		case "Sola Calcifron" :
			target.sex = "F";
			target.satReq = 45;
			target.friendliness = 40;
			target.walkSpeed = 5;
			target.quotes = new Array();
			target.quotes[0] = ["Oh no!", "I'm sorry!", "I've failed!"];
			target.quotes[1] = ["Yes, commander.", "It will be done.", "!!!!"];
			target.quotes[2] = ["Good to see you up.", "I'm glad.", "I'll protect you."];
			target.quotes[3] = ["I've done it.", "It is done.", "Revenge."];
			target.quotes[4] = ["Here's what we should do..", "I couldn't, possibly.", "I'm ready."];
			target.quotes[5] = ["Thank you, friend.", "I'm glad for that.", "I'm glad it was me, not you."];
			target.quotes[6] = ["", "", ""];
			target.basicInfo[0] = "Eseroth, Silatria.";
			target.basicInfo[1] = "5668";
			target.basicInfo[2] = "Military affairs, conditioning, tactics.";
			target.basicInfo[3] = "Sword.";
			target.destinations = new Array();
			break;
		case "Neria Cyonire" :
			target.sex = "F";
			target.satReq = 40;
			target.friendliness = 30;
			target.walkSpeed = 5;
			target.quotes = new Array();
			target.quotes[0] = ["How unsettling...", "Most unsettling..", "Noooo!"];
			target.quotes[1] = ["Taking aim..", "Analyzing...", "I'm looking..."];
			target.quotes[2] = ["Okay.", "Welcome.", "Let's go now."];
			target.quotes[3] = ["One down.", "Got it.", "It was nothing really."];
			target.quotes[4] = ["I'll find out.", "We'll see.", "Let's keep going."];
			target.quotes[5] = ["Thank you.", "I'm ready now.", "That was close.."];
			target.quotes[6] = ["", "", ""];
			target.basicInfo[0] = "Easter Port, Silatria.";
			target.basicInfo[1] = "5666";
			target.basicInfo[2] = "The scourges.. why are they happening? Oh and.. affection.";
			target.basicInfo[3] = "Bow.";
			target.destinations = new Array();
			break;
		default :
			target.sex = "N";
			target.satReq = 100;
			target.walkSpeed = 4;
			target.friendliness = 0;
			target.quotes = new Array();
			target.quotes[0] = ["", "", ""];
			target.quotes[1] = ["", "", ""];
			target.quotes[2] = ["", "", ""];
			target.quotes[3] = ["", "", ""];
			target.quotes[4] = ["", "", ""];
			target.quotes[5] = ["", "", ""];
			target.quotes[6] = ["", "", ""];
			target.basicInfo[0] = "Hometown";
			target.basicInfo[1] = "Birth Year";
			target.basicInfo[2] = "Interests";
			target.basicInfo[3] = "Weapon";
			target.destinations = new Array();
			break;
	}
	if (testTargets == true) {
		//target.destinations[0] = target._parent.building28;
		//target.destinations[1] = target._parent.cave1;
		//target.destinations[2] = target._parent.building32;
		goalsToAdd = getRandomBetween(2, 6);
		for (g = 0; g < goalsToAdd; g++) {
			caveOrBuilding = getRandomUnder(10);
			if (caveOrBuilding < 4) {
				addDestination(target,_root.gameStage["cave" + (getRandomUnder(4) - 1)],2);
			} else {
				addDestination(target,buildings[getRandomUnder(33) - 1],2);
			}
		}
	}
	addDestination(target,buildings[findBuildID("Inn")],2);
	determineTownGoals(target);
	if (target.charName != "Aude Auteberry") {
		addDestination(target,_root.gameStage.field,2);
	}
}
function setFameEvents() {
	fameEvents.push(["Herbs", 1]);
	fameEvents.push(["Scrolls", 1]);
	fameEvents.push(["Armadus", 2]);
	fameEvents.push(["Elias", 3]);
	fameEvents.push(["Faint Man", 6]);
	fameEvents.push(["Herbs", 7]);
	fameEvents.push(["Kazash", 8]);
	fameEvents.push(["Toad", 10]);
	fameEvents.push(["Mountain Goat", 12]);
	fameEvents.push(["Scrolls", 13]);
	fameEvents.push(["Hora", 15]);
	fameEvents.push(["Lexicon", 16]);
	fameEvents.push(["Acarime", 17]);
	fameEvents.push(["Spawn", 18]);
	fameEvents.push(["Stats", 20]);
	fameEvents.push(["Arasof Appears", 25]);
	fameEvents.push(["Arasof", 25]);
	fameEvents.push(["Neria", 28]);
	fameEvents.push(["CoS Scrub", 30]);
	fameEvents.push(["Crescent", 34]);
	fameEvents.push(["CoS Appears", 37]);
	fameEvents.push(["CoS Member", 39]);
	fameEvents.push(["Scrolls", 42]);
	fameEvents.push(["Undead", 43]);
	fameEvents.push(["Mathias", 45]);
	fameEvents.push(["Landfish", 45]);
	fameEvents.push(["Sola", 48]);
	fameEvents.push(["CoS Captain", 50]);
}
function useFameEvent() {
	eventName = fameEvents[0][0];
	del = true;
	switch (eventName) {
		case "Armadus" :
			introduceChar("Armadus Broghton",2);
			latestNews = "Armadus has come to fortify the town.";
			break;
		case "Elias" :
			introduceChar("Elias Odremont",2);
			latestNews = "Let's give Elias a warm welcome full of stickball.";
			break;
		case "Neria" :
			introduceChar("Neria Cyonire",2);
			latestNews = "Neria just wants to set about her business. Drop by and say hello anyway!";
			break;
		case "Herbs" :
			getItem("Herbs",5);
			_root.useMenu("Event");
			//getItem("Sword Lexicon",3);
			_root.menuMC.nameDisplay.text = "Items Found!";
			_root.menuMC.textDisplay.text = "A traveling merchant has gifted us 5 healing herbs from Relinq!";
			break;
		case "Stats" :
			getItem("Meat Stew",2);
			getItem("Elixir",2);
			getItem("Target Dummy",2);
			getItem("Labor Manual",2);
			getItem("Literature",4);
			getItem("4Leaf Clover",4);
			_root.useMenu("Event");
			//getItem("Sword Lexicon",3);
			_root.menuMC.nameDisplay.text = "Items Found!";
			_root.menuMC.textDisplay.text = "A traveling merchant has gifted us various items!";
			break;
		case "Kazash" :
			introduceChar("Kazash Amir",2);
			latestNews = "Kazash arrives with a smug smile.";
			break;
		case "Hora" :
			introduceChar("Hora Danibel",2);
			latestNews = "Hora Danibel doesn't seem to care for our welcomes!";
			break;
		case "Mathias" :
			introduceChar("Mathias Adrichen",2);
			latestNews = "Mathias comes in search of a friend.";
			break;
		case "Sola" :
			introduceChar("Sola Calcifron",2);
			latestNews = "Let's welcome Sola Calcifron to " + townName + "!";
			break;
		case "Faint Man" :
			addQuest("Faint Man");
			latestNews = "Children are abducted by a strange tall figure.";
			break;
			case "Landfish" :
			addQuest("Landfish");
			//latestNews = "Children are abducted by a strange tall figure.";
			break;
		case "Crescent" :
			addQuest("Crescent");
			latestNews = "The undead are rising.";
			break;
		case "Mountain Goat" :
			addQuest("Mountain Goat");
			latestNews = townName + " is in a food crisis!";
			break;
		case "Toad" :
			addQuest("Toad");
			break;
		case "Spawn" :
			addQuest("Spawn");
			latestNews = "Strange creatures are beginning to appear around town.";
			break;
		case "CoS Scrub" :
			addQuest("CoS Scrub");
			latestNews = "An unidentified armored man scouts the area.";
			break;
		case "CoS Captain" :
			addQuest("CoS Captain");
			latestNews = "The CoS are increasing their efforts to stop Soveran.";
			break;
		case "CoS Member" :
			addQuest("CoS Member");
			latestNews = "We are under fire from the Children of the Sacrosanct!";
			break;
		case "Acarime" :
			spawnRandomMob(false,null,1025,"Acareme Soldier");
			spawnRandomMob(false,null,1025,"Acareme Archer");
			latestNews = townName + " has drawn negative attention from Acarime.";
			_root.useMenu("Welcome","char",_root.findEnemy("Acareme Soldier"));
			break;
		case "Lexicon" :
			_root.useMenu("Event");
			getItem("Sword Lexicon",1);
			_root.menuMC.nameDisplay.text = "Items Found!";
			_root.menuMC.textDisplay.text = "While fighting in the dungeons, somebody found a Sword Lexicon! Sell it to upgrade our sword stock!";
			break;
		case "Scrolls" :
			_root.useMenu("Event");
			getItem("Famous Scrolls",1);
			_root.menuMC.nameDisplay.text = "Items Found!";
			_root.menuMC.textDisplay.text = "I was digging around the inn basement and found this. Sell it, it might be worth something.";
			break;
		case "Arasof Appears" :
			_root.menuMC.dialogue = new Array();
			smc = _root.menuMC.dialogue;
			smc.push(["Arasof Eninsula", "Hmmm..."]);
			smc.push(["Arasof Eninsula", "So this is where these fools are training. What a miserable operation."]);
			smc.push(["Arasof Eninsula", "It would be so easy to crush them. I could even refrain from casting spells, just so they have a semblance of a chance!"]);
			smc.push(["Arasof Eninsula", "Yes.. I will make my move soon. The battle will begin, and may victory bless the deserving."]);
			smc.push(["Kavaan Rhiordall", "Everyone! Adelain spotted outside of town!!"]);
			smc.push(["Aude Auteberry", "Haha.. you're kidding, right? We haven't properly prepared..."]);
			smc.push(["Armadus Broghton", "Negative. I can confirm this sighting. An Adelain by the name of Arasof Eninsula has come."]);
			smc.push(["Aude Auteberry", "I see. When he appears, we'd better move quick, or his presence will take its toll."]);
			_root.useMenu("Plot");
			latestNews = "Everyone is bracing for an attack. The air is chill.";
			break;
		case "Arasof" :
			addQuest("Arasof Eninsula");
			latestNews = "Attack! An Adelain has come!";
			break;
		case "CoS Appears" :
			spawnRandomMob(false,null,1025,"CoS Scrub");
			_root.menuMC.dialogue = new Array();
			smc = _root.menuMC.dialogue;
			smc.push(["CoS Scrub", "I have heard from my superiors there is an anti-Adelain movement here."]);
			smc.push(["CoS Scrub", "Soveran must be stopped! For great Justice!"]);
			smc.push(["CoS Scrub", "Adelains are true and holy! Why do you not see it!?"]);
			smc.push(["CoS Scrub", "I, as a member of the elite Children of the Sacrosanct, shall purify your souls!"]);
			smc.push(["CoS Scrub", "By death you will all see the light!"]);
			smc.push([randomName(), "Was someone talking?"]);
			_root.useMenu("Plot");
			latestNews = "The Children of the Sacrosanct move against Soveran!";
			break;
		case "Undead" :
			//spawnRandomMob(false,null,1025,"CoS Scrub");
			_root.menuMC.dialogue = new Array();
			smc = _root.menuMC.dialogue;
			smc.push(["Faint Man", "...."]);
			smc.push(["Crescent", "...."]);
			smc.push(["Spawn", "...."]);
			smc.push(["Aude Auteberry", "Something is stirring deep below us. I'm not sure what it is.."]);
			smc.push(["Aude Auteberry", "It's otherworldy.. All this nonsense about this and that.."]);
			smc.push(["Aude Auteberry", "I'm beginning to think there's more to our troubles than rogue magi."]);
			smc.push(["Aude Auteberry", "If only someone of more insight would enlighten us."]);
			_root.useMenu("Plot");
			latestNews = "A link to the underworld may have been established somehow.";
			break;
		default :
	}
	if (del == true) {
		fameEvents.shift();
	}
}
function initBuilding(type, target) {
	target.DEF = 10;
	target.aDEF = 10;
	target.var1 = 0;
	target.var2 = 0;
	switch (type) {
		case "Inn" :
			target.cost = 300;
			target.maxHP = 200;
			target.curHP = target.maxHP;
			target.upkeep = 600;
			target.baseAppeal = 50;
			break;
		case "Weapon Shop" :
			target.cost = 400;
			target.maxHP = 300;
			target.curHP = target.maxHP;
			target.upkeep = 700;
			target.baseAppeal = 5;
			break;
		case "Guard Post" :
			target.cost = 500;
			target.maxHP = 3000;
			target.aDEF = 50;
			target.curHP = target.maxHP;
			target.upkeep = 500;
			target.baseAppeal = 0;
			break;
		case "Armory" :
			target.cost = 500;
			target.maxHP = 500;
			target.curHP = target.maxHP;
			target.upkeep = 800;
			target.baseAppeal = 13;
			break;
		case "Pub" :
			target.cost = 500;
			target.maxHP = 100;
			target.curHP = target.maxHP;
			target.upkeep = 800;
			target.baseAppeal = 0;
			break;
		case "Grill" :
			target.cost = 500;
			target.maxHP = 200;
			target.curHP = target.maxHP;
			target.upkeep = 900;
			target.baseAppeal = 5;
			break;
		case "Pharmacy" :
			target.cost = 450;
			target.maxHP = 300;
			target.curHP = target.maxHP;
			target.upkeep = 700;
			target.baseAppeal = 20;
			break;
		case "Soup Kitchen" :
			target.cost = 500;
			target.maxHP = 200;
			target.curHP = target.maxHP;
			target.upkeep = 650;
			target.baseAppeal = 5;
			break;
		case "Darts House" :
			target.cost = 400;
			target.maxHP = 150;
			target.curHP = target.maxHP;
			target.upkeep = 600;
			target.baseAppeal = 8;
			break;
		case "Juice Stand" :
			target.cost = 300;
			target.maxHP = 50;
			target.curHP = target.maxHP;
			target.upkeep = 350;
			target.baseAppeal = 11;
			break;
		case "Gym" :
			target.cost = 450;
			target.maxHP = 200;
			target.curHP = target.maxHP;
			target.upkeep = 550;
			target.baseAppeal = 9;
			break;
		case "BBQ" :
			target.cost = 500;
			target.maxHP = 200;
			target.curHP = target.maxHP;
			target.upkeep = 500;
			target.baseAppeal = 8;
			break;
		case "Tree" :
			target.cost = 300;
			target.maxHP = 500;
			target.curHP = target.maxHP;
			target.upkeep = 300;
			target.baseAppeal = 8;
			break;
		default :
			target.cost = 500;
			target.maxHP = 100;
			target.curHP = target.maxHP;
			target.upkeep = 800;
			target.baseAppeal = 0;
			break;
	}
}
//Find cost of a building
function getBuildCost(type) {
	switch (type) {
		case "Inn" :
			return 800;
		case "Weapon Shop" :
			return 1200;
		case "Guard Post" :
			return 1100;
		case "Pub" :
			return 1000;
		case "Grill" :
			return 1000;
		case "Pharmacy" :
			return 900;
		case "Armory" :
			return 1200;
		case "Soup Kitchen" :
			return 1100;
		case "Darts House" :
			return 1300;
		case "Juice Stand" :
			return 800;
		case "Gym" :
			return 1350;
		case "BBQ" :
			return 1300;
		case "Tree" :
			return 900;
		default :
			break;
	}
}
//Use Facility
function useFacility(target, facility) {
	facilType = facility.buildType;
	if (target.charName == "Aude Auteberry" && target.curHP == target.maxHP && facilType == "Inn") {
		return;
	}
	//Add gold, etc                                                                                                                            
	target.gotoAndPlay("Building");
	target.curState = "Indoors";
	willPay = true;
	paidCost = facility.cost;
	switch (facilType) {
		case "Inn" :
			if (_root.innEntertainment == "Luxury Week") {
				paidCost += 100;
			} else if (_root.innEntertainment == "Complimentary coupons") {
				if (target.sex == "F") {
					addSatisfaction(target,2);
				}
			} else if (_root.innEntertainment == "Used panties night") {
				if (target.sex == "M") {
					addSatisfaction(target,2);
				}
			} else if (_root.innEntertainment == "Sword polishing night") {
				addEXP(target,target.LUC);
			}
			speech(target,"Heal");
			amount = target.maxHP - target.curHP;
			buff(target,"Heal",amount);
			traceF(target.charName + " has healed at the Inn!",1);
			break;
		case "Weapon Shop" :
			target.STR++;
			infoDisplay("Stat",target,"STR Up!!");
			break;
		case "Guard Post" :
			target.SKL++;
			infoDisplay("Stat",target,"SKL Up!!");
			break;
		case "Darts House" :
			target.SKL += 2;
			infoDisplay("Stat",target,"SKL Up!!");
			break;
		case "Armory" :
			target.DEF++;
			infoDisplay("Stat",target,"DEF Up!!");
			break;
		case "Pub" :
			if (target.sex == "F") {
				speech(target,"-hic-HEHEHEHE!");
			} else {
				speech(target,"-hic-GAHAHAHA!");
			}
			target.maxHP++;
			infoDisplay("Stat",target,"HP Up!!");
			break;
		case "Grill" :
			target.maxHP += 2;
			infoDisplay("Stat",target,"HP Up!!");
			break;
		case "Soup Kitchen" :
			target.maxHP += 2;
			infoDisplay("Stat",target,"HP Up!!");
			break;
		case "Juice Stand" :
			target.maxHP += 1;
			infoDisplay("Stat",target,"HP Up!!");
			break;
		case "Gym" :
			target.DEF += 2;
			infoDisplay("Stat",target,"DEF Up!!");
			break;
		case "BBQ" :
			target.STR += 2;
			infoDisplay("Stat",target,"STR Up!!");
			break;
		case "Pharmacy" :
			if (healthKits > 0) {
				target.hKits++;
				healthKits--;
				infoDisplay("Stat",target,"Got Health Kit!");
			} else {
				speech(target,"Out of stock!");
				willPay = false;
			}
			break;
		default :
			break;
	}
	if (willPay == true) {
		target.facilitiesUsed++;
		facility.income += paidCost;
		earnGold(target,facility.cost);
	}
}
function specialAppeal(target, facility) {
	character = target.charName;
	if (character == "Elias Odremont" && facility == "Pub") {
		speech(target,"I need a drink..");
		return 30;
	}
	if (character == "Armadus Broghton" && facility == "Armory") {
		speech(target,"Clang!");
		return 30;
	}
	if (character == "Kavaan Rhiordall" && facility == "Grill") {
		speech(target,"Yum!");
		return 30;
	}
	if (character == "Kazash Amir" && facility == "Gym") {
		//speech(target,"Clang!");
		return 30;
	}
	return 0;
}
function getWeaponDamage(weapon) {
	switch (weapon) {
		case "Knife" :
			return 1.5;
		case "Sword" :
			return 2.0;
		case "Staff" :
			return 2.2;
		case "Self Bow" :
			return 2.0;
		case "Hatchet" :
			return 2.8;
		case "Dagger" :
			return 1.7;
		case "Cutlass" :
			return 2.4;
		case "Spear" :
			return 2.6;
		case "Recurve" :
			return 2.3;
		case "Axe" :
			return 3.0;
		case "Bleeder" :
			return 2.0;
		case "Cruciform" :
			return 2.6;
		case "Broadhead" :
			return 2.8;
		case "Braced Bow" :
			return 2.6;
		case "Morningstar" :
			return 3.3;
		case "Spike" :
			return 2.4;
		case "Noble" :
			return 2.9;
		case "Cross Spear" :
			return 3.1;
		case "Shortbow" :
			return 2.9;
		case "Broadaxe" :
			return 3.5;
		case "Azra" :
			return 2.7;
		case "Sun Blade" :
			return 3.2;
		case "Ornate" :
			return 3.3;
		case "Scout Bow" :
			return 3.2;
		case "Waraxe" :
			return 3.8;
		case "Jewel" :
			return 3.0;
		case "Hammerhead" :
			return 3.5;
		case "Pike" :
			return 3.4;
		case "Eagle" :
			return 3.5;
		case "Bardiche" :
			return 4.4;
		case "Sola's Sword" :
			return 2.8;
		case "Aude's Hellebarde" :
			return 2.0 + weaponLevels[2];
		default :
			return 2.0;
	}
}
function getWeaponPrice(tier) {
	switch (tier) {
		case 1 :
			return 600;
		case 2 :
			return 1200;
		case 3 :
			return 2000;
		case 4 :
			return 6000;
		case 5 :
			return 8500;
		case 6 :
			return 11040;
		case 7 :
			return 28300;
		case 8 :
			return 45000;
		default :
			return 10000;
	}
}
function getWeaponName(tier, type) {
	if (type == "Knife") {
		switch (tier) {
			case 1 :
				return "Knife";
			case 2 :
				return "Dagger";
			case 3 :
				return "Bleeder";
			case 4 :
				return "Spike";
			case 5 :
				return "Azra";
			case 6 :
				return "Jewel";
			default :
				return "Knife";
		}
	} else if (type == "Sword") {
		switch (tier) {
			case 1 :
				return "Sword";
			case 2 :
				return "Cutlass";
			case 3 :
				return "Cruciform";
			case 4 :
				return "Noble";
			case 5 :
				return "Sun Blade";
			case 6 :
				return "Hammerhead";
			default :
				return "Knife";
		}
	} else if (type == "Spear") {
		switch (tier) {
			case 1 :
				return "Staff";
			case 2 :
				return "Spear";
			case 3 :
				return "Broadhead";
			case 4 :
				return "Cross Spear";
			case 5 :
				return "Ornate";
			case 6 :
				return "Pike";
			default :
				return "Knife";
		}
	} else if (type == "Bow") {
		switch (tier) {
			case 1 :
				return "Self Bow";
			case 2 :
				return "Recurve";
			case 3 :
				return "Braced Bow";
			case 4 :
				return "Shortbow";
			case 5 :
				return "Scout Bow";
			case 6 :
				return "Eagle";
			default :
				return "Knife";
		}
	} else if (type == "Heavy") {
		switch (tier) {
			case 1 :
				return "Hatchet";
			case 2 :
				return "Axe";
			case 3 :
				return "Morningstar";
			case 4 :
				return "Broadaxe";
			case 5 :
				return "Waraxe";
			case 6 :
				return "Bardiche";
			default :
				return "Knife";
		}
	} else {
		return "Knife";
	}
}
function getBloodHoleMob(charLvl) {
	return "Bloody Imp";
}
function selectMob(mobType) {
	if (mobType == null) {
		//chosenOne = "";
		high = 80 + int(fame * 3.3);
		low = high - (80 + fame);
		rand = getRandomBetween(low, high);
		if (rand > 250) {
			return "Crescent";
		}
		if (rand > 240) {
			return "Landfish";
		}
		if (rand > 230) {
			return "CoS Scrub";
		}
		if (rand > 225) {
			return "Faint Man";
		}
		if (rand > 210) {
			return "Evil Eye";
		}
		if (rand > 200) {
			return "Spawn";
		}
		if (rand > 185) {
			return "Homunculus";
		}
		if (rand > 170) {
			return "Acareme Archer";
		}
		if (rand > 155) {
			return "Acareme Soldier";
		}
		if (rand > 135) {
			return "Mountain Goat";
		}
		if (rand > 130) {
			return "Benjourn";
		}
		if (rand > 80) {
			return "Toad";
		}
		if (rand > 60) {
			return "Petty Thief";
		}
		return "Wild Hare";
	} else {
		return mobType;
	}
}
function getInnEnt(entGen) {
	switch (entGen) {
		case 1 :
			return "Leftover soup chugging";
		case 2 :
			return "Used panties night";
		case 3 :
			return "Worshipping Atherios 101";
		case 4 :
			num = getRandomUnder(players.length) - 1;
			return "Let's prank " + players[num].charName;
		case 5 :
			return "Sword polishing night";
		case 6 :
			return "Afternoon naps week";
		case 7 :
			return "Luxury Week";
		case 8 :
			return "Complimentary coupons";
		default :
			return "Bedbug hunting";
	}
}
function initInventory() {
	inventory[0] = ["Herbs", 0, 200, "Bitter Relinqian herbs. Heals half of the character's HP."];
	inventory[1] = ["Potion", 0, 500, "Brewed potions. Heals HP fully."];
	inventory[2] = ["Meat Stew", 0, 1200, "Old time home cooking. Adds STR to characters."];
	inventory[3] = ["Labor Manual", 0, 1200, "Teaches endurance. Adds DEF to characters."];
	inventory[4] = ["Target Dummy", 0, 1200, "Very masochistic dummy. Adds SKL to characters."];
	inventory[5] = ["4Leaf Clover", 0, 1200, "Adds LUC to characters and cost to facilities."];
	inventory[6] = ["Literature", 0, 1200, "Adds WIS to characters and appeal to facilities."];
	inventory[7] = ["Elixir", 0, 1200, "An elixir of life. Adds to character's health."];
	inventory[8] = ["Gold Bar", 0, 3000, "Just a bar of gold. Nothing special. Good as a gift."];
	inventory[9] = ["Huge Gemstone", 0, 5000, "Big and valuable. Good as a gift."];
	inventory[10] = ["Might Scroll", 0, 10000, "Teaches mighty striking skills."];
	inventory[11] = ["Heal Scroll", 0, 20000, "Teaches healing magic."];
	inventory[12] = ["Light Scroll", 0, 15000, "Teaches offensive light magic."];
	inventory[13] = ["Atherios Toy", 0, 2000, "A bobblehead of Atherios the prophet."];
	inventory[14] = ["Naughty Book", 0, 2000, "Full of forbidden images."];
	inventory[15] = ["Fancy Sword", 0, 2000, "So sharp! So fancy! Yet looks bad for combat."];
	inventory[16] = ["Distilled Boredom", 0, 2000, "Can be used as sleep medication."];
	inventory[17] = ["Cuddly Pillow", 0, 2000, "Eliminates loneliness with plushness."];
	inventory[18] = ["Old Locket", 0, 2000, "Who knows what's inside?"];
	inventory[19] = ["Sword Lexicon", 0, 20000, "Diagrams of various swords."];
	inventory[20] = ["Dagger Atlas", 0, 20000, "An encyclopedia of dagger designs."];
	inventory[21] = ["Spear Tome", 0, 20000, "Filled with all the spears of Silatria."];
	inventory[22] = ["Archers' Codex", 0, 20000, "Bowcrafting techniques passed down in Belwood."];
	inventory[23] = ["Power Compendium", 0, 20000, "Details the art of using heavy weapons."];
	inventory[24] = ["Cannot Find", 0, 1, "An item that never seems to be found"];
	inventory[25] = ["Famous Scrolls", 0, 2000, "Parts of a series known throughout Silatria. Sell for fame."];
	inventory[26] = ["Legendary Scriptures", 0, 5999, "Parts of a series known throughout Cathedral. Sell for fame."];
}
function loadQuestInfo() {
	questInfo = new Array();
	questInfo.push(["Benjourn", "Crazy Clown", "Ugh, there's a crazy clown at the cavern. Please get rid of it!", 500, "Cavern", 100]);
	questInfo.push(["Faint Man", "A Tall Figure", "There's a strange somebody out there.. It may be worthwhile to send a dispatch group.", 1000, "Cavern", 110]);
	questInfo.push(["Spawn", "Artificial Life", "A creature called from the underworld has appeared. Fight it off!", 1050, "Bloody Hole", 100]);
	questInfo.push(["Arasof Eninsula", "The Extremist", "He's here, a real Adelain! We must move quickly!", 1200, "Hell's Entrance", 110]);
	questInfo.push(["CoS Scrub", "Strange Presence", "That man looks shady. He's up to something. Take him down!", 1050, "Cavern", 100]);
	questInfo.push(["CoS Member", "Investigation", "Those cultists have sent another member over to watch us.", 1200, "Ice Pit", 110]);
	questInfo.push(["Mountain Goat", "Food Stores", "Our town is going a bit hungry, but if we hunted some game..", 800, "Cavern", 100]);
	questInfo.push(["Toad", "Warts", "Just rid of it.", 600, "Cavern", 100]);
	questInfo.push(["Crescent", "Rising Again", "What is that? We'd better have a look.", 1300, "Bloody Hole", 110]);
	questInfo.push(["CoS Captain", "Sacrosanct Captain", "Their captain has come to avenge its underlings.", 1350, "Ice Pit", 120]);
	questInfo.push(["Landfish", "Fine Dining", "I find people have some strange taste sometimes. Let's hunt it anyway.", 950, "Bloody Hole", 100]);
	
	//nm = "";
	//msg = "";
	//cost = 1000;
	//place = "Cavern";
	//urgency = 100;
}
function getQuestInfo(qName, req) {
	for (i = 0; i < questInfo.length; i++) {
		if (qName == questInfo[i][0]) {
			switch (req) {
				case "Name" :
					return questInfo[i][1];
				case "Info" :
					return questInfo[i][2];
				case "Cost" :
					return questInfo[i][3];
				case "Place" :
					return questInfo[i][4];
				case "Urgency" :
					return questInfo[i][5];
				default :
					break;
			}
		}
	}
}
function getSpecialGift(charName) {
	switch (charName) {
		case "Armadus Broghton" :
			return "Distilled Boredom";
		case "Mathias Adrichen" :
			return "Old Locket";
		case "Valin Scryber" :
			return "Fancy Sword";
		case "Serenna Azurell" :
			return "Atherios Toy";
		case "Ashera Relindi" :
			return "Naughty Book";
		case "Linvi Askelore" :
			return "Cuddy Pillow";
		default :
			return "Cannot Find";
	}
}
function getRanEvent() {
	//News generator: town or character?
	if (getRandomUnder(10) <= 7) {
		//char news: find a random character
		inQ = getFirstName(players[getRandomUnder(players.length) - 1]);
		ranGen = getRandomUnder(4);
		if (inQ == "Aude") {
			if (ranGen == 1) {
				return "Man unsuccesfully asks Aude on a date.";
			} else if (ranGen == 2) {
				return "Aude promoting Ialesian lute duet.";
			} else if (ranGen == 3) {
				num = getRandomBetween(4, 9);
				return "Ms. Auteberry finishes " + num + "th in spear-fighting competition. She voews to train harder.";
			} else {
				return "Befuddled people notice Aude counts her steps carefully.";
			}
		} else if (inQ == "Kavaan") {
			if (ranGen == 1) {
				if (findCharacter("Hora Danibel") != null) {
					return "Gossip: Kavaan denies feelings despite being seen blushing while watching Hora Danibel.";
				} else {
					return "Kavaan Rhiordall seen saving up gifts and money.";
				}
			} else {
				return "Kavaan is penniless after treating neighbors to dinner.";
			}
		} else if (inQ == "Elias") {
			if (ranGen == 1) {
				return "Wanted! Anyone willing to learn stickball with Elias Odremont.";
			} else if (ranGen == 2) {
				if (findCharacter("Neria Cyonire") == null) {
					return "Elias seen slacking off during combat training.";
				} else {
					return "Elias tries to win the heart of Neria Cyonire.";
				}
			} else if (ranGen == 3) {
				return "Elias's makeshift stickball team, the " + townName + " Hillmasters, loses " + getRandomBetween(2, 5) + "-" + getRandomBetween(5, 31);
			} else {
				return "Elias is requesting money from home. Residents welcome to donate.";
			}
		} else if (inQ == "Armadus") {
			if (ranGen == 1) {
				return "Armadus trying to rally town into one big unit to attack potential threats.";
			} else if (ranGen == 2) {
				return "Armadus Broghton fined 100G for sexual abuse of waitresses.";
				earnGold2(100);
			} else if (ranGen == 3) {
				return "Armadus dreadfully boring, local man claims.";
			} else {
				return "Report: Armadus may be source of clammy odor.";
			}
		} else if (inQ == "Kazash") {
			if (ranGen == 1) {
				return "Citizens fearful as Kazash spotted dismembering dummies.";
			} else if (ranGen == 2) {
				if (findCharacter("Valin Scryber") == null) {
					return "Kazash tries to apply as city guard.";
				} else {
					return "Kazash reportedly shares dating advice with Valin Scryber.";
				}
			} else {
				return "Townspeople suspect Kazash has ulterior motives.";
			}
		} else if (inQ == "Hora") {
			if (ranGen == 1) {
				return "Hora spotted sulking for a day straight at the Inn.";
			} else if (ranGen == 2) {
				return "Unreliable witness claims Hora spotted wearing something other than black for a minute.";
			} else if (ranGen == 3) {
				return "'Maybe Hora just wants love,' Aude suggests.";
			} else {
				return "Receiving many complaints about Hora's complaints.";
			}
		} else if (inQ == "Mathias") {
			if (ranGen == 1) {
				return "Mathias tries to prove himself, defeats bear with bare hands.";
			} else if (ranGen == 2) {
				if (findCharacter("Javier Zarasthra") == null) {
					return "Mathias plans to visit Belwood.";
				} else {
					return "Mathias Adrichen and Javier Zarasthra become blood brothers!";
				}
			} else if (ranGen == 3) {
				if (findCharacter("Linvi Askelore") == null) {
					return "Report: Mathias caught talking to pictures.";
				} else {
					return "Gossip: Mathias is in love with Linvi Askelore!";
				}
			} else {
				return "Mathias to give speech on why Acarime is terrible.";
			}
		} else if (inQ == "Quinton") {
			if (ranGen == 1) {
				return "Request: Quinton seeks a wig of any kind.";
			} else {
				return "Quinton's comedy club is a complete failure.";
			}
		} else if (inQ == "Neria") {
			if (ranGen == 1) {
				return "Neria dies a bloody death! But fate brought her back to life.";
			} else if (ranGen == 2) {
				return "Neria is packed up! Is she leaving?";
			} else if (ranGen == 3) {
				if (findCharacter("Elias Odremont") == null) {
					return "Neria is losing sleep over Elias!";
				} else {
					return "Request: Neria Cyonire wants a violin lesson. Will pay 40G to willing teacher.";
				}
			} else {
				return "Report: Neria empties Inn's breakfast room. 'I was just too hungry!'";
			}
		} else if (inQ == "Sola") {
			if (ranGen == 1) {
				return "Sola is seen praying for lost souls.";
			} else if (ranGen == 2) {
				return "Medics complain about Sola's spontaneous recklessness.";
			} else if (ranGen == 3) {
				return "Sola Calcifron wishes to offer advice on Adelain combat.";
			} else {
				return "Sola spotted staring blankly at the wall, muttering stories of battles.";
			}
		}
	} else {
		//town news
		ranGen = getRandomUnder(7);
		if (ranGen == 1) {
			return "Local farmers discover strange banana-like apple.";
		} else if (ranGen == 2) {
			return "A traveling preacher hangs up countless Revician crosses at the inn.";
		} else if (ranGen == 3) {
			return "Medic questions the safety of consuming meat stews dropped in the dungeon.";
		} else if (ranGen == 4) {
			return "Made " + monthlyIncome + "G so far this month!";
		} else if (ranGen == 5) {
			return "A boulder with an interior of beef is found on the outskirts!";
		} else if (ranGen == 6) {
			return "Used " + monthlyExpense + "G this month!";
		} else {
			return "Weather: It's a sunny day.. like always.";
		}
	}
}


menuMC.swapDepths(10032);
//FINAL CODE FUNCTIONS
//Set stage OR Initiate stage, based on save data
initiateTown();
loadQuestInfo();

