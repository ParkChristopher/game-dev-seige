package com.chrisp.screens
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;

	
	/**
	 * Game Screen
	 * 
	 * @author Chris Park
	 */
	public class GameScreen extends AbstractScreen
	{
		//Buttons
		public var btQuit					:SimpleButton;
		public var btPause					:SimpleButton;
		
		//Signals
		public var quitClickedSignal		:Signal = new Signal();
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the GameScreen object.
		 */
		public function GameScreen()
		{
			super();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function begin():void
		{
			super.begin();
			
			this.btQuit.addEventListener(MouseEvent.CLICK, quitClicked);
			this.btPause.addEventListener(MouseEvent.CLICK, pauseClicked);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
			super.end();
			
			this.btQuit.removeEventListener(MouseEvent.CLICK, quitClicked);
			this.btPause.removeEventListener(MouseEvent.CLICK, pauseClicked);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		//[ BUTTON EVENT TRIGGERS ]
		/* ---------------------------------------------------------------------------------------- */
		protected function quitClicked($e:MouseEvent):void
		{
			trace("Game Screen: Quit Clicked.");
			this.quitClickedSignal.dispatch();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function pauseClicked($e:MouseEvent):void
		{
			trace("Game Screen: Pause Clicked.");
			//TODO: Pause game logic or call here
		}
		/* ---------------------------------------------------------------------------------------- */
		//[ / BUTTON EVENT TRIGGERS ]
		/* ---------------------------------------------------------------------------------------- */
	}
}

