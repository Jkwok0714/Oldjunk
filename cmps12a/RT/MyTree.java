
/**
 * Homework #3: Drawing a recursive tree.
 * Modify this template to draw a tree of your own.
 *
 * Authors: Justin Kwok (jckwok@ucsc.edu), No partner because none was found
 * Date: January 30th
 */


import java.awt.*;

class MyTree {

   // Colors are defined by (R, G, B) with each component <= 255
   // Add some more colors if you like
   static final Color RED = new Color(255, 0, 0);
   static final Color GREEN = new Color(0, 255, 0);
   static final Color BLACK = new Color(0, 0, 0);
   static final Color BROWN = new Color(150, 100, 0);
   static final Color ORANGE = new Color(255, 135, 25);
   static final Color TRUNK1 = new Color(220, 175, 135);
   static final Color TRUNK2 = new Color(207, 147, 92);
   static final Color TRUNK3 = new Color(199, 128, 63);
   static final Color LEAF1 = new Color(230, 46, 1);
   static final Color LEAF2 = new Color(230, 80, 1);
   static final Color LEAF3 = new Color(228, 120, 1);

   /*
    * This is an example "draw" method to illustrate drawing
    * a simple picture. Replace this method by your own "draw"
    * method that uses recursion to draw an interesting tree
    * by calling the following methods of the Canvas class:
    *
    * line(double length, double width)
    *    Draws a line of the given length and width in the current direction
    *    from the current position. Moves position to the end of the line.
    *
    * move(double distance)
    *    Moves the current position the given distance in the current direction
    *
    * turn(double angle)
    *    Turns the current direction clockwise by the given number of degrees
    *
    * setColor(Color c)
    *    Sets the current color.
    *
    * circle(double size)
    *    Draws a filled circle of the given size at the current Position.
    */
    static void tree(Canvas c, int level) {
     //Change canvas to black
     c.setBackground(Color.black);
     //Define variables
     int MAXLEVEL = 7;
     int LEAFSIZE = 14;
     int TURNRANGE = 80;
     int turnAngle = -TURNRANGE/2;
     int BRANCHES = 3;
     double initTrunkLength = 200;
     if (level == MAXLEVEL) { //Draw leaves on the last level
       //Make the leaf's color randomly chosen
       double ranColor = Math.random()*3+1;
       if (ranColor > 3)
         c.setColor(LEAF1);
       else if (ranColor > 2)
         c.setColor(LEAF2);
       else
         c.setColor(LEAF3);
       //Draw a leaf
       c.circle(LEAFSIZE);
       //Reset trunk color
       c.setColor(TRUNK1);
     } else {
       double myLength = initTrunkLength/level;
       double myWidth = (initTrunkLength/40)/(level*0.5);
       while (turnAngle < (TURNRANGE/2)) {
         //Make the trunk color vary by level
         if (level == (MAXLEVEL-1))
           c.setColor(TRUNK3);
         else if (level == (MAXLEVEL-2))
           c.setColor(TRUNK2);
         else
           c.setColor(TRUNK1);
         //Drawing functions
         c.line(myLength, myWidth);
         c.turn(turnAngle);
         tree(c, level+1);
         c.turn(-turnAngle);
         turnAngle += TURNRANGE/BRANCHES;
         c.move(-myLength);
       }
       //c.turn(-ANGLETURN);
     }
   }
   static void draw(Canvas c) {
    tree(c, 1);
   }
  

}  // end of MyTree class