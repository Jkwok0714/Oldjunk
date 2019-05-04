/* HUFFMAN DECODER
 * Name: Justin Kwok; no partner for none was found
 * Date: 02/06/09
 * Description: This reads in a state decoder from 'states.txt' and stores it into arrays.
 *  These arrays can then be used to decode a 'message.txt'.
 */

import java.util.*;
import java.io.*;

class Huffman {
  public static void main(String[] args) throws java.io.FileNotFoundException {
    //Run the reading method
    readStates();
  }
  
  //Function for reading the states table
  static void readStates() throws java.io.FileNotFoundException {
    //Load in the states table
    Scanner scan1 = new Scanner(new File("states.txt"));
    
    //The variable that will hold the number of states to load, and a dummy
    int numStates = scan1.nextInt();
    int stateNum = 0;
    
    //Declare arrays based on the number of states found
    int[] nextStateIfZero = new int[numStates];
    String[] actionIfZero = new String[numStates];
    int[] nextStateIfOne = new int[numStates];
    String[] actionIfOne = new String[numStates];
    
    //Read the states themselves
    for (int i = 0; i < numStates; i++) {
      stateNum = scan1.nextInt();
      nextStateIfZero[i] = scan1.nextInt();
      actionIfZero[i] = scan1.next();
      nextStateIfOne[i] = scan1.nextInt();
      actionIfOne[i] = scan1.next();
    }
    
    //
    //
    //Load in the message
    Scanner scan2 = new Scanner(new File("message.txt"));
    
    //Read in the message from message.txt and convert it to an array
    String codedMessage = scan2.next();
    char[] strArray;
    strArray = codedMessage.toCharArray();
    
    //Begin at state 0 and make placeholders for loading
    int currentState = 0;
    int nextState = 0;
    String nextAction = "none";
    
    //Begin decoding
    for (int i = 0; i < strArray.length; i++) {
      //Get the state and action data
      if (strArray[i] == '0') {
        nextState = nextStateIfZero[currentState];
        nextAction = actionIfZero[currentState];
      } else if (strArray[i] == '1') {
        nextState = nextStateIfOne[currentState];
        nextAction = actionIfOne[currentState];
      } else {
        System.out.print(" Error: Unidentified character found in message.txt.");
      }
      
      //Implement actions
      if (nextAction.charAt(0) == 'c') {
        //The action must begin with "char:"
        char printThis = nextAction.charAt(5);
        System.out.print(printThis);
      } else if (nextAction.charAt(0) == 's') {
        //The action must be "space"
        System.out.print(" ");
      } else if (nextAction.charAt(0) == 'n' && nextAction.charAt(1) == 'e') {
        //Action must be "newline"
        System.out.println("");
      } else {
        //Do nothing
      }
      //Set the next state
      currentState = nextState;
    }
    return;
  }
}
  
    