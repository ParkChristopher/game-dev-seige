package com.teamphysics.chrisp.screens {
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;
	import com.teamphysics.util.SoundManager;
	
	/**
	 * Credits Screen
	 * 
	 * @author Chris Park
	 */
	public class CreditsScreen extends FadeScreen
	{
		
		//Buttons
		public var btCreditsReturn			:SimpleButton;
		
		//Signals
		public var returnClickedSignal		:Signal = new Signal();
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the CreditsScreen object.
		 */
		public function CreditsScreen()
		{
			super();
		}
		
		/* ---------------------------------------------------------------------------------------- */		
		
		override public function begin():void
		{
			super.begin();
			
			this.btCreditsReturn.addEventListener(MouseEvent.CLICK, returnClicked);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
			super.end();
			
			this.btCreditsReturn.removeEventListener(MouseEvent.CLICK, returnClicked);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function returnClicked($e:MouseEvent):void
		{
			trace("Credits: Return Clicked.");
			SoundManager.instance.playButtonClick();
			this.returnClickedSignal.dispatch();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
	}
}

