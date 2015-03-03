package com.teamphysics.chrisp.screens
{
	import com.teamphysics.chrisp.screens.AbstractScreen;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	/**
	 * Loads pre game assests
	 * 
	 * @author Chris Park
	 */
	public class LoadingScreen extends FadeScreen
	{
		
		public var mcLoadingBar			:MovieClip;
		public var scaleTimer			:Timer;
		
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
			mcLoadingBar.scaleX = 0;
			
			this.scaleTimer = new Timer(50);
			this.scaleTimer.addEventListener(TimerEvent.TIMER, scaleLoadingBar);
			this.scaleTimer.start();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
			super.end();
			
			this.scaleTimer.stop();
			this.scaleTimer.removeEventListener(TimerEvent.TIMER, scaleLoadingBar);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		
		public function scaleLoadingBar($e:TimerEvent):void
		{
			if (this.mcLoadingBar.scaleX >= 1)
				this.screenCompleteSignal.dispatch();
				
			if (this.mcLoadingBar.scaleX < 1.0)
				this.mcLoadingBar.scaleX = this.mcLoadingBar.scaleX + 0.025;
		}
	}
}

