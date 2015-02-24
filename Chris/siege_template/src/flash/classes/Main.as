package 
{
	import com.natejc.input.KeyboardManager;
	import com.natejc.input.KeyCode;
	import flash.display.MovieClip;
	
	
	/**
	 * Drives the project.
	 * 
	 * @author	Nate Chatellier
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
		}
		
		/* ---------------------------------------------------------------------------------------- */

	}
}

