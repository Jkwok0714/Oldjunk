import java.util.*;

class arrayTests {
  public static void main(String[] args) {
    int m, n;
    
    System.out.println("Enter a width, press enter then a length and press enter.");
    Scanner scan = new Scanner(System.in);
    n = scan.nextInt();
    m = scan.nextInt();
    
    int[][] table;
    table = makeArray(n, m);
    showArray(table);
    System.out.println("The sum of all the array elements is " + sumArray(table));
    
  }
  
  static int[][] makeArray(int m, int n) {
    int[][] table = new int[m][n];
    
    //Fill in values
    for (int i = 0; i < m; i++)
      for (int j = 0; j < n; j++)
        table[i][j] = (i+1)*(j+1);
    
    return table;
  }
  
  static void showArray(int[][] array) {
    for (int i = 0; i < array.length; i++) {
      for (int j = 0; j< array[i].length; j++)
        System.out.print(array[i][j] + "\t");
      System.out.println();
    }
    return;
  }
  
  static int sumArray(int[][] array) {
    int sum = 0;
    for (int i = 0; i < array.length; i++) {
      for (int j = 0; j < array[i].length; j++)
        sum += array[i][j];
    }
    return sum;
  }
}
  
   
    