package com.teamphysics.chrisp.screens {
	
	//import adobe.utils.CustomActions;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;
	
	
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionListener;
	import nape.constraint.PivotJoint;
	import nape.phys.Body;
	import nape.space.Space;
	import nape.util.Debug;
	
	
	/**
	 * Game Screen
	 * 
	 * @author Chris Park, Zach Lontz, Sam Gronhovd
	 */
	public class GameScreen extends AbstractScreen
	{
		//Buttons
		public var btQuit					:SimpleButton;
		public var btPause					:SimpleButton;
		
		//Signals
		public var quitClickedSignal		:Signal = new Signal();
		
		//Arrays
		public var p1Array					:Array;
		public var p2Array					:Array;
		public var placementArray			:Array;
		
		//Strings
		public var castle					:String;
		public var castle2					:String;
		
		//Booleans
		protected var bRotatingUp			:Boolean;
		protected var bRotating				:Boolean;
		
		//Numbers
		protected var nCannonRotateAmount	:Number;
		
		//Cannon
		//public var mcCannon				:Cannon;
		//public var mcPowerBar				:PowerBar;
		
		//Physics Parts
		public var debug					:Debug;
		protected var space					:Space;
		protected var floorPhysicsBody		:Body;
		protected var wallPhysicsBody		:Body;
		protected var handJoint				:PivotJoint;
		protected var kingCollisionType		:CbType = new CbType();
		protected var ballCollisionType		:CbType = new CbType();
		protected var interactionListener	:InteractionListener;
		
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

