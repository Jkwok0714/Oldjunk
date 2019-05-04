
/**
 * Homework #3: Drawing a recursive tree.
 * Compile this file to get Drawing.class and Canvas.class.
 * Modify and compile the MyTree.java file, then run the Drawing 
 * program to make your drawing.
 * Do not modify this file.
 *
 * Author: Don Chamberlin (chamberl@soe.ucsc.edu)
 */

import java.awt.*;
import javax.swing.*;
import java.awt.event.*;
import java.awt.geom.*;
import java.util.*;

/* Drawing class
 *
 * Creates a window containing a new Canvas object.
 */

public class Drawing {
  public static void main(String[] args) {
    JFrame jf = new JFrame("My Tree");
    jf.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    Container content = jf.getContentPane();
    Canvas myCanvas = new Canvas();
    content.add(myCanvas, BorderLayout.CENTER);
    jf.pack();
    jf.setVisible(true);
  }
}   // end of Drawing class

/* Canvas class
 *
 * Creates a square window of size WINDOWSIZE
 * Initializes current position to bottom center of window, 
 *    current direction to "up", current color to black
 *
 * Implements the following API:
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

class Canvas extends JPanel {
  static final int WINDOWSIZE = 600;
  Graphics2D g2d;

  Canvas() {    // constructor
    setBackground(Color.white);
    setPreferredSize(new Dimension(WINDOWSIZE, WINDOWSIZE)); 
  }

  public void paintComponent(Graphics g) {
    super.paintComponent(g);
    g2d = (Graphics2D)g;

    // Set the initial Position and Color
    g2d.setPaint(Color.BLACK);
    g2d.translate(WINDOWSIZE / 2, WINDOWSIZE);

    // Call the user's drawing program
    MyTree.draw(this);
  }

  // The following methods may be "called back" by the user's drawing program:

  public void line(double length, double width) {
    g2d.setStroke(new BasicStroke((float)width, 
          BasicStroke.CAP_ROUND, BasicStroke.JOIN_ROUND));
    g2d.draw(new Line2D.Double(0, 0, 0, -length));
    g2d.translate(0, -length);
  }

  public void move(double distance) {
    g2d.translate(0, -distance);
  }

  public void turn(double angle) {
    g2d.rotate(angle * Math.PI / 180);
  }

  public void setColor(Color c) {
    g2d.setPaint(c);
  }

  public void circle(double size) {
    g2d.fill(new Ellipse2D.Double(-size / 2, -size / 2, size, size));
  }

}  // end of Canvas class