/* WORD COUNTER
 * By: Justin Kwok
 * Date: 02/28/09
 * Description: This program counts words and letters and things
 *   The definition of a word will be a string of characters seperated by
 *   spaces
 *   This program will also count spaces, misc characters, numbers, and vowels.
 *   Finally the program will attempt to count sentences.
 *   Sentences will be anything from an alphanumeric character up to punctuation.
 *   Everything only seems to work with correct grammar and punctuation.
 */

#include <stdio.h>
#include <string.h>
#define MAXCHARS 1000

/* Prototypes */
void countLetters(char n[], int lengthOfString);
void countWords(char n[], int lengthOfString);
void countSentences(char n[], int lengthOfString);
void countOther(char n[], int lengthOfString);
int determineLetter(char c);
int determineAN(char c);
int determineNumeric(char c);
int determineVowel(char c);
int determineOperator(char c);

int main(void) {
	/* Declare variables for storing stuff */
	char inputString[MAXCHARS];
	
	/* Get some input */
	gets(inputString);
	int lengthOfString = strlen(inputString);
	
	/* Now that we have the input string, iterate over it to see how many words there are */
	countLetters(inputString, lengthOfString);
	printf("\n");
	
	/* Count the number of WORDS now. */
	countWords(inputString, lengthOfString);
	
	/* As extra, try and see how many sentences there are */
	countSentences(inputString, lengthOfString);
	
	/* Finally try to count some vowels, numbers, etc. */
	countOther(inputString, lengthOfString);
	
	/* Done counting */
	printf("Done counting.\n\n");
       
    /* End */
    return 0;
}

/* this function takes the character array and counts the characters */
void countLetters(char n[], int lengthOfString) {
	/* Print the string length */
	printf("The length of the string is %d\n", lengthOfString);
	
	/* Now count the letters */
	int i;
	int numLetters = 0;
	int numMisc = 0;
	int numSpaces = 0;
	for (i=0; i<lengthOfString;i++) {
		if (n[i] == ' ') {
			numSpaces++;
		} else {
			if (determineLetter(n[i])) {
				numLetters++;
			} else if (!determineLetter(n[i])) {
				numMisc++;
			}
		}
		
	}
	
	/* Print the result */
	printf("There are %d letters in it.\n", numLetters);
	printf("There are %d spaces too,\n", numSpaces);
	printf("and %d misc. characters.\n", numMisc);
	
	/* end */
	return;
}

/* Counts the number of words. */
void countWords(char c[], int lengthOfString) {
	/* used to determine if it's a word */
	int numWords = 0, isWord = 0;
	
	/* Iterate over the array of chars to find words */
	int i;
	for (i = 0; i<lengthOfString;i++) {
		if (determineLetter(c[i])) {
			isWord = 1;
		} 
		
		/* If we've run into a space or punctuator it seems that that's the end of the word string */
		if (c[i] == ' ' || c[i] == '!' || c[i] == '.' || c[i] == '?') {
			if (isWord == 1) {
				isWord = 0;
				numWords++;
			}
		}
	}
	
	/* print the result */
	printf("There are %d words.\n", numWords);
	
	/* End */
	return;
}

/* Try to count sentences */
void countSentences(char c[], int lengthOfString) {
	/* used to determine if it's a sentence */
	int numSents = 0, isSent = 0;
	
	/* Iterate over the array of chars to find alphanumerics */
	int i;
	for (i = 0; i<lengthOfString;i++) {
		if (determineAN(c[i])) {
			isSent = 1;
		} 
		
		/* If we've run into a punctuator it seems that that's the end of the sentence */
		if (c[i] == '.' || c[i] == '?' || c[i] == '!') {
			if (isSent == 1) {
				isSent = 0;
				numSents++;
			}
		}
	}
	
	/* print the result */
	printf("There seems to be %d sentences.\n", numSents);
	
	/* End */
	return;
}

/* Counts other things like vowels and such */
void countOther(char c[], int lengthOfString) {
	/* Storage vars */
	int numNums = 0;
	int numVowels = 0;
	int numOps = 0;
	
	/* iterate over the char array to find vowels and numerics */
	int i;
	for (i = 0; i<lengthOfString; i++) {
		if (determineNumeric(c[i])) {
			numNums++;
		}
		if (determineVowel(c[i])) {
			numVowels++;
		}
		if (determineOperator(c[i])) {
			numOps++;
		}
	}
	
	/* Now that we're done looping, print results */
	printf("In the array, %d vowels were present and %d numbers were found.\n", numVowels, numNums);
	printf("In addition there were %d operators\n", numOps);
	
	/* End */
	return;
}
	


/* Determines if something is a letter or not */
int determineLetter(char c) {
	if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')) {
		return 1;
	} else {
		return 0;
	}
}

/* Determines if something is alphanumeric */
int determineAN(char c) {
	if ((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || (c >= '0' && c<= '9')) {
		return 1;
	} else {
		return 0;
	}
}
		
/* Determines if something is numeric */
int determineNumeric(char c) {
	if (c >= '0' && c<= '9') {
		return 1;
	} else {
		return 0;
	}
}

/* See if something's a vowel */
int determineVowel(char c) {
	/* If the char is in any of these vowels set it to 1 */
	int vowelTracker = 0;
	if (c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U') {
		vowelTracker = 1;
	}
	if (c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u') {
		vowelTracker = 1;
	}
	
	/* Return results */
	return vowelTracker;
}

/* See if something's an operator */
int determineOperator(char c) {
	/* Set T/F value that sets to 1 if it's an operator */
	int operatorTracker = 0;
	if (c == '+' || c == '-' || c == '*' || c == '/' || c == '(' || c == ')') {
		operatorTracker = 1;
	}
	
	/* return results */
	return operatorTracker;
}
