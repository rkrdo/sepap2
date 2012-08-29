import java.io.*;

public class xProblema1102 {
	public static BufferedReader entrada =
            new BufferedReader(new InputStreamReader(System.in));

	public static void main(String[] args) throws IOException {
		//Leer el tamaño de los arreglos
		int longitud = Integer.parseInt(entrada.readLine());
		int [] arr1 = new int [longitud];
		int [] arr2 = new int [longitud];
		//Leer los valores que se guardarán en el arreglo
		leerArreglo(arr1);
		leerArreglo(arr2);
		//Comparar los arreglos y generar la secuencia
		String s = compara(arr1, arr2);
		System.out.println(s);
	}
	public static String compara(int [] arreglo1, int [] arreglo2)
	{
		String s = ""; //Inicializa el string s como un string vacío
		for(int k = 0; k < arreglo1.length; k++)
		{
			if ( arreglo1[k] == arreglo2[k] )
				s = s + 1;
			else s = s + 0;
		}
		return s;
	}
	public static void leerArreglo(int [] arreglo) throws IOException
	{
		for(int k = 0; k < arreglo.length; k++)
			arreglo[k] = Integer.parseInt(entrada.readLine());
	}
}
