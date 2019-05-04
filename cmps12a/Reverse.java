/* STRINGBUFFER REVERSAL
 * By Justin Kwok
 * January 22, 2009
 * This program accepts input from the user and stores it into
 * a string buffer, then reverses and prints it out.
 */

import java.util.*;

class Reverse {
  public static void main (String[] args) {
    System.out.println("Please type a one-line message:");
    Scanner scan = new Scanner(System.in);
    StringBuffer b1 = new StringBuffer(scan.nextLine());
    b1.reverse();
    System.out.println(b1);
  }
}