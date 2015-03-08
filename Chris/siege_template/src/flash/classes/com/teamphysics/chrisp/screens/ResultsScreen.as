package com.teamphysics.chrisp.screens {
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import org.osflash.signals.Signal;
	import com.teamphysics.util.SoundManager;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	import com.teamphysics.util.ScoreManager;
	
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
		
		//Score Text
		public var txtP1Score					:TextField;
		public var txtP2Score					:TextField;
		public var txtP1Shots					:TextField;
		public var txtP2Shots					:TextField;
		public var txtP1Accuracy				:TextField;
		public var txtP2Accuracy				:TextField;
		public var txtHighScore					:TextField;
		public var txtPlayerOne					:TextField;
		public var txtPlayerTwo					:TextField;
		
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
			
			this.txtPlayerOne.text = "Player One";
			this.txtPlayerTwo.text = "Player Two";
			
			this.tallyScore();
			
			this.activateTweens();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function activateTweens():void
		{
			TweenMax.from(this.btResultsToTitle, 1.5, { y: 0, ease:Bounce.easeOut } );
			TweenMax.from(this.btResultsPlayAgain, 1.5, { y: 0, delay: .5, ease:Bounce.easeOut } );
			TweenMax.from(this.btResultsCredits, 1.5, { y: 0, delay: .5, ease:Bounce.easeOut } );
			TweenMax.delayedCall(5, playMusic);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		//sets all score variables for the game.
		public function tallyScore():void
		{
			this.txtP1Score.text = ScoreManager.instance.nP1Score.toString();
			this.txtP2Score.text = ScoreManager.instance.nP2Score.toString();
			this.txtP1Shots.text = ScoreManager.instance.nP1ShotsFired.toString();
			this.txtP2Shots.text = ScoreManager.instance.nP2ShotsFired.toString();
			
			//Calculate accuracy values here
			
			this.txtP1Accuracy.text = "%";
			this.txtP2Accuracy.text = "%";
			
			this.txtHighScore.text  = ScoreManager.instance.nHighScore.toString();
			
			//check for winner visibility here
			
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function playMusic():void
		{
			SoundManager.instance.playResultsMusic();
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

