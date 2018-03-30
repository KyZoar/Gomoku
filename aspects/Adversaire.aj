import core.Player;
import javafx.scene.paint.Color;

privileged public aspect Adversaire {
	
	private Player red = new Player("Red", Color.RED);
	private Player blue = new Player("Blue", Color.BLUE);
	private boolean  bool = true ;
	private Player next = red;
	
	
	
	pointcut player() : call(Player App.getCurrentPlayer());
	
	Player around() : player(){
		if(this.bool){
			this.bool = false;
			this.next = this.blue;
		}
		else{
			this.bool = true;
			this.next = this.red;
		}
		return this.next;
	}
	
}