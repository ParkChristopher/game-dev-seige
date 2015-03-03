package com.teamphysics.chrisp.screens
{
	import com.teamphysics.chrisp.screens.AbstractScreen;
	import flash.display.Sprite;

	
	/**
	 * Loads pre game assests
	 * 
	 * @author Chris Park
	 */
	public class LoadingScreen extends AbstractScreen
	{
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the LoadingScreen object.
		 */
		public function LoadingScreen()
		{
			super();
		}
		
		/* ---------------------------------------------------------------------------------------- */		
		
		override public function begin():void
		{
			trace("started loading");
			super.begin();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
			super.end();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
	}
}

