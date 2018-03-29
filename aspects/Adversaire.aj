import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;

import core.Player;
import javafx.scene.paint.Color;

public aspect Adversaire {
	
	private Player red = new Player("Red", Color.RED);
	private Player blue = new Player("Blue", Color.BLUE);
	private boolean  bool = true ;
	
	
	pointcut player() : 
		call(App.getCurrentPlayer());
		
	around() : player {
		try {
			if(bool) {
				bool = false;
				return red;

			}else {
				bool = true;
				return blue;
			}
			
		} catch(IOException ioe) {
			System.err.println("IOException: " + ioe.getMessage());
		}
	}
}