package com.teamphysics.chrisp.screens
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.XMLLoader;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
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
			super.begin();
			init();
			mcLoadingBar.scaleX = 0;
			
			this.scaleTimer = new Timer(50);
			this.scaleTimer.addEventListener(TimerEvent.TIMER, scaleLoadingBar);
			this.scaleTimer.start();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function init():void
		{
			var queue:LoaderMax = new LoaderMax({name:"mainQueue", onProgress:progressHandler, onComplete:completeHandler, onError:errorHandler});
			queue.append( new XMLLoader("xml/config.xml", { name:"config.xml" } ) );
			
			queue.load();
			trace("XML queue: " + queue);
		}
		/* ---------------------------------------------------------------------------------------- */
		
		public function load()
		{
			trace("loaded");
		}
		
		/* ---------------------------------------------------------------------------------------- */

		function progressHandler(event:LoaderEvent):void 
		{
			trace("progress: " + event.target.progress);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		function completeHandler(event:LoaderEvent):void 
		{
			trace(event.target + " is complete!");
		}
		 
		/* ---------------------------------------------------------------------------------------- */
		
		function errorHandler(event:LoaderEvent):void 
		{
			trace("error occured with " + event.target + ": " + event.text);
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
		
		/* ---------------------------------------------------------------------------------------- */
	}
}

