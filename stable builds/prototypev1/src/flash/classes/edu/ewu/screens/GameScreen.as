package edu.ewu.screens 
{
	
	import com.natejc.input.KeyboardManager;
	import com.natejc.input.KeyCode;
	import com.natejc.util.StageRef;
	import edu.ewu.Assets.blocks.BaseBlock;
	import edu.ewu.Assets.blocks.KingBlock;
	import edu.ewu.Assets.blocks.LargeSquareBlock;
	import edu.ewu.Assets.blocks.RectangleBlock;
	import edu.ewu.Assets.blocks.SquareBlock;
	import edu.ewu.Assets.Cannon;
	import edu.ewu.Assets.CannonBall;
	import edu.ewu.Assets.PowerBar;
	import edu.ewu.screens.AbstractScreen;
	import flash.display.DisplayObject;
	import flash.events.Event;
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
	import nape.util.BitmapDebug;
	import nape.util.Debug;
	
	/**
	 * ...
	 * @author Sam Gronhovd
	 */
	public class GameScreen extends AbstractScreen
	{
		/* Reference to the Nape Physics space */
		private var space:Space;
		public var debug:Debug;
		/* Reference to the floor physics body object */
		private var floorPhysicsBody		:Body;
		
		private var wallPhysicsBody			:Body;
		
		public var mcCannon					:Cannon;
		
		private var nCannonRotateAmount		:Number;
		
		private var bRotatingUp				:Boolean;
		
		private var bRotating				:Boolean;
		
		public var mcPowerBar				:PowerBar;
		
		public var castle					:String;
		
		public var placementArray			:Array;
		public var placementArray2			:Array;
		
		public var castle2					:String;
		
		public var p1Array					:Array;
		
		public var p2Array					:Array;
		
		private var handJoint				:PivotJoint;
		
		private var interactionListener		:InteractionListener;
		
		private var kingCollisionType		:CbType = new CbType();
		
		private var ballCollisionType		:CbType = new CbType();
		
		//public var debug:Debug;
		
		public function GameScreen() 
		{
			super();
			nCannonRotateAmount = 0;
			bRotatingUp = true;
			bRotating = true;
		}
		
		public override function begin()
		{
			super.begin();
			this.castle = String("lsb lsb lsb lsb kb rww lww rww lww si ssb ssb ssb ssb rww lww rww lww si");
			this.castle2 = String("rww lww rww lww si rww rww si");
			p1Array = this.castle.split(" ");
			p2Array = this.castle2.split(" ");
			placementArray = [stage.stageWidth - 50, stage.stageWidth - 100, stage.stageWidth - 150, stage.stageWidth - 200, stage.stageWidth - 125, stage.stageWidth - 200, stage.stageWidth - 50, stage.stageWidth - 200, stage.stageWidth - 50, stage.stageWidth - 125, stage.stageWidth - 75, stage.stageWidth - 75, stage.stageWidth - 175, stage.stageWidth - 175, stage.stageWidth - 200, stage.stageWidth - 50, stage.stageWidth - 200, stage.stageWidth - 50, stage.stageWidth - 125];
			placementArray2 = [50, 100, 150, 200, 125, 200, 50, 200, 50, 125, 75, 75, 175, 175, 200, 50, 200, 50, 125];
			
			
			space = new Space(new Vec2(0, 500));
			//debug = new BitmapDebug(stage.stageWidth, stage.stageHeight, stage.color);
			//addChild(debug.display);	
			
			floorPhysicsBody = new Body(BodyType.STATIC);
			var p:Polygon = new Polygon (
								Polygon.rect(
									0, 							// x position
									stage.stageHeight - 82, 	// y position
									stage.stageWidth, 			// width
									100							// height
											)
										);
			floorPhysicsBody.shapes.add(p);
			space.bodies.add(floorPhysicsBody);
			floorPhysicsBody.space = space;
			
			/*wallPhysicsBody = new Body(BodyType.STATIC);
			var p2:Polygon = new Polygon (
								Polygon.rect(
									stage.stageWidth - 50,	// x position
									0, 	// y position
									stage.stageWidth, 	// width
									stage.stageHeight	// height
											)
										);
			wallPhysicsBody.shapes.add(p2);
			space.bodies.add(wallPhysicsBody);
			wallPhysicsBody.space = space;*/
			
			
			mcCannon.begin();
			
			//mcPowerBar.begin();
			
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			KeyboardManager.instance.addKeyDownListener(KeyCode.A, addCannonBall);
			interactionListener = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, ballCollisionType, kingCollisionType, kingHit);
			space.listeners.add(interactionListener);
			//this.addEventListener(MouseEvent.CLICK, addCannon);
			
			buildCastles();
			
		}
		
		private function buildCastles()
		{
			var w:int = stage.stageWidth;
			var h:int = stage.stageHeight;
			
			
			var i:int = 0;
			//var blockPhysicsBody:Body;
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
			
				//blockPhysicsBody = new Body(BodyType.DYNAMIC, new Vec2(placementArray[i], h - (i * 100)));
				//blockPhysicsBody.shapes.add(new Polygon(Polygon.box(block.width, block.height)));
				var blockPhysicsBody:Body = new Body(BodyType.DYNAMIC);
				blockPhysicsBody.shapes.add(new Polygon(Polygon.box(block.width, block.height)));
				blockPhysicsBody.position.setxy(placementArray[i], h - ((i+1) * 100));				
				
				if (block is KingBlock)
				{
					blockPhysicsBody.cbTypes.add(kingCollisionType);
				}
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
				{
					blockPhysicsBody.cbTypes.add(kingCollisionType);
				}
				space.bodies.add(blockPhysicsBody);
			
				blockPhysicsBody.userData.graphic = block;
			
			}
			//End add second castle
		}
		
		public function kingHit(ev: InteractionCallback):void
		{
			trace("King collision detected");
		}
		
		public function enterFrameHandler(e:Event)
		{
			space.step(1 / stage.frameRate);
			space.bodies.foreach(updateGraphics);
			
			//debug.clear();
			//debug.draw(space);
			//debug.flush();
			
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
				
				//debug.clear();
				//debug.draw(space);
				//debug.flush();
				
			}
			
			mcCannon.rotate(nCannonRotateAmount);
		}
		
		private function updateGraphics(b:Body)
		{
			// Grab a reference to the visual which we will update
			var graphic:DisplayObject = b.userData.graphic;
			
			// Update position of the graphic to match the simulation
			graphic.x = b.position.x ;
			graphic.y = b.position.y ;
			
			// Update the rotation of the graphic. Note: AS3 uses degrees to express rotation 
			// while Nape uses radians. Also, the modulo (%360) has been put in because AS3 
			// does not like big numbers for rotation (so I've read).
			graphic.rotation = (b.rotation * 180 / Math.PI) % 360;
		}
		
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
				this.addChild(s);
			
				var cannonBallPhysicsBody:Body = new Body(BodyType.DYNAMIC, new Vec2(mcCannon.x, mcCannon.y));
				var material:Material = new Material(0.5);
				cannonBallPhysicsBody.shapes.add(new Circle(s.width / 2, null, material));
				cannonBallPhysicsBody.cbTypes.add(ballCollisionType);
				space.bodies.add(cannonBallPhysicsBody);
			
				cannonBallPhysicsBody.userData.graphic = s;
					
				var velocityVec:Vec2 = new Vec2(mcCannon.frontPoint.x - mcCannon.backPoint.x, mcCannon.frontPoint.y - mcCannon.backPoint.y);
				var scaler:Number = this.mcPowerBar.scaleX * 30;
				velocityVec = velocityVec.mul(scaler);
				trace(velocityVec.x + ", " + velocityVec.y);
					
				cannonBallPhysicsBody.velocity = velocityVec;
				
				bRotating = true;
				mcPowerBar.end();
			}
			
		}
		
	}

}