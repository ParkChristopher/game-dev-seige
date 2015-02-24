package com.chrisp.screens
{
	import flash.display.MovieClip;

	
	/**
	 * Base screen class for all screens
	 * 
	 * @author Chris Park
	 */
	public class AbstractScreen extends MovieClip
	{
		
		/* ---------------------------------------------------------------------------------------- */
		
		//Constructs the AbstractScreen object.
		public function AbstractScreen()
		{
			super();
			
			this.mouseEnabled	= true;
			this.mouseChildren	= true;
		}
		
		/* ---------------------------------------------------------------------------------------- */		
		
		//Relinquishes all memory used by this object.
		public function destroy():void
		{
			while (this.numChildren > 0)
				this.removeChildAt(0);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		//Starts and begins all screen routines
		public function begin():void
		{
			this.show();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		////Stops all screen routines
		public function end():void
		{
			this.hide();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		//Shows the Screen
		protected function show():void
		{
			this.visible = true;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		//Hides the Screen
		protected function hide():void
		{
			this.visible = false;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
	}
}

