package com.teamphysics.chrisp.screens {
	
	
	
	import com.natejc.input.KeyboardManager;
	import com.natejc.input.KeyCode;
	import com.teamphysics.chrisp.AbstractGameObject;
	import com.teamphysics.chrisp.powerups.AbstractPowerup;
	import com.teamphysics.chrisp.powerups.ShieldPowerup;
	import com.teamphysics.chrisp.screens.AbstractScreen;
	import com.teamphysics.samg.Cannon;
	import com.teamphysics.samg.CannonBall;
	import com.teamphysics.samg.PowerBar;
	import com.teamphysics.zachl.blocks.BaseBlock;
	import com.teamphysics.zachl.blocks.KingBlock;
	import com.teamphysics.zachl.blocks.LargeSquareBlock;
	import com.teamphysics.zachl.blocks.RectangleBlock;
	import com.teamphysics.zachl.blocks.SquareBlock;
	import com.teamphysics.zachl.blocks.Castle;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.constraint.PivotJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.space.Space;
	import nape.util.Debug;
	import org.osflash.signals.Signal;
	import com.natejc.utils.StageRef;
	import com.teamphysics.util.SpaceRef;
	import flash.events.TimerEvent;
	import com.teamphysics.util.CollisionManager;
	import com.teamphysics.util.GameObjectType;
	
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
		public var pauseClickedSignal		:Signal = new Signal();
		
		//Timers
		public var powerupTimer				:Timer;
		
		//Arrays
		public var aOnScreenObjects			:Array;
		
		//public var p1Array					:Array;
		//public var p2Array					:Array;
		public var placementArray			:Array;
		public var placementArray2			:Array;
		
		//Strings
		public var castle					:String;
		public var castle2					:String;
		
		//Booleans
		protected var bRotatingUp			:Boolean;
		protected var bRotating				:Boolean;
		protected var bPowerupActive		:Boolean;
		
		//Numbers
		protected var nCannonRotateAmount	:Number;
		
		//Cannon
		public var mcCannon					:Cannon;
		public var mcPowerBar				:PowerBar;
		
		//Castles
		public var player1Castle: Castle = new Castle();
		public var player2Castle: Castle = new Castle();
		
		//Powerup Indicators
		public var mcP1SpeedIndicator		:MovieClip;
		public var mcP1ShieldIndicator		:MovieClip;
		public var mcP2SpeedIndicator		:MovieClip;
		public var mcP2ShieldIndicator		:MovieClip;
		
		//Physics Parts
		public var debug					:Debug;
		protected var space					:Space;
		protected var floorPhysicsBody		:Body;
		protected var wallPhysicsBody		:Body;
		protected var handJoint				:PivotJoint;
		protected var king1CollisionType	:CbType = new CbType();
		protected var king2CollisionType	:CbType = new CbType();
		protected var ballCollisionType		:CbType = new CbType();
		protected var interactionListener1	:InteractionListener;
		protected var interactionListener2	:InteractionListener;

		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the GameScreen object.
		 */
		public function GameScreen()
		{
			super();
			
			nCannonRotateAmount = 0;
			bRotatingUp = true;
			bRotating = true;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function begin():void
		{
			super.begin();
			
			CollisionManager.instance.reset();
			CollisionManager.instance.begin();
			
			//Turn off indicators until a powerup is acquired.
			this.mcP1ShieldIndicator.visible = false;
			this.mcP1SpeedIndicator.visible = false;
			this.mcP2ShieldIndicator.visible = false;
			this.mcP2SpeedIndicator.visible = false;
			this.bPowerupActive = false;
			
			//Set up and start the powerup timer.
			this.powerupTimer = new Timer(5000);
			this.powerupTimer.addEventListener(TimerEvent.TIMER, spawnPowerup);
			this.powerupTimer.start();
			
			this.aOnScreenObjects = new Array();
			
			
			//Power Bar
			this.mcPowerBar = new PowerBar();
			this.addChildAt(mcPowerBar, 1);
			
			this.btQuit.addEventListener(MouseEvent.CLICK, quitClicked);
			this.btPause.addEventListener(MouseEvent.CLICK, pauseClicked);
			
			//Create the space
			space = new Space(new Vec2(0, 500));

			SpaceRef.space = space;
			
			//Create Floor
			floorPhysicsBody = new Body(BodyType.STATIC);
			var p:Polygon = new Polygon ( Polygon.rect(0, stage.stageHeight - 95,
				stage.stageWidth, 100));
				
			floorPhysicsBody.shapes.add(p);
			space.bodies.add(floorPhysicsBody);
			floorPhysicsBody.space = space;
			
			//Start Cannon
			mcCannon = new Cannon();
			mcCannon.x = 260;
			mcCannon.y = 485;
			mcPowerBar.x = mcCannon.x - 40;
			mcPowerBar.y = mcCannon.y + 20;
			aOnScreenObjects.push(mcCannon);
			this.addChildAt(mcCannon, 1);
			mcCannon.begin();

			//Build Castles
			buildCastles();

			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			KeyboardManager.instance.addKeyDownListener(KeyCode.A, addCannonBall);
			interactionListener1 = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION,
				ballCollisionType, king1CollisionType, kingHit);
			space.listeners.add(interactionListener1);
			
			interactionListener2 = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION,
				ballCollisionType, king2CollisionType, kingHit);
			space.listeners.add(interactionListener2);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
			super.end();
			
			CollisionManager.instance.end();
			
			this.btQuit.removeEventListener(MouseEvent.CLICK, quitClicked);
			this.btPause.removeEventListener(MouseEvent.CLICK, pauseClicked);
			
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			KeyboardManager.instance.removeKeyDownListener(KeyCode.A, addCannonBall);
			
			//Stop and remove timers
			this.powerupTimer.removeEventListener(TimerEvent.TIMER, spawnPowerup);
			this.powerupTimer.stop();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		private function buildCastles()
		{
			player1Castle.begin("Player1");
			this.king1CollisionType = player1Castle.kingHitBox;

			player2Castle.begin("Player2");
			this.king2CollisionType = player2Castle.kingHitBox;
		}
		/* ---------------------------------------------------------------------------------------- */
		
		public function kingHit(ev: InteractionCallback):void
		{
			trace("King collision detected");
			this.screenCompleteSignal.dispatch();
			this.player1Castle.end();
			this.player2Castle.end();
			
			this.space.clear();
			this.cleanScreen();
			
		}
		/* ---------------------------------------------------------------------------------------- */
		
		public function enterFrameHandler(e:Event)
		{
			space.step(1 / stage.frameRate);
			space.bodies.foreach(updateGraphics);

			if (this.bRotating)
			{
				if (this.bRotatingUp)
				{	
					if (this.nCannonRotateAmount > -66)
					{
						this.nCannonRotateAmount--;
					}
					else 
					{
						this.bRotatingUp = false;
					}
				}
				else //rotating down
				{
					if (this.nCannonRotateAmount < 30)
					{
						this.nCannonRotateAmount++;
					}
					else
					{
						this.bRotatingUp = true;
					}
				}
			}
			
			mcCannon.rotate(nCannonRotateAmount);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		private function updateGraphics(b:Body)
		{
			// Grab a reference to the visual which we will update
			var graphic:DisplayObject = b.userData.graphic;
			
			// Update position of the graphic to match the simulation
			graphic.x = b.position.x ;
			graphic.y = b.position.y ;
			graphic.rotation = (b.rotation * 180 / Math.PI) % 360;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		private function addCannonBall()
		{
			if (bRotating)
			{
				bRotating = false;
				mcPowerBar.begin();
			}
			else if(!bRotating && mcPowerBar.bIsMoving)
			{
				mcPowerBar.stopMoving();
				var s:CannonBall = new CannonBall();
				this.aOnScreenObjects.push(s);
				
				CollisionManager.instance.add(s);
				s.cleanupSignal.add(removeObject);
				this.addChildAt(s, 1);
				s.begin();
				
				var cannonBallPhysicsBody:Body = new Body(BodyType.DYNAMIC, new Vec2(mcCannon.x, mcCannon.y));
				var material:Material = new Material(0.5);
				cannonBallPhysicsBody.shapes.add(new Circle(s.width / 2, null, material));
				cannonBallPhysicsBody.cbTypes.add(ballCollisionType);
				space.bodies.add(cannonBallPhysicsBody);
			
				cannonBallPhysicsBody.userData.graphic = s;
				cannonBallPhysicsBody.mass = 1;
				
					
				var velocityVec:Vec2 = new Vec2(mcCannon.frontPoint.x - mcCannon.backPoint.x, mcCannon.frontPoint.y - mcCannon.backPoint.y);
				var scaler:Number = this.mcPowerBar.scaleX * 30;
				velocityVec = velocityVec.mul(scaler);
				trace(velocityVec.x + ", " + velocityVec.y);
					
				cannonBallPhysicsBody.velocity = velocityVec;
				
				bRotating = true;
				mcPowerBar.end();
			}
			
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		//Removes all movieclips on screen end
		public function cleanScreen():void
		{
			for (var i:uint = 0; i < aOnScreenObjects.length; i++)
			{
				this.aOnScreenObjects[i].end();
				this.removeChild(aOnScreenObjects[i]);
			}
		}
		/* ---------------------------------------------------------------------------------------- */
		
		public function removeObject($object:AbstractGameObject):void
		{
			var objectIndex :int = aOnScreenObjects.indexOf($object);
			
			if ($object.objectType == GameObjectType.TYPE_SHIELD_POWERUP ||
				$object.objectType == GameObjectType.TYPE_SPEED_POWERUP)
				{
					trace("Powerup hit");
					this.bPowerupActive = false;
				}
				
			if (objectIndex >= 0)
			{
				trace("GameScreen: Removing Object");
				$object.end();
				this.removeChild($object);
				aOnScreenObjects.splice(objectIndex, 1);
			}
			
		}
		
		/* ---------------------------------------------------------------------------------------- */
		//[ EVENT TRIGGERS ]
		/* ---------------------------------------------------------------------------------------- */
		protected function quitClicked($e:MouseEvent):void
		{
			trace("Game Screen: Quit Clicked.");
			this.space.clear();
			this.player1Castle.end();
			this.player2Castle.end();
			this.cleanScreen();
			
			this.quitClickedSignal.dispatch();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function pauseClicked($e:MouseEvent):void
		{
			trace("Game Screen: Pause Clicked.");
			//TODO: Pause game logic or call here
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function spawnPowerup($e:TimerEvent):void
		{
			if (bPowerupActive)
				return;
			
			trace("GameScreen: Spawning Powerup");
			
			var powerup :AbstractPowerup = new ShieldPowerup();
			
			this.bPowerupActive = true;
			this.aOnScreenObjects.push(powerup);
			//this.space.bodies.add(powerup.getPhysicsBody);
			
			CollisionManager.instance.add(powerup);
			powerup.cleanupSignal.add(removeObject);
			this.addChild(powerup);
			powerup.begin();
			
		}
		/* ---------------------------------------------------------------------------------------- */
		//[ / EVENT TRIGGERS ]
		/* ---------------------------------------------------------------------------------------- */
	}
}

