/* !D LIFE
 * By: Justin Kwok
 * Date: 03/15/09
 * Description: A 1D version of the game of life.
 * Note: Spaces required in the rules declaration ("0 1 0" not "010")
 */
 
#include <stdio.h>

/* Function prototypes */
void getRules(int *rules);
void initCells(int *cells);
int computeCell(int leftNeighbor, int rightNeighbor, int currentCell, int *rules);
void computeGeneration(int *cells, int *rules);
void printCells(int *cells);

int main(void) {
	/* program begins. First let the user select the rules. */
	int rules[8];
	getRules(rules);
	/* Now that the rules have been loaded, init the cells */
	/* include 2 extra cells for the edges */
	int cells[82];
	initCells(cells);
	
	/* show the new cell array */
	printf("Initiated cells: \n               ");
	printCells(cells);
	
	/* Now that we have cells, start to compute them */
	/* there is going to be 40 generations. */
	int generationsLeft = 40;
	int i;
	for (i = 1; i <= generationsLeft; i++ ) {
		/* every generation, compute and print. */
		computeGeneration(cells, rules);
		printf("Generation %2d: ", i);
		printCells(cells);
	}

    /* End */
    return 0;
}

/* get 8 integers to set as rules */
void getRules(int *rules) {
	scanf("%d%d%d%d%d%d%d%d", &rules[0], &rules[1], &rules[2], &rules[3], &rules[4], &rules[5], &rules[6], &rules[7]);
	/* Print the rules */
	printf("Rules: \n");
	int i;
	for (i = 0; i < 8; i++) {
		printf(" Binary %d: %d\n", i, rules[i]);
	}
	return;
}

/* fills the cells with zeroes */
void initCells(int *cells) {
    int i;
    for (i = 0; i<82; i++) {
		cells[i] = 0;
	}
	/* make 41, around the center, a 1 */
	cells[41] = 1;
	
	/* End */
	return;
}
	
/* This is the function that computes the generations */
void computeGeneration(int *cells, int *rules) {
	/* Make the temporary array */
	int cells2[82];
	cells2[0] = 0;
	cells2[81] = 0;

	/* With the input, scan through the cells array 1-80. 0 and 81 are borders */
	int i;
	for (i = 1; i < 81; i++) {
		/* assign the cell according to its neigbors and the rules */
		cells2[i] = computeCell(cells[i-1], cells[i+1], cells[i], rules);
	}
	
	/* Copy the completed next generation over */
	for (i = 0; i< 82; i++) {
		cells[i] = cells2[i];
	}
	
	/* End */
	return;
}

/* Computing cells based on rules */
int computeCell(int rightNeighbor, int leftNeighbor, int currentCell, int *rules) {
	/* convert the cell data to binary so using the rules array is possible */
	int binary = (rightNeighbor*4)+(currentCell*2)+(leftNeighbor);
	/* Return the value of the next generation of that cell */
	return rules[binary];
}

/* Here is the function to print out the current state of the cells */
void printCells(int *cells) {
	/* iterate over the cell array and print each one, discluding 0 and 81, the borders. */
	printf("[");
	int i;
	for (i = 1; i < 81; i++) {
		printf("%d",cells[i]);
	}
	printf("]\n");
	/* end */
	return;
}
	
