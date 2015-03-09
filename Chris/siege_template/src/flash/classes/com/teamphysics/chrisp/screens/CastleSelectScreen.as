package com.teamphysics.chrisp.screens {
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import org.osflash.signals.Signal;
	import com.teamphysics.util.SoundManager;
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	
	/**
	 * Castle select screen
	 * 
	 * @author Chris Park
	 */
	public class CastleSelectScreen extends FadeScreen
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
		
		public var mcCastle1ImageP1			:MovieClip;
		public var mcCastle2ImageP1			:MovieClip;
		public var mcCastle3ImageP1			:MovieClip;
		public var mcCastle4ImageP1			:MovieClip;
		public var mcCastle5ImageP1			:MovieClip;
		public var mcCastle6ImageP1			:MovieClip;
		
		public var mcCastle1ImageP2			:MovieClip;
		public var mcCastle2ImageP2			:MovieClip;
		public var mcCastle3ImageP2			:MovieClip;
		public var mcCastle4ImageP2			:MovieClip;
		public var mcCastle5ImageP2			:MovieClip;
		public var mcCastle6ImageP2			:MovieClip;
		
		//Signals
		public var backClickedSignal		:Signal = new Signal();
		public var continueClickedSignal	:Signal = new Signal();
		
		//Castle Selections
		public var iPlayerOneCastleNumber	:int = 0;
		public var iPlayerTwoCastleNumber	:int = 0;
		public var txtP1Choice				:TextField;
		public var txtP2Choice				:TextField;
		
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
			this.txtP1Choice.text = "";
			this.txtP2Choice.text = "";
			
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
			
			this.mcCastle1ImageP1.mouseEnabled = false;
			this.mcCastle2ImageP1.mouseEnabled = false;
			this.mcCastle3ImageP1.mouseEnabled = false;
			this.mcCastle4ImageP1.mouseEnabled = false;
			this.mcCastle5ImageP1.mouseEnabled = false;
			this.mcCastle6ImageP1.mouseEnabled = false;
			
			this.mcCastle1ImageP2.mouseEnabled = false;
			this.mcCastle2ImageP2.mouseEnabled = false;
			this.mcCastle3ImageP2.mouseEnabled = false;
			this.mcCastle4ImageP2.mouseEnabled = false;
			this.mcCastle5ImageP2.mouseEnabled = false;
			this.mcCastle6ImageP2.mouseEnabled = false;
			
			this.activateTweens();
			
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function activateTweens():void
		{
			TweenMax.from(this.btCastleOneP1, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.btCastleTwoP1, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.btCastleThreeP1, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.btCastleFourP1, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.btCastleFiveP1, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.btCastleSixP1, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.btRandomP1, 1, { x: 1100, ease:Quad.easeOut } );
			
			TweenMax.from(this.btCastleOneP2, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.btCastleTwoP2, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.btCastleThreeP2, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.btCastleFourP2, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.btCastleFiveP2, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.btCastleSixP2, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.btRandomP2, 1, { x: 1100, ease:Quad.easeOut } );
			
			TweenMax.from(this.mcCastle1ImageP1, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.mcCastle2ImageP1, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.mcCastle3ImageP1, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.mcCastle4ImageP1, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.mcCastle5ImageP1, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.mcCastle6ImageP1, 1, { x: 1100, ease:Quad.easeOut } );
			
			TweenMax.from(this.mcCastle1ImageP2, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.mcCastle2ImageP2, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.mcCastle3ImageP2, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.mcCastle4ImageP2, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.mcCastle5ImageP2, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.mcCastle6ImageP2, 1, { x: 1100, ease:Quad.easeOut } );
			
			
			TweenMax.from(this.btBack, 1, { x: 1100, ease:Quad.easeOut } );
			TweenMax.from(this.btContinue, 1, { x: 1100, ease:Quad.easeOut } );
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
				this.iPlayerOneCastleNumber = 1;
			
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
			
			trace("Castle Select: P1 castle selected." + iPlayerOneCastleNumber);
			
			if ($e.target == btRandomP1)
				this.txtP1Choice.text = " ?";
			else
				this.txtP1Choice.text = iPlayerOneCastleNumber.toString();
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
			
			trace("Castle Select: P2 castle selected." + iPlayerTwoCastleNumber);
			
			if ($e.target == btRandomP2)
				this.txtP2Choice.text = " ?";
			else
				this.txtP2Choice.text = iPlayerTwoCastleNumber.toString();
			
			
		}


		public function get p1CastleNumber(): int
		{
			return  iPlayerOneCastleNumber;
		}
		
		public function get p2CastleNumber(): int
		{
			return  iPlayerTwoCastleNumber;
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

