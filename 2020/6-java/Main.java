import java.io.*;
import java.util.*;

public class Main {
	public static String union(String a, String b){
		int[] counters_a = new int[27];
		int[] counters_b = new int[27];
		for(int i=0;i<a.length();i++){
			counters_a[(int)a.charAt(i) - (int)'a'] += 1;
		}
		for(int i=0;i<b.length();i++){
			counters_b[(int)b.charAt(i) - (int)'a'] += 1;
		}
		String aUnionb="";
		for(int i=0;i<counters_a.length;i++){
			if(counters_a[i]!=0 || counters_b[i]!=0){
				aUnionb += (char)(i+'a');
			}
		}
		return aUnionb;
	}

	public static String intersection(String a, String b){
		int[] counters_a = new int[27];
		int[] counters_b = new int[27];
		for(int i=0;i<a.length();i++){
			counters_a[(int)a.charAt(i) - (int)'a'] += 1;
		}
		for(int i=0;i<b.length();i++){
			counters_b[(int)b.charAt(i) - (int)'a'] += 1;
		}
		String aIntersectb="";
		for(int i=0;i<counters_a.length;i++){
			if(counters_a[i]!=0 && counters_b[i]!=0){
				aIntersectb += (char)(i+'a');
			}
		}
		return aIntersectb;
	}
	public static void main(String[] args) throws IOException{
		if (args.length <= 0 ){
			System.err.println("Usage: java Main inputfile");
			System.exit(1);
		}

		String filename = args[0];

		BufferedReader file = new BufferedReader(new FileReader(filename));

		String[] lines;
		ArrayList<ArrayList<String> > groups = new ArrayList<ArrayList<String> >();
		ArrayList<String> g = new ArrayList<String>();

		lines = file.lines().toArray(String[]::new);

		for(String x : lines){
			if(x.isEmpty()){
				groups.add(new ArrayList<String>(g));	
				g.clear();
			}
			else{
				g.add(x);
			}
		}
		int ans1=0,ans2=0;	
		for(ArrayList<String> ga : groups){
			String u = ga.get(0);
			String i = ga.get(0);
			for(String s : ga){
				u = union(u,s);
				i = intersection(i,s);
			}
			ans1 += u.length();
			ans2 += i.length();
			//System.out.println(u);
			//System.out.println(i);
			//System.out.println();
		}
		System.out.println("Part 1 Answer: "+ans1);
		System.out.println("Part 2 Answer: "+ans2);
	}
}
