/* MONTE CARLO SCRIPT
 * This generates random points to find pi.
 * Justin Kwok - 12/16
 */
class MonteCarlo {
  public static void main (String[] args) {
    //Define variables to keep track of loops and make a placeholder for pi
    float piValue, pointsIn = 0, loopNums;
    double ranNumX, ranNumY, distance;

    //Loops
    for (loopNums = 1; loopNums <= 1000000; ++loopNums) {
      //Create a random point
      ranNumX = -1.0 + 2.0 * Math.random();
      ranNumY = -1.0 + 2.0 * Math.random();
      //Calculate the distance to the center point (0, 0)
      distance = Math.sqrt(Math.pow(ranNumX, 2.0) + Math.pow(ranNumY, 2.0));
      //Determine if it's in the circle and find the ratio
      if (distance <= 1) {
        ++pointsIn;
      }
      piValue = (pointsIn/loopNums)*4;
      
      //Report results
      if (loopNums == 20 || loopNums == 100 || loopNums == 1000 || loopNums == 10000 || loopNums == 100000 || loopNums == 1000000) {
        System.out.println("After " + loopNums + " tries, pi = " + piValue);
      }
    }
  }
}