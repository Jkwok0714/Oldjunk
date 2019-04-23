def = 4;
function getCost(input) {
	return int(700 * Math.pow(2, input / 8));
}
while (def < 50) {
	displayBox.text += "Cost to upgrade at "+def+": "+getCost(def)+".\n";
	def++;
}