package com.teamphysics.chrisp.screens {
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;
	import com.teamphysics.util.SoundManager;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	
	/**
	 * Results Screen
	 * 
	 * @author Chris Park
	 */
	public class ResultsScreen extends FadeScreen
	{
		
		//Buttons
		public var btResultsPlayAgain			:SimpleButton;
		public var btResultsToTitle				:SimpleButton;
		public var btResultsCredits				:SimpleButton;
		
		//Signals
		public var playAgainClickedSignal		:Signal = new Signal();
		public var toTitleClickedSignal			:Signal = new Signal();
		public var creditsClickedSignal			:Signal = new Signal();
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the ResultsScreen object.
		 */
		public function ResultsScreen()
		{
			super();
		}
		
		/* ---------------------------------------------------------------------------------------- */		
		
		override public function begin():void
		{
			super.begin();
			
			this.btResultsPlayAgain.addEventListener(MouseEvent.CLICK, playAgainClicked);
			this.btResultsToTitle.addEventListener(MouseEvent.CLICK, toTitleClicked);
			this.btResultsCredits.addEventListener(MouseEvent.CLICK, creditsClicked);
			
			this.activateTweens();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function activateTweens():void
		{
			TweenMax.from(this.btResultsToTitle, 1.5, { y: 0, ease:Bounce.easeOut } );
			TweenMax.from(this.btResultsPlayAgain, 1.5, { y: 0, delay: .5, ease:Bounce.easeOut } );
			TweenMax.from(this.btResultsCredits, 1.5, { y: 0, delay: .5, ease:Bounce.easeOut } );
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
			super.end();
			
			this.btResultsPlayAgain.removeEventListener(MouseEvent.CLICK, playAgainClicked);
			this.btResultsToTitle.removeEventListener(MouseEvent.CLICK, toTitleClicked);
			this.btResultsCredits.removeEventListener(MouseEvent.CLICK, creditsClicked);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		// [ BUTTON EVENT TRIGGERS ]
		/* ---------------------------------------------------------------------------------------- */
		
		protected function playAgainClicked($e:MouseEvent):void
		{
			trace("Results: Play Again Clicked.");
			SoundManager.instance.playButtonClick();
			this.playAgainClickedSignal.dispatch();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function toTitleClicked($e:MouseEvent):void
		{
			trace("Results: To Title Clicked.");
			SoundManager.instance.playButtonClick();
			this.toTitleClickedSignal.dispatch();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function creditsClicked($e:MouseEvent):void
		{
			trace("Results: Credits Clicked.");
			SoundManager.instance.playButtonClick();
			this.creditsClickedSignal.dispatch();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		// [ / BUTTON EVENT TRIGGERS ]
		/* ---------------------------------------------------------------------------------------- */
	}
}

