function initChar() {
	this.lvl = 89;
	this.aDEF += 30;
	this.AGI += 180;
	this.STR += 120;
	this.CON += 190;
	this.VIT += 100;
	this.HP += 990300;
	this.highestHP += 990300;
	this.disposition = "Daemon";
}
this.gender = "F";

// Move
skillChance = int(Math.random()*14)+1;
if (this.HP<1000) {
	skillChance += 2;
}
if (skillChance>13) {
	gotoAndPlay("Bankai");
} else if (skillChance>11) {
	gotoAndPlay("Shikai");
} else if (skillChance>10) {
	gotoAndPlay("Hollow");
}

// Attack

damage = _root.getRandomBetween(9700, 13000);
_root.attack(this, damage, "Blade");

// Special

if (_root.Ground.hitTest(this._x, this._y+6, true)) {
	_root.playerWalk(this,speed,8);
	//this._x -= this.speed;
}
damage = _root.getRandomBetween(120, 160);
_root.attack(this, damage, "Vital");

// Projectile (Manami)

damage = _root.getRandomBetween(70, 90);
_root.attack(this, damage, "Single");
//
_root.attachMovie("Arrows5","flyWeapon"+_root.projectiles,_root.projectiles+2900);
_root["flyWeapon"+_root.projectiles]._x = this._x;
_root["flyWeapon"+_root.projectiles]._y = this._y;
_root["flyWeapon"+_root.projectiles].caster = this;
_root["flyWeapon"+_root.projectiles]._xscale = this._xscale;
_root.projectiles++;
if (_root.projectiles>_root.maxProj) {
	_root.projectiles = 1;
}