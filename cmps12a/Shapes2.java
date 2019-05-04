/* Shapes; Revisited
 * Name: Justin Kwok
 * Date March 8 2009
 * Description: The shapes problem, object-oriented version.
 */

import java.util.*;

//The main class that runs the program
class Shapes {
  public static void main(String[] args) {
    //Make a scanner
    Scanner scan1 = new Scanner(System.in);
    //Makes input variable holders
    String shapeInput = "";
    String colorInput = "";
    double dimension1 = 0;
    double dimension2 = 0;
    double totalArea = 0;
    //For holding largest shape data
    String largestShape = "";
    double largestArea = 0;
    //Create an array to hold the shapes
    ArrayList<Shape> shapes = new ArrayList<Shape>();
    //Time to loop for some input
    while (true) {
      //Read everything in
      shapeInput = scan1.next();
      if (shapeInput.equals("end")) {
        break;
      }
      colorInput = scan1.next();
      dimension1 = scan1.nextDouble();
      //Only scan for another double if there is another
      if (scan1.hasNextDouble()) {
        dimension2 = scan1.nextDouble();
      }
      //Make an object accordingly.
      if (shapeInput.equals("rectangle")) {
        Rectangle newShape = new Rectangle(colorInput, dimension1, dimension2);
        shapes.add(newShape);
      } else if (shapeInput.equals("square")) {
        Square newShape = new Square(colorInput, dimension1);
        shapes.add(newShape);
      } else if (shapeInput.equals("circle")) {
        Circle newShape = new Circle(colorInput, dimension1);
        shapes.add(newShape);
      } else {
        //It must be a triangle
        Triangle newShape = new Triangle(colorInput, dimension1, dimension2);
        shapes.add(newShape);
      }
    }
    //All the inputs have been taken. Iterate over them
    for (Shape s: shapes) {
      totalArea += s.area();
      //If this shape's are is larger than the saved largest, store its data
      if (s.area() > largestArea) {
        largestArea = s.area();
        largestShape = s.toString();
      }
    }
    //Done iterating, print everything.
    System.out.println("Total area = " + totalArea);
    System.out.println("The largest shape is " + largestShape + " with an area of " + largestArea);
  }
}

//The Shapes superclass
abstract class Shape {
  //All shapes have a color and an area and toString function. Define them or make an abstract
  String color;
  Shape(String color) {
    this.color = color;
  }
  abstract double area();
  public abstract String toString();
}

//Triangle subclass
class Triangle extends Shape {
  double height;
  double width;
  Triangle(String color, double height, double width) {
    super(color);
    this.height = height;
    this.width = width;
  }
  //Area is half of the height times width
  double area() {
    return 0.5 * height * width;
  }
  public String toString() {
    return color + " triangle";
  }
}

//Rectangle subclass
class Rectangle extends Shape {
  double height;
  double width;
  Rectangle(String color, double height, double width) {
    super(color);
    this.height = height;
    this.width = width;
  }
  double area() {
    return height * width;
  }
  public String toString() {
    return color + " rectangle";
  }
}
    
//Square sub-subclass. It's just a rectangle taking one parameter
class Square extends Rectangle {
  double height;
  Square(String color, double height) {
    super(color, height, 0);
  }
  double area() {
    return height * height;
  }
  public String toString() {
    return color + " square";
  }
}

//Circle subclass
class Circle extends Shape {
  double radius;
  Circle(String color, double radius) {
    super(color);
    this.radius = radius;
  }
  //Utilize Math.PI to multiply the area
  double area() {
    return Math.PI * radius * radius;
  }
  public String toString() {
    return color + " circle";
  }
}

