fame = 1;
while (fame < 20) {
	numb = 80 + (fame * 2);
	fame++;
	famerText.text += fame+" fame, "+(numb-(80+fame))+"~"+ numb + "\n";
}