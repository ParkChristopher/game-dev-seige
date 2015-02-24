package com.chrisp.screens
{
	import com.chrisp.screens.AbstractScreen;
	import flash.display.SimpleButton;

	
	/**
	 * Title Screen Class
	 * 
	 * @author Chris Park
	 */
	public class TitleScreen extends AbstractScreen
	{
		
		//Buttons
		public var btPlay			:SimpleButton;
		public var btInstructions	:SimpleButton;
		public var btCredits		:SimpleButton;
		
		/* ---------------------------------------------------------------------------------------- */
		
		//Constructs the TitleScreen object.
		public function TitleScreen()
		{
			super();
		}
		
		/* ---------------------------------------------------------------------------------------- */
	}
}

