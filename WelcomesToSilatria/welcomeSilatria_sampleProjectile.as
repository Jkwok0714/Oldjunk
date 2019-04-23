stop();
this.movTime = 0;
this._visible = false;
this.spent = false;
//Make the arrow fly
this.onEnterFrame = function() {
	if (this._currentframe != 1) {
		return;
	}
	if (this.movTime == 0) {
		if (this.movDir == 0) {
			//Move L
			this._xscale = 100;
		} else {
			//Move R
			this._xscale = -100;
		}
		movTime += 20;
		this._visible = true;
	} else if (this.movTime == 1) {
		this.removeMovieClip();
	} else {
		if (this.movDir == 0) {
			this._x -= movSpeed;
		} else {
			this._x += movSpeed;
		}
		if (this.spent == false) {
			_root.attack(char,victim,attack,effect,this);
		}
	}
};