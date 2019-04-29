/*TEMPERATURE CONVERSION PROGRAM
 * By: Justin Kwok
 * Date: 01/24/09
 * Description: This program takes user input and converts.
 */

#include <stdio.h>

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

int main(void) {
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
          printf("Please input the scale you wish to convert to:\n");
          scanf("%d",&inputType);
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
                    /*Initialize the values to covert in their original scale groups.*/
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
    return 0;
}

