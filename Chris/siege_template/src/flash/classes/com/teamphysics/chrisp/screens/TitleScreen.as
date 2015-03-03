package com.teamphysics.chrisp.screens {
	import com.teamphysics.chrisp.screens.AbstractScreen;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;
	import com.teamphysics.util.SoundManager;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;

	
	/**
	 * Title Screen Class
	 * 
	 * @author Chris Park
	 */
	public class TitleScreen extends FadeScreen
	{
		
		//Buttons
		public var btPlay				:SimpleButton;
		public var btInstructions		:SimpleButton;
		public var btCredits			:SimpleButton;
		
		public var mcLogo				:MovieClip;
		
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
			
			SoundManager.instance.playTitleMusic();
			
			this.btPlay.addEventListener(MouseEvent.CLICK, playClicked);
			this.btCredits.addEventListener(MouseEvent.CLICK, creditsClicked);
			this.btInstructions.addEventListener(MouseEvent.CLICK, instructionsClicked);
			
			TweenMax.from(this.mcLogo, 1.5, { y: 0, ease:Bounce.easeOut } );
			TweenMax.from(this.btPlay, .3, { y: 700, delay: 1, ease:Quad.easeOut } );
			TweenMax.from(this.btCredits, .3, { x: 1100, delay: .8, ease:Quad.easeOut } );
			TweenMax.from(this.btInstructions, .3, { x: -200, delay: .8, ease:Quad.easeOut } );
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
			SoundManager.instance.playButtonClick();
			this.playClickedSignal.dispatch();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function creditsClicked($e:MouseEvent):void
		{
			trace("Title: Credits Clicked.");
			SoundManager.instance.playButtonClick();
			this.creditsClickedSignal.dispatch();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function instructionsClicked($e:MouseEvent):void
		{
			trace("Title: Instructions Clicked");
			SoundManager.instance.playButtonClick();
			this.instructionsClickedSignal.dispatch();
		}
		/* ---------------------------------------------------------------------------------------- */
		// [ / BUTTON EVENT TRIGGERS ]
		/* ---------------------------------------------------------------------------------------- */
		
	}
}

