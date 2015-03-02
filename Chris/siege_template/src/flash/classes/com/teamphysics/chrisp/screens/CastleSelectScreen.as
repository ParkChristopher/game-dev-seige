package com.teamphysics.chrisp.screens {
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;
	import com.teamphysics.util.SoundManager;
	
	/**
	 * Castle select screen
	 * 
	 * @author Chris Park
	 */
	public class CastleSelectScreen extends AbstractScreen
	{
		//Buttons
		public var btCastleOneP1			:SimpleButton;
		public var btCastleTwoP1			:SimpleButton;
		public var btCastleThreeP1			:SimpleButton;
		public var btCastleFourP1			:SimpleButton;
		public var btCastleFiveP1			:SimpleButton;
		public var btCastleSixP1			:SimpleButton;
		
		public var btCastleOneP2			:SimpleButton;
		public var btCastleTwoP2			:SimpleButton;
		public var btCastleThreeP2			:SimpleButton;
		public var btCastleFourP2			:SimpleButton;
		public var btCastleFiveP2			:SimpleButton;
		public var btCastleSixP2			:SimpleButton;
		
		public var btRandomP1				:SimpleButton;
		public var btRandomP2				:SimpleButton;
		
		public var btBack					:SimpleButton;
		public var btContinue				:SimpleButton;
		
		//Signals
		public var backClickedSignal		:Signal = new Signal();
		public var continueClickedSignal	:Signal = new Signal();
		
		//Castle Selections
		public var iPlayerOneCastleNumber	:int;
		public var iPlayerTwoCastleNumber	:int;
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the CastleSelectScreen object.
		 */
		public function CastleSelectScreen()
		{
			super();
			
		}
		
		/* ---------------------------------------------------------------------------------------- */		
		
		override public function begin():void
		{
			super.begin();
			
			this.iPlayerOneCastleNumber = 0;
			this.iPlayerTwoCastleNumber = 0;
			
			this.btCastleOneP1.addEventListener(MouseEvent.CLICK, castleSelectedP1);
			this.btCastleTwoP1.addEventListener(MouseEvent.CLICK, castleSelectedP1);
			this.btCastleThreeP1.addEventListener(MouseEvent.CLICK, castleSelectedP1);
			this.btCastleFourP1.addEventListener(MouseEvent.CLICK, castleSelectedP1);
			this.btCastleFiveP1.addEventListener(MouseEvent.CLICK, castleSelectedP1);
			this.btCastleSixP1.addEventListener(MouseEvent.CLICK, castleSelectedP1);
			
			
			this.btCastleOneP2.addEventListener(MouseEvent.CLICK, castleSelectedP2);
			this.btCastleTwoP2.addEventListener(MouseEvent.CLICK, castleSelectedP2);
			this.btCastleThreeP2.addEventListener(MouseEvent.CLICK, castleSelectedP2);
			this.btCastleFourP2.addEventListener(MouseEvent.CLICK, castleSelectedP2);
			this.btCastleFiveP2.addEventListener(MouseEvent.CLICK, castleSelectedP2);
			this.btCastleSixP2.addEventListener(MouseEvent.CLICK, castleSelectedP2);
			
			this.btRandomP1.addEventListener(MouseEvent.CLICK, castleSelectedP1);
			this.btRandomP2.addEventListener(MouseEvent.CLICK, castleSelectedP2);
			
			this.btBack.addEventListener(MouseEvent.CLICK, backClicked);
			this.btContinue.addEventListener(MouseEvent.CLICK, continueClicked);
			
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
			super.end();
			
			this.btCastleOneP1.removeEventListener(MouseEvent.CLICK, castleSelectedP1);
			this.btCastleTwoP1.removeEventListener(MouseEvent.CLICK, castleSelectedP1);
			this.btCastleThreeP1.removeEventListener(MouseEvent.CLICK, castleSelectedP1);
			this.btCastleFourP1.removeEventListener(MouseEvent.CLICK, castleSelectedP1);
			this.btCastleFiveP1.removeEventListener(MouseEvent.CLICK, castleSelectedP1);
			this.btCastleSixP1.removeEventListener(MouseEvent.CLICK, castleSelectedP1);
			
			
			this.btCastleOneP2.removeEventListener(MouseEvent.CLICK, castleSelectedP2);
			this.btCastleTwoP2.removeEventListener(MouseEvent.CLICK, castleSelectedP2);
			this.btCastleThreeP2.removeEventListener(MouseEvent.CLICK, castleSelectedP2);
			this.btCastleFourP2.removeEventListener(MouseEvent.CLICK, castleSelectedP2);
			this.btCastleFiveP2.removeEventListener(MouseEvent.CLICK, castleSelectedP2);
			this.btCastleSixP2.removeEventListener(MouseEvent.CLICK, castleSelectedP2);
			
			this.btRandomP1.removeEventListener(MouseEvent.CLICK, castleSelectedP1);
			this.btRandomP2.removeEventListener(MouseEvent.CLICK, castleSelectedP2);
			
			this.btBack.removeEventListener(MouseEvent.CLICK, backClicked);
			this.btContinue.removeEventListener(MouseEvent.CLICK, continueClicked);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		//[ BUTTON EVENT TRIGGERS ]
		/* ---------------------------------------------------------------------------------------- */
		
		//Set player one castle
		protected function castleSelectedP1($e:MouseEvent):void
		{
			SoundManager.instance.playButtonClick();
			
			if ($e.target == btCastleOneP1)
				iPlayerOneCastleNumber = 1;
			
			if ($e.target == btCastleTwoP1)
				iPlayerOneCastleNumber = 2;
			
			if ($e.target == btCastleThreeP1)
				iPlayerOneCastleNumber = 3;
			
			if ($e.target == btCastleFourP1)
				iPlayerOneCastleNumber = 4;
			
			if ($e.target == btCastleFiveP1)
				iPlayerOneCastleNumber = 5;
			
			if ($e.target == btCastleSixP1)
				iPlayerOneCastleNumber = 6;
				
			if ($e.target == btRandomP1)
				iPlayerOneCastleNumber = 1 + Math.random() * 5;
			
			trace("Castle Select: P1 castle selected.");
			//TODO: Add display update for players current choice
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		//Set player two castle
		protected function castleSelectedP2($e:MouseEvent):void
		{
			SoundManager.instance.playButtonClick();
			
			if ($e.target == btCastleOneP2)
				iPlayerTwoCastleNumber = 1;
			
			if ($e.target == btCastleTwoP2)
				iPlayerTwoCastleNumber = 2;
			
			if ($e.target == btCastleThreeP2)
				iPlayerTwoCastleNumber = 3;
			
			if ($e.target == btCastleFourP2)
				iPlayerTwoCastleNumber = 4;
			
			if ($e.target == btCastleFiveP2)
				iPlayerTwoCastleNumber = 5;
			
			if ($e.target == btCastleSixP2)
				iPlayerTwoCastleNumber = 6;
				
			if ($e.target == btRandomP2)
				iPlayerTwoCastleNumber = 1 + Math.random() * 5;
			
			trace("Castle Select: P2 castle selected.");
			//TODO: Add display update for players current choice
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function backClicked($e:MouseEvent):void
		{
			trace("Castle Select: Back Clicked.");
			SoundManager.instance.playButtonClick();
			this.backClickedSignal.dispatch();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function continueClicked($e:MouseEvent):void
		{
			SoundManager.instance.playButtonClick();
			//If castles have not been selected, don't dispatch a signal.
			if (iPlayerOneCastleNumber == 0 || iPlayerTwoCastleNumber == 0)
			{
					trace("Castle Select: Castle Not Selected");
					return;
			}
				
			trace("Castle Select: Continue Clicked.");
			this.continueClickedSignal.dispatch();
		}
		/* ---------------------------------------------------------------------------------------- */
		// [ / BUTTON EVENT TRIGGERS ]
		/* ---------------------------------------------------------------------------------------- */
	}
}

