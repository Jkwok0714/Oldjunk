
/*
 * CMPS 12L Winter 2009: "Compiler" Lab
 * Name: Justin Kwok
 * Date: March 11 2009
 * Desc: It checks script for C--, a degraded language
 */

import java.util.*;

class Compiler {

  public static void main(String[] args) {
    Scanner scan1 = new Scanner(System.in);
    //Patterns:
    //Declarations
    int numCases = 9;
    String[] patterns = new String[numCases];
    patterns[0] = "float [a-z];";
    patterns[1] = "char [a-z];";
    //Assignments
    patterns[2] = "[a-z]=[0-9]*;";
    patterns[3] = "[a-z]=[a-z][\\+\\-\\*\\/][0-9]*;";
    patterns[4] = "[a-z]=[a-z][\\+\\-\\*\\/][0-9]*\\.[0-9]*;";
    patterns[5] = "[a-z]=[a-z][\\+\\-\\*\\/]'[a-z]';";
    //Print
    patterns[6] = "print\\([a-z]\\);";
    
    //New Assignments
    patterns[7] = "[a-z]='[a-z]';";
    patterns[8] = "[a-z]=[0-9]*\\.[0-9]*;";
    
    //Patterntypes: 1 = dec, 2 = ass. with 1 var, 3 = ass. with 2 var, 4 = print
    int[] patternType = {1,1,2,3,3,3,4,2,2};
    
    String lineinput;
    boolean correctmatch;
    int lineNumber = 0;
    int numErrors = 0;
    int decsFound;
    boolean duplicated;
    char newAlpha;
    int k;

    ArrayList<Character> declared = new ArrayList<Character>();
 
    while(scan1.hasNextLine()) {
      lineinput = scan1.nextLine();
      correctmatch = false;//lineinput.matches(pattern4);
      lineNumber++;
      
      int i;
      for (i = 0; i < patterns.length; i++ ) {
        if (lineinput.matches(patterns[i])) {
          correctmatch = true;
          if (patternType[i] == 1 ){
            //A float was been declared, check to see if it is duplicate
            newAlpha = lineinput.charAt(6-i);
            duplicated = false;
            for (k = 0; k < declared.size(); k++) {
              if (newAlpha == declared.get(k)) {
                System.out.println("ERROR2 at line " + lineNumber);
                duplicated = true;
                numErrors++;
                break;
              }
            }
            if (duplicated == false){
              declared.add(newAlpha);
            }
          } else if (patternType[i] == 2) {
            //Assignment has been made with one alpha only
            decsFound = 0;
            newAlpha = lineinput.charAt(0);
            for (k = 0; k < declared.size(); k++) {
              if (newAlpha == declared.get(k)) {
                decsFound++;
              }
            }
            if (decsFound == 0) {
              System.out.println("ERROR3 at line " + lineNumber);
              numErrors++;
            }
            
          } else if (patternType[i] == 3) {
            //Assignment made with two alphas
            decsFound = 0;
            newAlpha = lineinput.charAt(0);

            for (k = 0; k < declared.size(); k++) {
              if (newAlpha == declared.get(k)) {
                decsFound++;
              }
            }
            if (decsFound == 0) {
              System.out.println("ERROR3 at line " + lineNumber);
              numErrors++;
            }
            //check 2nd alpha
            decsFound = 0;
            newAlpha = lineinput.charAt(2);
            for (k = 0; k < declared.size(); k++) {
              if (newAlpha == declared.get(k)) {
                decsFound++;
              }
            }
            if (decsFound == 0) {
              System.out.println("ERROR3 at line " + lineNumber);
              numErrors++;
            }
          } else if (patternType[i] == 4) {
            //print: check
            decsFound = 0;
            newAlpha = lineinput.charAt(6);
            for (k = 0; k < declared.size(); k++) {
              if (newAlpha == declared.get(k)) {
                decsFound++;
              }
            }
            if (decsFound == 0) {
              System.out.println("ERROR3 at line " + lineNumber);
              numErrors++;
            }
          }
          
          break;
        }
      }
      if(!correctmatch) {
        System.out.println("ERROR1 at line " + lineNumber);  
        numErrors++;
      }
    }

    // if not even a single error occurred, print "CORRECT"
    if (numErrors == 0) {
      System.out.println("CORRECT");
    } else {
      System.out.println("Total errors: " + numErrors);
    }
    

  }  // end of main()
}  // end of Compiler class