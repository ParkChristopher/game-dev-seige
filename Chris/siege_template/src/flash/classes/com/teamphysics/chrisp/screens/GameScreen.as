package com.teamphysics.chrisp.screens {
	
	
	
	import com.natejc.input.KeyboardManager;
	import com.natejc.input.KeyCode;
	import com.teamphysics.chrisp.screens.AbstractScreen;
	import com.teamphysics.samg.Cannon;
	import com.teamphysics.samg.CannonBall;
	import com.teamphysics.samg.PowerBar;
	import com.teamphysics.zachl.blocks.BaseBlock;
	import com.teamphysics.zachl.blocks.KingBlock;
	import com.teamphysics.zachl.blocks.LargeSquareBlock;
	import com.teamphysics.zachl.blocks.RectangleBlock;
	import com.teamphysics.zachl.blocks.SquareBlock;
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
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
		public var placementArray2			:Array;
		
		//Strings
		public var castle					:String;
		public var castle2					:String;
		
		//Booleans
		protected var bRotatingUp			:Boolean;
		protected var bRotating				:Boolean;
		
		//Numbers
		protected var nCannonRotateAmount	:Number;
		
		//Cannon
		public var mcCannon					:Cannon;
		public var mcPowerBar				:PowerBar;
		
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
			
			nCannonRotateAmount = 0;
			bRotatingUp = true;
			bRotating = true;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function begin():void
		{
			super.begin();
			
			//Power Bar
			this.mcPowerBar = new PowerBar();
			this.addChildAt(mcPowerBar, 1);
			
			this.btQuit.addEventListener(MouseEvent.CLICK, quitClicked);
			this.btPause.addEventListener(MouseEvent.CLICK, pauseClicked);
			
			this.castle = String("lsb lsb lsb lsb kb rww lww rww lww si ssb ssb ssb ssb rww lww rww lww si");
			this.castle2 = String("rww lww rww lww si rww rww si");
			p1Array = this.castle.split(" ");
			p2Array = this.castle2.split(" ");
			placementArray = [stage.stageWidth - 50, stage.stageWidth - 100,
				stage.stageWidth - 150, stage.stageWidth - 200, stage.stageWidth - 125,
				stage.stageWidth - 200, stage.stageWidth - 50, stage.stageWidth - 200,
				stage.stageWidth - 50, stage.stageWidth - 125, stage.stageWidth - 75,
				stage.stageWidth - 75, stage.stageWidth - 175, stage.stageWidth - 175,
				stage.stageWidth - 200, stage.stageWidth - 50, stage.stageWidth - 200,
				stage.stageWidth - 50, stage.stageWidth - 125];
			placementArray2 = [50, 100, 150, 200, 125, 200, 50, 200, 50, 125, 75, 75,
				175, 175, 200, 50, 200, 50, 125];
			
			//Create the space
			space = new Space(new Vec2(0, 500));
			
			
			
			//Create Floor
			floorPhysicsBody = new Body(BodyType.STATIC);
			var p:Polygon = new Polygon ( Polygon.rect(0, stage.stageHeight - 82,
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
			this.addChildAt(mcCannon, 1);
			mcCannon.begin();
			
			//Listeners King/Ball Collision, Enter Frame, Cannon Keyboard Input
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			KeyboardManager.instance.addKeyDownListener(KeyCode.A, addCannonBall);
			interactionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION,
				ballCollisionType, kingCollisionType, kingHit);
			space.listeners.add(interactionListener);
			
			//Build Castles
			buildCastles();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
			super.end();
			this.btQuit.removeEventListener(MouseEvent.CLICK, quitClicked);
			this.btPause.removeEventListener(MouseEvent.CLICK, pauseClicked);
			
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			KeyboardManager.instance.removeKeyDownListener(KeyCode.A, addCannonBall);
			
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		private function buildCastles()
		{
			var w:int = stage.stageWidth;
			var h:int = stage.stageHeight;
			
			
			var i:int = 0;
			var block:BaseBlock;
			var largeSquareBlock:LargeSquareBlock;
			var smallSquareBlock:SquareBlock;
			var kingBlock:KingBlock;
			var material:Material;
			
			trace(p1Array.length);
			
			for ( i = 0; i < p1Array.length; i++)
			{
				if (p1Array[i] == "lsb")
				{
					block = new LargeSquareBlock();
					this.addChild(block);
				}
				else if (p1Array[i] == "rww")
				{
					block = new RectangleBlock();
					this.addChild(block);
				}
				else if (p1Array[i] == "lww")
				{
					block = new RectangleBlock();
					this.addChild(block);
				}				
				else if (p1Array[i] == "si")
				{
					block = new RectangleBlock();
					block.width = 250;
					block.height = 10;
					this.addChild(block);
				}
				else if (p1Array[i] == "ssb")
				{
					block = new SquareBlock();
					this.addChild(block);
				}
				else if (p1Array[i] == "kb")
				{
					block = new KingBlock();
					
					this.addChild(block);
				}
				
				//Once block is determined and created, make a body for it and add it to the space
				var blockPhysicsBody:Body = new Body(BodyType.DYNAMIC);
				blockPhysicsBody.shapes.add(new Polygon(Polygon.box(block.width, block.height)));
				blockPhysicsBody.position.setxy(placementArray[i], h - ((i+1) * 100));				
				
				if (block is KingBlock)
					blockPhysicsBody.cbTypes.add(kingCollisionType);
				
				space.bodies.add(blockPhysicsBody);
				blockPhysicsBody.userData.graphic = block;
				
			}
			
			//Add second castle here
			for ( i = 0; i < p1Array.length; i++)
			{
				if (p1Array[i] == "lsb")
				{
					block = new LargeSquareBlock();
					this.addChild(block);
				}
				else if (p1Array[i] == "rww")
				{
					block = new RectangleBlock();
					this.addChild(block);
				}
				else if (p1Array[i] == "lww")
				{
					block = new RectangleBlock();
					this.addChild(block);
				}				
				else if (p1Array[i] == "si")
				{
					block = new RectangleBlock();
					block.width = 250;
					block.height = 10;
					this.addChild(block);
				}
				else if (p1Array[i] == "ssb")
				{
					block = new SquareBlock();
					this.addChild(block);
				}
				else if (p1Array[i] == "kb")
				{
					block = new KingBlock();
					
					this.addChild(block);
				}
			
				var blockPhysicsBody:Body = new Body(BodyType.DYNAMIC);
				blockPhysicsBody.shapes.add(new Polygon(Polygon.box(block.width, block.height)));
				blockPhysicsBody.position.setxy(placementArray2[i], h - ((i+1) * 100));				
				
				if (block is KingBlock)
					blockPhysicsBody.cbTypes.add(kingCollisionType);
					
				space.bodies.add(blockPhysicsBody);
				blockPhysicsBody.userData.graphic = block;
			}
			//End add second castle
		}
		/* ---------------------------------------------------------------------------------------- */
		
		public function kingHit(ev: InteractionCallback):void
		{
			trace("King collision detected");
			this.screenCompleteSignal.dispatch();
			
			
			this.space.clear();
			
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
				s.begin();
				this.addChildAt(s, 1);
			
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
		//[ BUTTON EVENT TRIGGERS ]
		/* ---------------------------------------------------------------------------------------- */
		protected function quitClicked($e:MouseEvent):void
		{
			trace("Game Screen: Quit Clicked.");
			this.space.clear();
			
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

