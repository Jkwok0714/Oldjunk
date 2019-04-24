onClipEvent (enterFrame) {
	for (var q = 0; q<=_root.charsAry.length; q++) {
		if (_root.charsAry[q].bodyArea.hitTest(_root._xmouse, _root._ymouse, true)) {
			if (Key.isDown(Key.BACKSPACE)) {
				_root.charsAry[q].charDie("God");
			}
			if (_root._xmouse>575) {
				this._x = _root._xmouse-125;
				this.Box._xscale = -100;
			} else {
				this._x = _root._xmouse+12;
				this.Box._xscale = 100;
			}
			this._y = _root._ymouse;
			if (_root.charsAry[q].veteran == true) {
				this.name = _root.charsAry[q].name+" [V]";
			} else {
				this.name = _root.charsAry[q].name;
			}
			this.Str = _root.charsAry[q].STR;
			this.Vit = _root.charsAry[q].aDEF+"+"+_root.charsAry[q].VIT;
			this.Agi = _root.charsAry[q].AGI;
			this.Con = _root.charsAry[q].CON;
			this.Buff = _root.charsAry[q].Buff;
			this.charAct = _root.charsAry[q].charAct;
			this.Age = Math.round(_root.charsAry[q].Age/18);
			this.Kills = _root.charsAry[q].Kills;
			this.Team = _root.charsAry[q].Team;
			Store1 = _root.charsAry[q].HP;
			Store2 = _root.charsAry[q].highestHP;
			Percent = (Store1/Store2)*100;
			this.HPBar._xscale = Percent;
			Winton = _root.charsAry[q].infoIndex;
			if (_root["status"+Winton].Cover._currentframe == 1) {
				_root["status"+Winton].Cover.gotoAndPlay("Selected");
			}
			break;
		} else {
			this._x = 750;
		}
	}
}