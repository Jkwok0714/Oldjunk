/*TEMPERATURE CONVERSION PROGRAM
 * By: Justin Kwok
 * Date: 01/24/09
 * Description: This program takes user input and converts.
 */

#include <stdio.h>
#include <string.h>
int main(void) {
    /* Output the introduction and instructions*/
    printf("Welcome to the Temperature conversion program.\n");
    printf("To use, please input the type you wish to convert to (1 for F, 2 for C) and the value itself.\n");
    printf("Enter 3 as type to exit.\n\n");
    float inputTemp;
    int inputType;
    char inputType2, char_c = c, char_f = f, char_e = f;
    while (inputType != 3) {
          printf("Please input the scale you wish to convert to:\n");
          scanf("%d",&inputType);
          printf("Please input the value to convert:\n");
          scanf("%f",&inputTemp);
          if (strcmp(inputType2, char_c) == 0) {
                    inputTemp = (inputTemp-32)/1.8;
                    printf("Conversion complete. %f is the final conversion in the C scale.\n\n", inputTemp);
          } else if (strcmp(inputType2, char_f) == 0) {
                    inputTemp = (inputTemp*1.8)+32;
                    printf("Conversion complete. %f is the final conversion in the F scale.\n\n", inputTemp);
          } else if (strcmp(inputType2, char_e) == 0) {
                    break;
          }
    }
    return 0;
}
