package com.teamphysics.chrisp.screens {
	import com.greensock.easing.*;
	import com.greensock.TweenMax;
	import com.teamphysics.util.SoundManager;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;
	
	/**
	 * Instructions Screen Class
	 * 
	 * @author Chris Park
	 */
	public class InstructionsScreen extends FadeScreen
	{
		//Buttons
		public var btReturn				:SimpleButton;
		
		//Signals
		public var returnClickedSignal	:Signal = new Signal();
		
		/* ---------------------------------------------------------------------------------------- */
		
		//Constructs the Instructions Screen object.
		public function InstructionsScreen()
		{
			super();
		}
		/* ---------------------------------------------------------------------------------------- */
		
		override public function begin():void
		{
			super.begin();
			this.btReturn.addEventListener(MouseEvent.CLICK, returnClicked);
			this.activateTweens();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function activateTweens():void
		{
			TweenMax.from(this.btReturn, 1.5, { y: 0, ease:Bounce.easeOut } );
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
			super.end();
			this.btReturn.removeEventListener(MouseEvent.CLICK, returnClicked);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		// [ BUTTON EVENT TRIGGERS ]
		/* ---------------------------------------------------------------------------------------- */
		protected function returnClicked($e:MouseEvent):void
		{
			SoundManager.instance.playButtonClick();
			this.returnClickedSignal.dispatch();
		}
		/* ---------------------------------------------------------------------------------------- */
		// [ / BUTTON EVENT TRIGGERS ]
		/* ---------------------------------------------------------------------------------------- */
		
	}
}
