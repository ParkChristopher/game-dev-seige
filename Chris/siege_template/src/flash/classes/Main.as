package 
{
	import com.chrisp.screens.InstructionsScreen;
	import com.chrisp.screens.TitleScreen;
	import com.natejc.input.KeyboardManager;
	import com.natejc.input.KeyCode;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	/**
	 * Drives the project.
	 * 
	 * @author	Chris Park
	 */
	public class Main extends MovieClip
	{
		//Screens
		public var mcTitleScreen			:MovieClip;
		public var mcInstructionsScreen		:MovieClip;
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the Main object.
		 */
		public function Main()
		{
			KeyboardManager.init(this.stage);
			
			// start your stuff here
			trace("it's working");
			
			//TODO: Load assets here.
			this.init();
			
			titleState();
			
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function init():void
		{
			this.mcTitleScreen = new TitleScreen();
			this.mcTitleScreen.playClickedSignal.add(gameState);
			this.mcTitleScreen.creditsClickedSignal.add(creditsState);
			this.mcTitleScreen.instructionsClickedSignal.add(instructionsState);
			this.addChild(mcTitleScreen);
			
			this.mcInstructionsScreen = new InstructionsScreen();
			this.mcInstructionsScreen.returnClickedSignal.add(titleState);
			this.addChild(mcInstructionsScreen);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function titleState():void
		{
			//end results screen
			//end castle select screen
			//end game screen
			//end results screen
			//end credits screen
			this.mcInstructionsScreen.end();
			
			this.mcTitleScreen.begin();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function creditsState():void
		{
			//end results screen
			//end title screen
			//start this screen
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function instructionsState():void
		{
			this.mcTitleScreen.end();
			
			this.mcInstructionsScreen.begin();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function gameState():void
		{
			//end castle select screen
			//end end results screen
			
			
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
	}
}

