import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import core.Player;
import core.model.*;
import core.GridChangeListener;
import javafx.scene.paint.Color;

public aspect Logs {
	String filename = "Logs.txt";
	ArrayList<Integer> xRed   = new ArrayList<Integer>();
	ArrayList<Integer> yRed   = new ArrayList<Integer>();
	ArrayList<Integer> xBlue = new ArrayList<Integer>();
	ArrayList<Integer> yBlue = new ArrayList<Integer>();
	
	pointcut captureCallParameters(int x, int y, Player player) : 
	      call(void Grid.placeStone(int,int,Player)) && 
	      args(x,y,player);
	
	   before(int x,int y, Player player) : captureCallParameters(x,y,player)
	   {
		   System.out.println(player.getName() + " pose en (" + x + ", " + y+ ")");
		   if(player.getName().equals("Red")){
			   xRed.add(x);
			   yRed.add(y);
		   }
		   else if(player.getName().equals("Blue")) {
			   xBlue.add(x);
			   yBlue.add(y);
		   }
		   
		   try
		   {
		      
		       FileWriter fw = new FileWriter(filename,true);
		       fw.write(player.getName() + " pose en (" + x + ", " + y +")\n");
		       fw.close();
		   }
		   catch(IOException ioe)
		   {
		       System.err.println("IOException: " + ioe.getMessage());
		   }
	   }
	   
	 pointcut gameOver(Player player) :
			call(void GridChangeListener.gameOver(Player)) && args(player);
	 
	 after(Player player) : gameOver(player){
		 try
		   {
		       FileWriter fw = new FileWriter(filename,true);
		       fw.write("Game Over ! Blue a joue les coups suivant : ");
		       for(int i = 0; i < xBlue.size(); i++) {
				fw.write("(" + xBlue.get(i)+","+yBlue.get(i)+") ; ");
		       }
		       fw.write("\n");
		       fw.write("Game Over ! Red a joue les coups suivant : ");
		       for(int i = 0; i < xRed.size(); i++) {
				fw.write("(" + xRed.get(i)+","+yRed.get(i)+") ; ");
		       }
		       fw.write("\n");
		       fw.close();
		   }
		   catch(IOException ioe)
		   {
		       System.err.println("IOException: " + ioe.getMessage());
		   }
	 }
	 
	 pointcut clearFile() :
		 call(Player.new(String,Color));
	 
	 before() : clearFile(){
		 try {
			new FileWriter(filename).close();
			
		}  catch(IOException ioe)
		   {
		       System.err.println("IOException: " + ioe.getMessage());
		   }
	 }
	 
}