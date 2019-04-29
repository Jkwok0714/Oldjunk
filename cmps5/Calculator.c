/* SIMPLE CALCULATOR PROGRAM
 * By: Justin Kwok
 * Date: 02/01/09
 * Description: This program prompts the user for a calculation and runs it, outputting the answer.
 */
 
#include <stdio.h>
#define C_ADD '+'
#define C_SUB '-'
#define C_MUL '*'
#define C_DIV '/'
#define C_CON 'y'

int main(void) {
    /* Introduce the program */
    printf("Welcome to the simple calculator.\n");
    printf("Here you can add, subtract, multiply or divide two doubles.\n");
    printf("Do this by entering two integers with an operator in between.\n");
    
    /*Declare variables for input and output */
    float inputOne = 0.0, inputTwo = 0.0, answer;
    char operatorIn = '+', menuOption = 'y';
    
    /* Loop until user cancels */
    while (1) {
          /*Prompt and recieve input */
          printf("Please enter your calculation: \n");
          scanf("%f %c %f",&inputOne,&operatorIn,&inputTwo);
          
          /* Perform the operation */
          if (operatorIn == C_ADD) {
                 answer = inputOne + inputTwo;
          } else if (operatorIn == C_SUB) {
                 answer = inputOne - inputTwo;
          } else if (operatorIn == C_MUL) {
                 answer = inputOne * inputTwo;
          } else if (operatorIn == C_DIV) {
                 answer = inputOne / inputTwo;
          }
          
          /* Print the answer */
          printf("%f %c %f = %f\n", inputOne, operatorIn, inputTwo, answer);
          
          /* Ask if user wants to continue */
          printf("Continue? (y/n): ");
          scanf(" %c", &menuOption);
          
          /* Break loop if not */
          if (menuOption == 'n') {
                         break;
          }
          printf("\n\n");
          
    }
    
    /* End */
    return 0;
}
