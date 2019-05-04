/* TIC TAC TOE MOVES
 * Name: Justin Kwok, No partner for none was found.
 * Date: February 22, 2009
 * Description: This reads a file input of a tic tac toe game
 *   and tries to see if there are any winning moves.
 *   The code automatically tries to find a testinput.txt and read from it
 */

import java.util.*;
import java.io.*;

class TicTacToe {
  public static void main(String[] args) throws java.io.FileNotFoundException {
    //Read in the input
    //Scanner scan = new Scanner(new File("testinput.txt"));
    Scanner scan = new Scanner(System.in);
    
    //How many games are there? Input wants 3 apparently
    int numGames = 3;
    int i = 0;
    
    //Create an empty TTT board
    int rows = 3;
    int columns = 3;
    char[][] tttBoard = new char[rows][columns];
    
    //Vars for holding saved string data
    String lineOne;
    String lineTwo;
    String lineThree;
    
    //Loop through the games
    for (i = 0; i < numGames; i++) {
      //Organize data into lines
      lineOne = scan.next();
      lineTwo = scan.next();
      lineThree = scan.next();
      
      //Loop variables
      int j,k;
      //Fill the board with loaded data
      for (j = 0; j < 3; j++) {
        for (k = 0; k < 3; k++) {
          //See which line to read from
          String lineRead;
          if (j == 0) {
            lineRead = lineOne;
          } else if (j == 1) {
            lineRead = lineTwo;
          } else {
            lineRead = lineThree;
          }
          
          //Read chars into the array
          tttBoard[j][k] = lineRead.charAt(k);
          tttBoard[j][k] = lineRead.charAt(k);
          tttBoard[j][k] = lineRead.charAt(k);
        }
      }
      //Print out the game board to see what we are working with.
      int a,b;
      for (a = 0; a < rows; a++) {
        for (b = 0; b < columns; b++) {
          System.out.print(tttBoard[a][b]);
        }
        System.out.println();
      }
      System.out.println();
      
      
      //Check the board for moves now that the board is filled
      checkMoves(tttBoard);
      
      //Just make an extra line space
      System.out.println();
    }
  }
  
  //This method checks the inputted board for X's winning moves
  static void checkMoves(char[][] tttBoard) {
    //Define board dimensions
    int rows = 3;
    int columns = 3;
    
    //Variable to check if any moves were found
    int movesFound = 0;
    
    //Loop variables
    int i,j,k;
    
    System.out.println("Winning moves for X:");
    //See if there are horizontal possibilities
    movesFound += checkHor(tttBoard, rows, columns);
    movesFound += checkVer(tttBoard, rows, columns);
    movesFound += checkDia(tttBoard, rows, columns);
    
    //If no moves were found then print so
    if (movesFound == 0) {
      System.out.println("No winning moves were found.");
    }
  }
  
  static int checkHor(char[][] tttBoard, int rows, int columns) {
    int i,j;
    int returnValue = 0;
    
    for (i = 0; i < rows; i++) {
      //Reset the xCounter per new row
      int xEncounters = 0;
      
      //Check how many X's are in every row by iterating over the columns
      for (j = 0; j < columns; j++) {
        if (tttBoard[i][j] == 'X') {
          xEncounters++;
        }
      }
      //After checking the columns for that row, see how many X's we have encountered
      //If there's two, see where the non-X is. If three, X already won.
      if (xEncounters == 3) {
        System.out.println("It appears that X has already won.");
      } else if (xEncounters == 2) {
        //See which tile isn't taken: It must be empty; a period.
        for (j = 0; j < columns; j++) {
          if (tttBoard[i][j] == '.') {
            //We've found an empty tile in the column and it is available to be a winning move.
            //Report it as a result
            System.out.println((i + 1) + ", " + (j + 1));
            returnValue++;
          }
        }
      }
    }
    return returnValue;
  }
  static int checkVer(char[][] tttBoard, int rows, int columns) {
    int i,j;
    int returnValue = 0;
    
    for (i = 0; i < columns; i++) {
      //Reset the xCounter per new columns
      int xEncounters = 0;
      
      //Check how many X's are in every row by iterating over the rows
      for (j = 0; j < rows; j++) {
        if (tttBoard[j][i] == 'X') {
          xEncounters++;
        }
      }
      //After checking the rows for that column, see how many X's we have encountered
      //If there's two, see where the non-X is. If three, X already won.
      if (xEncounters == 3) {
        System.out.println("It appears that X has already won.");
      } else if (xEncounters == 2) {
        //See which tile isn't taken: It must be empty; a period.
        for (j = 0; j < rows; j++) {
          if (tttBoard[j][i] == '.') {
            //We've found an empty tile in the column and it is available to be a winning move.
            //Report it as a result
            System.out.println((i + 1) + ", " + (j + 1));
            returnValue++;
          }
        }
      }
    }
    return returnValue;
  }
  
  static int checkDia(char[][] tttBoard, int rows, int columns) {
    int i,j;
    int xEncounters = 0;
    int returnValue = 0;
    
    /* For personal reference to get the indexes correct here a standard board
     * X 0 1 2
     * 0 . . .
     * 1 . . .
     * 2 . . .
     */
    
    //Check the upper-left to lower-right diagonal line
    for (i = 0; i < rows; i++) {
      if (tttBoard[i][i] == 'X') {
        xEncounters++;
      }
    }
    //Check encounters
    if (xEncounters == 3) {
      System.out.println("It appears that X has already won.");
    } else if (xEncounters == 2) {
      //See which tile wasn't taken.
      for (i = 0; i < rows; i++) {
        if (tttBoard[i][i] == '.') {
          System.out.println((i + 1) + ", " + (i + 1));
          returnValue++;
        }
      }
    }
    
    //Reset encounters for the other diagonal check
    xEncounters = 0;
    
    //Check the upper-right to lower-left diagonal line
    for (j = 0; j < rows; j++ ){
      if (tttBoard[j][columns-(j+1)] == 'X') {
        xEncounters++;
      }
    }
    //Check encounters
    if (xEncounters == 3) {
      System.out.println("It appears that X has already won.");
    } else if (xEncounters == 2) {
      //See which tile wasn't taken.
      for (j = 0; j < rows; j++) {
        if (tttBoard[j][columns-(j+1)] == '.') {
          System.out.println((j + 1) + ", " + (j - columns));
          returnValue++;
        }
      }
    }
    return returnValue;
  }
}