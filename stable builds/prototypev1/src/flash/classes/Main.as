package
{
	import com.natejc.input.KeyboardManager;
	import com.natejc.util.StageRef;
	import edu.ewu.screens.GameScreen;
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Sam Gronhovd
	 */
	public class Main extends MovieClip
	{
		/** the game screen for the game*/
		public var mcGameScreen 		:GameScreen;
		
		public function Main() 
		{
			KeyboardManager.init(this.stage);
			
			StageRef.stage = this.stage;
			
			showGameScreen();
		}
		
		public function showGameScreen()
		{
			
			this.mcGameScreen.begin();
		}
		
	}

}