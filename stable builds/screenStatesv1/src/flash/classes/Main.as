package 
{
	import com.teamphysics.chrisp.screens.CastleSelectScreen;
	import com.teamphysics.chrisp.screens.CreditsScreen;
	import com.teamphysics.chrisp.screens.GameScreen;
	import com.teamphysics.chrisp.screens.InstructionsScreen;
	import com.teamphysics.chrisp.screens.ResultsScreen;
	import com.teamphysics.chrisp.screens.TitleScreen;
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
		public var mcCastleSelectScreen		:MovieClip;
		public var mcResultsScreen			:MovieClip;
		public var mcCreditsScreen			:MovieClip;
		public var mcGameScreen				:MovieClip;
		
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
			this.mcTitleScreen.playClickedSignal.add(castleSelectState);
			this.mcTitleScreen.creditsClickedSignal.add(creditsState);
			this.mcTitleScreen.instructionsClickedSignal.add(instructionsState);
			this.addChild(mcTitleScreen);
			
			this.mcInstructionsScreen = new InstructionsScreen();
			this.mcInstructionsScreen.returnClickedSignal.add(titleState);
			this.addChild(mcInstructionsScreen);
			
			this.mcCastleSelectScreen = new CastleSelectScreen();
			this.mcCastleSelectScreen.backClickedSignal.add(titleState);
			this.mcCastleSelectScreen.continueClickedSignal.add(gameState);
			this.addChild(mcCastleSelectScreen);
			
			this.mcResultsScreen = new ResultsScreen();
			this.mcResultsScreen.playAgainClickedSignal.add(castleSelectState);
			this.mcResultsScreen.toTitleClickedSignal.add(titleState);
			this.mcResultsScreen.creditsClickedSignal.add(creditsState);
			this.addChild(mcResultsScreen);
			
			this.mcCreditsScreen = new CreditsScreen();
			this.mcCreditsScreen.returnClickedSignal.add(titleState);
			this.addChild(mcCreditsScreen);
			
			this.mcGameScreen = new GameScreen();
			this.mcGameScreen.quitClickedSignal.add(titleState);
			this.addChild(mcGameScreen);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function titleState():void
		{
			trace("Main: Transitioning to Title Screen.");
			
			this.mcGameScreen.end();
			this.mcCastleSelectScreen.end();
			this.mcInstructionsScreen.end();
			this.mcResultsScreen.end();
			this.mcCreditsScreen.end();
			
			
			this.mcTitleScreen.begin();
			trace("Main: Title Screen Transition Complete.");
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function creditsState():void
		{
			trace("Main: Transitioning to Credits Screen.");
			this.mcTitleScreen.end();
			this.mcResultsScreen.end();
			
			this.mcCreditsScreen.begin();
			trace("Main: Credits Screen Transition Complete.");
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function instructionsState():void
		{
			trace("Main: Transitioning to Instructions Screen.");
			this.mcTitleScreen.end();
			
			this.mcInstructionsScreen.begin();
			trace("Main: Instrucitons Screen Transition Complete.");
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function castleSelectState():void
		{
			trace("Main: Transitioning to Castle Select Screen"); 
			this.mcTitleScreen.end();
			this.mcResultsScreen.end();
			
			this.mcCastleSelectScreen.begin();
			trace("Main: Castle Select Screen Transition Complete.");
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function resultsState():void
		{
			trace("Main: Transitioning to Results Screen.");
			
			//NOTE: temporary bypass of game screen from castle select.
			this.mcCastleSelectScreen.end();
			this.mcResultsScreen.begin();
			
			trace("Main: Results Screen Transition Complete");
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function gameState():void
		{
			trace("Main: Transitioning to Game Screen.");
			mcCastleSelectScreen.end();
			
			this.mcGameScreen.begin();
			trace("Main: Game Screen Transition Complete.");
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
	}
}

