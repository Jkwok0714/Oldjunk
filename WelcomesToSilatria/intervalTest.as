timed = 0;
function updateText() {
	display.text = timed;
	timed++;
	if (timed >5) {
		clearInterval(updater);
	}
}

updater = setInterval(updateText, 1000);
