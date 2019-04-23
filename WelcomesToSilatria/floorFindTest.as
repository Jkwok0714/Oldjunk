curY = 145;
findFloor();
recurse();
function findFloor() {
	curFloor = (curY - 65)/80;
	oddEven = determineOdd(curFloor);
	printOut.text += curFloor + oddEven + "\n";
}
function determineOdd(num) {
	if (num % 2 == 0) {
		return " is even";
	} else {
		return " is odd";
	}
}
function recurse() {
	for (i = 0; i < 7; i++) {
		curY += 80;
		findFloor();
	}
}