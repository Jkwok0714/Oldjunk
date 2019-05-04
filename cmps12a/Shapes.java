/* SHAPES
 * By: Justin Kwok
 * Date: 12/24/09
 * Description: This takes user input of shapes and computes their areas. Then it outputs the largest shape and its color.
 */

import java.util.*;

class Shapes {
  public static void main (String[] args) {
    //Declare variables and inputs
    String shapeInput = "", colorInput = "", shapeInputL = "", colorInputL = "";
    double dim1 = 0, dim2 = 0;
    double areaStore, areaL = 0, totalArea = 0, loopNum = 0;
    //Introduce the program
    System.out.println("Welcome to the shapes program.");
    System.out.println("To use, input a shape (rectangle, square, circle or triangle), a color, and required double values for dimensions.");
    System.out.println("Type 'end' to terminate program.");
    //Loop for inputs
    while (loopNum == 0) {
      //Take inputs
      Scanner scan = new Scanner(System.in);
      shapeInput = scan.next();
      if (shapeInput.equals("end")) {
        ++loopNum;
        break;
      }
      colorInput = scan.next();
      dim1 = scan.nextDouble();
      if (scan.hasNextDouble()) {
        dim2 = scan.nextDouble();
      }
      //calculate the shape's area and store it for now
      if (shapeInput.equals("rectangle")) {
        areaStore = rectangleArea(dim1, dim2);
      } else if (shapeInput.equals("triangle")) {
        areaStore = triangleArea(dim1, dim2);
      } else if (shapeInput.equals("square")) {
        areaStore = squareArea(dim1);
      } else if (shapeInput.equals("circle")) {
        areaStore = circleArea(dim1);
      //} else if (shapeInput.equals("end")) {
      //  break;
      } else {
        areaStore = 0;
        System.out.println("Invalid shape was entered!");
      }
      //See if the new area is bigger than the current largest areas. If so, update the largest shape info
      if (areaStore > areaL) {
        areaL = areaStore;
        colorInputL = colorInput;
        shapeInputL = shapeInput;
      }
      //Add the area to the totals.
      totalArea += areaStore;
    }
  //Wrap-up
  System.out.print("The total area is: ");
  System.out.println(totalArea);
  System.out.println("The largest shape was a " + colorInputL + " " + shapeInputL + " with an area of " + areaL);
  }
  
  static double rectangleArea(double height, double length) {
    double area = height*length;
    return area;
  }
  static double triangleArea(double height, double length) {
    double area = (height*length)/2;
    return area;
  }
  static double squareArea(double length) {
    double area = length*length;
    return area;
  }
  static double circleArea(double radius) {
    double area = (radius*radius)*Math.PI;
    return area;
  }
}