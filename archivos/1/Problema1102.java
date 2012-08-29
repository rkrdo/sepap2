import java.io.*;
class Problema1102 {
  public static void main(String[] args) throws IOException{
    BufferedReader is = new BufferedReader(
      new InputStreamReader(System.in));
    String line = is.readLine();
    int val = Integer.parseInt(line);
    int[] arr1 = new int[val];
    int[] arr2 = new int[val];
    for(int i=0; i<val; i++){
      line = is.readLine();
      arr1[i]= Integer.parseInt(line);
    }
    for(int i=0; i<val; i++){
      line = is.readLine();
      arr2[i]= Integer.parseInt(line);
    }
    for(int i=0; i<val; i++){
      if(arr1[i]==arr2[i]){
        System.out.print("1");
      }else{
        System.out.print("0");
      }
    }
    System.out.println("");
  }
}
