/* BASEBALL PROGRAM
 * Name: Justin Kwok
 * Date: March 1st 2009
 * Desc: Takes input about a baseball game and simulates a simple inning.
 */

import java.util.*;
import java.io.*;

class Baseball {
  public static void main(String[] args) throws java.io.FileNotFoundException {
    //Scan for input
    Scanner scan1 = new Scanner(System.in);
    
    //Set the game playing variable to true; it has just begun
    boolean playing = true;
    
    //Make a new inning from the Inning class
    Inning game1 = new Inning();
    
    //Simulate the game if there's input and the game is on
    while (scan1.hasNext() && playing) {
      //Get the next action and return it as a char
      String nextAction = scan1.next();
      char action = nextAction.charAt(0);
      
      //See what the action is, act accordingly
      switch (action) {
        case 'S':
          playing = game1.strikeout();
          break;
        case 'H':
          int numBases = scan1.nextInt();
          playing = game1.hit(numBases);
          break;
        case 'C':
          playing = game1.sacrifice();
          break;
        default:
          playing = game1.walk();
      }
      
      //Invoke the print method
      game1.printResults();
      System.out.println();
      
      //If the game is ended just break the loop here or else it looks for more input apparently
      if (playing == false) {
        break;
      }
    }
    
    //After the while loop the inning is done, print so.
    System.out.println("End of inning.");
  }
}

//The innings class
class Inning {
  //Declare the variables
  int runs;
  int outs;
  boolean[] bases = new boolean[4];
  
  //Constructor
  Inning() {
    runs = 0;
    outs = 0;
  }
  
  //Strikeout method
  boolean strikeout() {
    //Print the strikeout and increase outs
    System.out.println("Strikeout");
    outs++;
    
    //End the game if 3+ outs by setting playing to false as a return
    if (outs >= 3) {
      return false;
    } else {
      return true;
    }
  }
  //Hit method
  boolean hit(int numBases) {
    //Print it out then advance all the players
    System.out.println("Hit! " + numBases + " bases");
    
    int i;
    for (i = 0; i < numBases; i++) {
      bases[1] = bases[0]; //Second base filled with first base value
      bases[0] = false; //The guy left 1st base so it's empty now
      bases[2] = bases[1]; //Third base filled with second base value
      bases[3] = bases[2]; //Home base filled with third base value
      //If anyone had  advanced onto home base that's a run and remove
      if (bases[3] == true) {
        runs++;
        bases[3] = false;
      }
    }
    
    //Make the runner on the base if he hit less than 4. Otherwise it's a run
    if (numBases < 4 && numBases > 0) {
      bases[numBases - 1] = true;
    } else if (numBases >= 4) {
      runs++;
    }
    
    //No additional outs, game is still playing
    return true;
  }
  
  //Sacrifice method
  boolean sacrifice() {
    //Print the function
    System.out.println("Sacrifice");
    
    //Advance all the runners
    bases[1] = bases[0];
    bases[0] = false;
    bases[2] = bases[1];
    bases[3] = bases[2];
    
    //If anyone advanced to home then add a run and remove
    if (bases[3] == true) {
      runs++;
      bases[3] = false;
    }
    
    //It's an out, add an out
    outs++;
    
    //If outs is more than 2 then the game is over
    if (outs > 2) {
      return false;
    } else {
      return true;
    }
  }
  
  //The Walk method
  boolean walk() {
    //Print the method
    System.out.println("Walk");
    
    //Get the first empty base. This simulates everyone that needs to move forward moving forward
    int i;
    boolean foundBase = false;
    for (i = 0; i < bases.length; i++) {
      if (bases[i] == false) {
        bases[i] = true;
        foundBase = true;
        break;
      }
    }
    
    //If there weren't any empty bases that means all were full and
    //The runner on 3rd base went to home and exits the field
    if (foundBase == false) {
      runs++;
      bases[3] = false;
    }
    
    //No outs were struck, simply return true
    return true;
  }
  
  //The print method
  void printResults() {
    //Print the method.. wait no, just print stuff
    System.out.print("Runs: " + runs + ", Outs: " + outs + ", Occupied Bases: ");
    
    //Determine if and what bases are occupied
    boolean foundBases = false;
    int i;
    for (i = 0; i < bases.length; i++) {
      if (bases[i] == true) {
        System.out.print((i+1) + " ");
        foundBases = true;
      }
    }
    
    //If no bases were occupied print "none"
    if (foundBases == false) {
      System.out.print("none");
    }
    System.out.println();
  }
}