/* Java Applet
 * Name: Justin Kwok
 * Date: February 27, 2009
 * Description: This draws a guitar-like object as a Java applet
 * URL Link: http://people.ucsc.edu/~MyUserName/MyApplet.html
 */


import java.awt.*;
import java.applet.*;

/* java.applet.Applet is the parent of the new class*/
public class MyApplet extends Applet {

     /* init is a specially named method that is
         called when the applet starts. */
     public void init() {

          /* setBackground is inherited from the
              Applet class. */
          setBackground(Color.black);
     }

     /* paint is a specially name method that is
         called automatically to draw the graphics
         of the Applet. */
     public void paint(Graphics g) {
       /* Define some colors to use. */
       Color GRAY1 = new Color(18, 18, 18);
       Color GRAY2 = new Color(51, 51, 51);
       Color GRAY3 = new Color(71, 71, 71);
       Color GRAY4 = new Color(102, 102, 102);
       Color PAINT = new Color(218, 228, 255);
       Color GLOSS = new Color(254, 255, 246);
       Color NWOOD = new Color(50, 24, 18);
       Color STRINGS = new Color(153, 153, 153);
       
       /* Construct the background */
       g.setColor(GRAY1);
       g.fillRect(50, 208, 400, 242);
       g.setColor(GRAY2);
       g.fillRect(50, 280, 400, 172);
       g.setColor(GRAY3);
       g.fillRect(50, 334, 400, 118);
       g.setColor(GRAY4);
       g.fillRect(63, 50, 18, 412);
       g.fillRect(91, 50, 6, 412);
       
       /* Draw the Shadow */
       g.setColor(Color.black);
       int[] xPoints1 = {162, 248, 277, 324, 319, 287, 412, 390};
       int[] yPoints1 = {351, 382, 312, 290, 284, 282, 202, 202};
       g.fillPolygon(xPoints1, yPoints1, xPoints1.length);
       
       /* Begin drawing the guitar */
       /* Draw the headstock */
       g.setColor(PAINT);
       int[] xPoints2 = {301, 310, 319, 350, 338, 298, 301};
       int[] yPoints2 = {134, 140, 130, 106, 104, 122, 128};
       g.fillPolygon(xPoints2, yPoints2, xPoints2.length);
       
       /* Draw the tuning keys */
       g.setColor(GRAY2);
       int tkPoints = 5;
       int[] tkX1 = {302, 298, 300, 302, 303};
       int[] tkY1 = {114, 116, 118, 119, 117};
       int[] tkX2 = {305, 307, 309, 310, 309};
       int[] tkY2 = {113, 115, 116, 114, 111};
       int[] tkX3 = {312, 314, 319, 317, 316};
       int[] tkY3 = {109, 113, 113, 111, 108};
       int[] tkX4 = {319, 321, 324, 324, 323};
       int[] tkY4 = {106, 110, 110, 107, 105};
       int[] tkX5 = {326, 328, 330, 331, 330};
       int[] tkY5 = {104, 106, 107, 104, 102};
       int[] tkX6 = {333, 334, 336, 337, 336};
       int[] tkY6 = {101, 103, 104, 101, 99};
       g.fillPolygon(tkX1, tkY1, tkPoints);
       g.fillPolygon(tkX2, tkY2, tkPoints);
       g.fillPolygon(tkX3, tkY3, tkPoints);
       g.fillPolygon(tkX4, tkY4, tkPoints);
       g.fillPolygon(tkX5, tkY5, tkPoints);
       g.fillPolygon(tkX6, tkY6, tkPoints);
   
       g.fillOval(302, 120, 5, 5);
       g.fillOval(309, 117, 5, 5);
       g.fillOval(316, 114, 5, 5);
       g.fillOval(323, 111, 5, 5);
       g.fillOval(330, 108, 5, 5);
       g.fillOval(336, 105, 5, 5);
      
       /* Draw the guitar body */
       g.setColor(PAINT);
       int[] gtrX = {234, 210, 204, 201, 191, 114, 151, 201, 228, 251, 252, 257, 264, 304, 289, 253, 240};
       int[] gtrY = {264, 265, 296, 304, 313, 373, 380, 387, 386, 383, 337, 321, 308, 274, 269, 284, 277};
       g.fillPolygon(gtrX, gtrY, gtrX.length);
       g.setColor(GLOSS);
       int[] glossX = {201, 180, 252, 251};
       int[] glossY = {304, 321, 377, 348};
       g.fillPolygon(glossX, glossY, glossX.length);
       
       /* Draw the guitar neck */
       g.setColor(NWOOD);
       int[] neckX = {301, 311, 241, 226};
       int[] neckY = {135, 139, 285, 279};
       g.fillPolygon(neckX, neckY, neckX.length);
       
       /* Draw the pickups */
       g.setColor(Color.black);
       int puPoints = 4;
       int[] puX1 = {224, 219, 237, 241};
       int[] puY1 = {281, 290, 299, 290};
       int[] puX2 = {213, 207, 224, 229};
       int[] puY2 = {305, 314, 322, 314};
       g.fillPolygon(puX1, puY1, puPoints);
       g.fillPolygon(puX2, puY2, puPoints);
       
       /* Draw the bridge */
       g.setColor(GRAY1);
       int[] bridgeX = {202, 199, 221, 223};
       int[] bridgeY = {323, 326, 336, 333};
       g.fillPolygon(bridgeX, bridgeY, puPoints);
       
       /* Draw electronic controls */
       g.setColor(Color.black);
       g.fillOval(230, 332, 7, 7);
       g.fillOval(229, 349, 6, 6);
       g.fillOval(227, 368, 7, 7);
          
       /* Draw the strings from tuner to nut */
       g.setColor(STRINGS);
       g.drawLine(305, 122, 302, 134);
       g.drawLine(312, 119, 304, 135);
       g.drawLine(318, 117, 307, 136);
       g.drawLine(325, 114, 308, 137);
       g.drawLine(332, 110, 310, 138);
       g.drawLine(340, 108, 312, 139);
       
       /* Draw strings from nut to bridge */
       g.drawLine(302, 134, 194, 347);
       g.drawLine(304, 135, 197, 347);
       g.drawLine(307, 136, 201, 348);
       g.drawLine(308, 137, 205, 348);
       g.drawLine(310, 138, 209, 348);
       g.drawLine(312, 139, 213, 347);
       
       /* we are finally done. */
       
     }
}