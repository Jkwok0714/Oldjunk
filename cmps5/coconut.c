/* 
 * COCONUT PI & CALCULATOR + more
 * By: Justin Kwok
 * Email: jckwok@ucsc.edu
 * Date: Feb 14, 2009
 * Description: This program is a combination of the calculator and
 *   coconut pi, along with various other small functions.
 */
 
 /* Preprocessor commands */
 #include <stdio.h>
 #include <math.h>
 #include <stdlib.h>

/* Define chars for the calculator */ 
#define C_ADD '+'
#define C_SUB '-'
#define C_MUL '*'
#define C_DIV '/'
#define C_CON 'y'
#define C_MOD '%'
#define C_POW '^'
 
 /* Initialize some function prototypes for all the sub-programs */
 void coconut_pi();
 void calculator();
 void temperature();
 void boxDrawer();
 void diceRoller();
 int in_circle();
 void calculate_pi(int total, int pointsIn);
 int generate_random(int max, int offset);
 void printBar();
 float convertCtoF(float value);
 float convertFtoC(float value);
 
 int main(void) {
     /* Introduce the program */
     printf("  ***   ***       ***   *   *\n");
     printf(" *      *  *     *      *   *\n");
     printf("*       ***     *       *****\n");
     printf(" *      *        *      *   *\n");
     printf("  ***   *         ***   *   *\n\n");
     
     
     printf("Welcome to the Coconut Pi & Calculator Hybrid program.\n");
     
     /* Prompt which program the user wishes to use */
     int userSelect;
     while (1) {
          printf("Enter:\n");
          printf("  1 to use the Calculator\n");
          printf("  2 to use Coconut Pi\n");
          printf("  3 to use Temperature Converter\n");
          printf("  4 to use the Box drawer\n");
          printf("  5 to use the Dice Roller\n");
          printf("  6 to exit\n");
          /* Recieve user input */
          scanf("%d", &userSelect);
          
          printBar();
     
          /* Check which the user has entered and access the appropriate function */
          if (userSelect == 2) {
               coconut_pi();
          } else if (userSelect == 1) {
               calculator();
          } else if (userSelect == 6) {
               /* User selected exit, break the function loop. */
               break;
          } else if (userSelect == 3) {
                 temperature();
          } else if (userSelect == 4) {
                 boxDrawer();
          } else if (userSelect == 5) {
                 diceRoller();
          } else {
               printf("Invalid value has been entered.\n");
               continue;
          }
     }
     return 0;
 }
 
 /* Here is the function for the COCONUT PI program */
 void coconut_pi() {
     /* Introduce the program then ask and recieve input for coconut amounts. */
     printf("Welcome to the coconut Pi program.\n");
     printf("To begin, enter the number of coconuts to drop: ");
     
     int cocoNum;
     scanf("%d",&cocoNum);
     
     /* Declare variables for the calculation */
     int loopNum, ranNumX, ranNumY;
     int pointsIn = 0;
     double distance;
     
     /* Loop to test */
     for (loopNum = 0; loopNum < cocoNum; loopNum++) {
         /* Generate random points to represent a dropped coconut */
         ranNumX = generate_random(20, 10);
         ranNumY = generate_random(20, 10);
         
         /* Get the distance from the center point at 0,0 */
         distance = (double)sqrt((ranNumX)*(ranNumX) + (ranNumY)*(ranNumY));

         /* Determine if the point is within the circle */
         if (distance <= 10) {
              pointsIn++;
         }
     }
         
     /* Calculate pi and print it */
     printf("\n");
     calculate_pi(cocoNum, pointsIn);
     printBar();
     return;
 }
 
 /* Generate a random number between -10 and 10 */
 int generate_random(int max, int offset) {
      int r;
      r = int(max*rand()/(RAND_MAX+1.0)); 
      r -= offset;
 
      return r;
 }
 
/* Calculate pi and print it out*/
void calculate_pi(int total, int pointsIn) {
     double piValue;
     piValue = (double)pointsIn/total*4.0;
     printf("The value of pi as calculated is %f\n\n", piValue);
     return;
}

/* Calculator program here.
 * The calculator has been upgraded to include the % modulus and also for the user to
 *   further manipulate the answer. Plus exponents.
 */
void calculator(void) {
    /* Introduce the program */
    printf("Welcome to the simple calculator.\n");
    printf("Here you can add, subtract, multiply, divide, exponentiate or find the modulus of two doubles.\n");
    printf("Do this by entering two integers with an operator (* / + - ^ or %%) in between.\n");
    
    /*Declare variables for input and output */
    float inputOne = 0.0, inputTwo = 0.0, answer;
    char operatorIn = '+', menuOption = 'y';
    
    
    /* Loop until user cancels */
    while (1) {
          /*Prompt and recieve input */
          if (menuOption == 'm') {
               printf("Please enter an operator and a double: \n");
               scanf(" %c %f",&operatorIn,&inputTwo);
               menuOption = 'y';
          } else {
               printf("Please enter your calculation: \n");
               scanf("%f %c %f",&inputOne,&operatorIn,&inputTwo);
          }
          
          /* Perform the operation */
          if (operatorIn == C_ADD) {
                 answer = inputOne + inputTwo;
          } else if (operatorIn == C_SUB) {
                 answer = inputOne - inputTwo;
          } else if (operatorIn == C_MUL) {
                 answer = inputOne * inputTwo;
          } else if (operatorIn == C_DIV) {
                 answer = inputOne / inputTwo;
          } else if (operatorIn == C_MOD) {
                 answer = inputOne / inputTwo;
          } else if (operatorIn == C_POW) {
                 answer = pow(inputOne, inputTwo);
          }
          
          /* Print the answer */
          printf("%f %c %f = %f\n", inputOne, operatorIn, inputTwo, answer);
          
          /* Ask if user wants to continue */
          printf("Continue? (y/n) or (m) to manipulate answer: ");
          scanf(" %c", &menuOption);
          
          /* Break loop if not */
          if (menuOption == 'n') {
                 break;
                 
          /* Loop back in different mode if user wants to manipulate the answer */
          } else if (menuOption == 'm') {
                 inputOne = answer;
                 continue;
          }
          printf("\n\n");
          
    }
    printBar();
    
    /* End */
    return;
}

/* Conversion functions */
float convertCtoF(float value) {
      float value2;
      value2 = (value*1.8)+32;
      printf("%f C = %f F.\n\n", value, value2);
      return 0;
}
float convertFtoC(float value) {
      float value2;
      value2 = (value-32)/1.8;
      printf("%f F = %f C.\n\n", value, value2);
      return 0;
}

/* This program is for converting F to C and C to F */
void temperature() {
    /* Output the introduction and instructions*/
    printf("Welcome to the Temperature conversion program.\n");
    printf("To use, please input the type you wish to convert to (1 for F, 2 for C) and the value itself.\n");
    printf("Enter 3 as type to exit. Enter 4 to view conversions for the default values.\n\n");
    /*Declare variables for storing user input*/
    float inputTemp, inputTemp2;
    int inputType;
    char inputType2;
    /*Loop so program functions repeatedly*/
    while (inputType != 3) {
          /*Prompt and recieve user input for scale*/
          printf("Please input the scale you wish to convert to:");
          scanf("%d",&inputType);
          printf("\n");
          /*Break the loop if 3 is the scale*/
          if (inputType == 3) {
                    break;
          } else if (inputType == 1) {
                    /*Prompt for a value to convert*/
                    printf("You have chosen to convert to the Fahrenheit scale.\n");
                    printf("Please input the value to convert:\n");
                    scanf("%f",&inputTemp);
                    /*Call convert function*/
                    printf("Conversion completed: ");
                    convertCtoF(inputTemp);
          } else if (inputType == 2) {
                    /*Prompt for a value to convert*/
                    printf("You have chosen to convert to the Celsius scale.\n");
                    printf("Please input the value to convert:\n");
                    scanf("%f",&inputTemp);
                    /*Call convert function*/
                    printf("Conversion completed: ");
                    convertFtoC(inputTemp);
          } else if (inputType == 4) {
                    printf("You have chosen to convert default values.\n");
                    /*Initialize the values to covert in their original scale groups. Done better with arrays */
                    int valueF1 = 40, valueF2 = 50, valueF3 = 60, valueF4 = 70, valueF5 = 80;
                    int valueC1 = 10, valueC2 = 20, valueC3 = 30, valueC4 = 40;
                    /*Convert the F to C*/
                    convertFtoC(valueF1);
                    convertFtoC(valueF2);
                    convertFtoC(valueF3);
                    convertFtoC(valueF4);
                    convertFtoC(valueF5);
                    /*Convert the C to F*/
                    convertCtoF(valueC1);  
                    convertCtoF(valueC2); 
                    convertCtoF(valueC3); 
                    convertCtoF(valueC4);
                    printf("Conversions of the default values have been completed.\n"); 
          } else {
                    printf("An invalid type has been entered.\n");
          }
    }
    printBar();
    return;
}

/* A pointless program for fun. */
void boxDrawer() {
     /* Declare some integers for storing dimensions. */
     int dimension1, dimension2;
     char menuOption;
     
     /* Introduce program */
     printf("Welcome to the Box Drawer. Here you can draw boxes.\n");
     while (1) {
          /* Take input for dimensions */
          printf("Simply input a two integers for dimensions: ");
          scanf("%d %d", &dimension1, &dimension2);
          printf("\n");
          
          /* Draw the box. Make sure the midle is hollow */
          for (int i = 1; i <= dimension1; i++) {
              /* If it is the bottom or top row, make a line of asterisks */
              if (i == 1 || i == dimension1) {
                    for (int j = 1; j <= dimension2; j++) {
                        printf("*");
                     }
              /* If the row is not top or bottom, mark only the sides with asterisks */
              } else {
                     for (int j = 1; j <= dimension2; j++) {
                        if (j == 1 || j == dimension2) {
                              printf("*");
                        } else {
                              printf(" ");
                        }
                    }
              }
              printf("\n");
          }
          
          /* See if the user is bored enough to draw more boxes. */
          printf("\nWould you like to draw another box? (y/n): ");
          scanf(" %c", &menuOption);
          printf("\n");
          
          /* Hopefully not; break it if so */
          if (menuOption == 'n') {
               break;
          }
     
     }
     printBar();
     return;
}

/* here's a program that rolls dice. */
void diceRoller() {
     /* Introduce the program */
     printf("Welcome to the dice rolling program.\n");
     
     /* Declare variables to use */
     int numDice, diceValue, diceSum = 0;
     char sumOption, menuOption;
     
     /* Ask for dice numbers and if the user wishes to add them. */
     printf("How many dice do you want to roll at once?: ");
     scanf("%d", &numDice);
     while (1) {
           if (numDice <= 0) {
                printf("\nYou've entered an invalid amount of dice. Please re-enter: ");
                scanf("%d", &numDice);
           } else {
                break;
           }
     }
     printf("\n..and do you wish to add the sum of the dice together? (y/n): ");
     scanf(" %c", &sumOption);
     printf("\n");
     
     /* Loop */
     while (1) {
           /* Roll the dice */
           for (int i = 0; i < numDice; i++) {
               diceValue = generate_random(6, 0);
               diceSum += diceValue;
               printf("You've rolled a: %d\n", diceValue);
           }
           /* If the user wanted the sum, print it */
           if (sumOption == 'y') {
                printf("The sum of all the rolled dice turns out to be: %d\n", diceSum);
           }
           
           /* Prompt if the user wishes to continue */
           printf("Roll again? (y/n): ");
           scanf(" %c", &menuOption);
           printf("\n");
           
           /* User is sick of rolling, break the loop */
           if (menuOption == 'n') {
                break;
           }
     }
     
     printBar();
     return;
}

/* Just print a line to divide things */
void printBar() {
     printf("--------------------------\n\n");
     return;
}
