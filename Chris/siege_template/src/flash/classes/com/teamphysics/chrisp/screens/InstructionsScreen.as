package com.teamphysics.chrisp.screens {
	import com.teamphysics.chrisp.screens.AbstractScreen;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;
	
	/**
	 * Instructions Screen Class
	 * 
	 * @author Chris Park
	 */
	public class InstructionsScreen extends AbstractScreen
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
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
			super.end();
			
			this.btReturn.removeEventListener(MouseEvent.CLICK, returnClicked);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/*NOTE: Override show and hide in base class for tweening here*/
		
		/* ---------------------------------------------------------------------------------------- */
		// [ BUTTON EVENT TRIGGERS ]
		/* ---------------------------------------------------------------------------------------- */
		protected function returnClicked($e:MouseEvent):void
		{
			trace("Instructions: Return Clicked.");
			this.returnClickedSignal.dispatch();
		}
		/* ---------------------------------------------------------------------------------------- */
		// [ / BUTTON EVENT TRIGGERS ]
		/* ---------------------------------------------------------------------------------------- */
		
	}
}
