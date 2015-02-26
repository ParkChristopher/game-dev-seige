package com.teamphysics.chrisp.screens {
	import com.teamphysics.chrisp.screens.AbstractScreen;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;

	
	/**
	 * Title Screen Class
	 * 
	 * @author Chris Park
	 */
	public class TitleScreen extends AbstractScreen
	{
		
		//Buttons
		public var btPlay				:SimpleButton;
		public var btInstructions		:SimpleButton;
		public var btCredits			:SimpleButton;
		
		//Signals
		public var playClickedSignal			:Signal = new Signal();
		public var instructionsClickedSignal	:Signal = new Signal();
		public var creditsClickedSignal			:Signal = new Signal();
		
		/* ---------------------------------------------------------------------------------------- */
		
		//Constructs the TitleScreen object.
		public function TitleScreen()
		{
			super();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function begin():void
		{
			super.begin();
			
			this.btPlay.addEventListener(MouseEvent.CLICK, playClicked);
			this.btCredits.addEventListener(MouseEvent.CLICK, creditsClicked);
			this.btInstructions.addEventListener(MouseEvent.CLICK, instructionsClicked);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
			super.end();
			
			this.btPlay.removeEventListener(MouseEvent.CLICK, playClicked);
			this.btCredits.removeEventListener(MouseEvent.CLICK, creditsClicked);
			this.btInstructions.removeEventListener(MouseEvent.CLICK, instructionsClicked);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/*NOTE: Override show and hide in base class for tweening here*/
		
		/* ---------------------------------------------------------------------------------------- */
		// [ BUTTON EVENT TRIGGERS ]
		/* ---------------------------------------------------------------------------------------- */
		protected function playClicked($e:MouseEvent):void
		{
			trace("Title: Play Clicked.");
			this.playClickedSignal.dispatch();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function creditsClicked($e:MouseEvent):void
		{
			trace("Title: Credits Clicked.");
			this.creditsClickedSignal.dispatch();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function instructionsClicked($e:MouseEvent):void
		{
			trace("Title: Instructions Clicked");
			this.instructionsClickedSignal.dispatch();
		}
		/* ---------------------------------------------------------------------------------------- */
		// [ / BUTTON EVENT TRIGGERS ]
		/* ---------------------------------------------------------------------------------------- */
		
	}
}

