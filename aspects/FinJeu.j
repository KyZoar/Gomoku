import java.io.IOException;
import core.GridChangeListener;
import javafx.application.Platform;
import core.Player;
import core.model.Grid;
import core.GridChangeListener;

public aspect FinJeu {
	
	pointcut gameOver(Player player) :
		call(void GridChangeListener.gameOver(Player)) && args(player);
 
	 after(Player player) : gameOver(player){
		System.out.println("Game Over !! "+player.getName() + " won the game !");
		Platform.exit();
	 }
	 

}