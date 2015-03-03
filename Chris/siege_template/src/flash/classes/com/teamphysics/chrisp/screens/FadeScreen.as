package com.teamphysics.chrisp.screens
{
	import com.greensock.*;
	import com.greensock.easing.*;

	
	/**
	 * Screen with fading behavior
	 * 
	 * @author Chris Park
	 */
	public class FadeScreen extends AbstractScreen
	{
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the FadeScreen object.
		 */
		public function FadeScreen()
		{
			super();
			
		}
		
		/* ---------------------------------------------------------------------------------------- */
	
		/**
		 * Shows the screen and initializes any properties associated with the screen starting.
		 */
		override protected function show():void
		{
			super.show();
			TweenMax.fromTo(this, .5, { alpha:0 }, { alpha:1, ease:Linear.easeNone } );
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Hides the screen and performs any actions related to the screen ending.
		 */
		override protected function hide():void
		{
			TweenMax.fromTo(this, .5, {alpha:1}, {autoAlpha:0, ease:Linear.easeNone});
			super.hide();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
	}
}
