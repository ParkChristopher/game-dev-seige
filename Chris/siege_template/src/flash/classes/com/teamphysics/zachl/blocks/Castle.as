package com.teamphysics.zachl.blocks
{
	import com.natejc.input.KeyboardManager;
	import com.natejc.input.KeyCode;
	import com.teamphysics.util.SpaceRef;
	import com.natejc.utils.StageRef;
	import flash.display.SimpleButton;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import org.osflash.signals.Signal;
	import com.teamphysics.zachl.blocks.BaseBlock;
	import com.teamphysics.zachl.blocks.KingBlock;
	import com.teamphysics.zachl.blocks.LargeSquareBlock;
	import com.teamphysics.zachl.blocks.RectangleBlock;
	import com.teamphysics.zachl.blocks.SquareBlock;
	import com.teamphysics.zachl.blocks.LargeStoneSquareBlock;
	import com.teamphysics.zachl.blocks.StoneSquareBlock;
	import nape.phys.Material;
	import org.osflash.signals.Signal;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.XMLLoader;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import nape.geom.Vec2;

	public class Castle extends MovieClip
	{
		
		private var castle					:String;
		private var placementArray			:Array;
		private var aOnScreenObjects		:Array;
		private var blockArray				:Array;
		protected var kingCollisionType		:CbType = new CbType();
		protected var ballCollisionType		:CbType = new CbType();
		protected var interactionListener	:InteractionListener;
		public var kingDiedSignal 			:Signal = new Signal();
		private var nWidth 					:int = StageRef.stage.stageWidth;

		//Bodies
		private var body		:Body;
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Constructs the BaseCollectible object.
		 */
		public function Castle()
		{
			super();
			this.castle = String("lssb lssb lssb lssb kb uwb uwb si uwb uwb si ssb ssb ssb ssb sssb sssb sssb sssb ssb");
			blockArray = this.castle.split(" ");			
			parseXML();
			this.stop();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		public function begin($Player:String) :void
		{
			this.play();
			this.visible = true;
			this.aOnScreenObjects = new Array();
			if($Player == "Player1")
			{
				placementArray = [50, 100, 150, 200, 125, 200, 50, 125, 200, 50, 125, 75, 75, 175, 175, 300, 300, 300, 300, 300];
			}
			else
			{
				placementArray = [nWidth - 50, nWidth - 100, nWidth - 150, nWidth - 200, nWidth - 125, nWidth - 200, nWidth - 50, nWidth - 125, nWidth - 200, nWidth - 50, nWidth - 125, nWidth - 75, nWidth - 75, nWidth - 175, nWidth - 175, nWidth-300, nWidth-300, nWidth-300, nWidth-300, nWidth-300];
			}
			
			this.buildCastle();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function buildCastle():void
		{	
						
			var w:int = StageRef.stage.stageWidth;
			var h:int = StageRef.stage.stageHeight;
			
			var i:int = 0;
			var block:BaseBlock;
			var largeSquareBlock:LargeSquareBlock;
			var smallSquareBlock:SquareBlock;
			var kingBlock:KingBlock;
			var material:Material;
						
			for ( i = 0; i < blockArray.length; i++)
			{
				if (blockArray[i] == "lsb")
				{
					block = new LargeSquareBlock();
					StageRef.stage.addChild(block);
				}
				if (blockArray[i] == "lssb")
				{
					block = new LargeStoneSquareBlock();
					StageRef.stage.addChild(block);
				}
				else if (blockArray[i] == "uwb")
				{
					block = new RectangleBlock();
					StageRef.stage.addChild(block);
				}			
				else if (blockArray[i] == "si")
				{
					block = new RectangleBlock();
					block.width = 250;
					block.height = 15;
					StageRef.stage.addChild(block);
				}
				else if (blockArray[i] == "ssb")
				{
					block = new SquareBlock();
					StageRef.stage.addChild(block);
				}
				else if (blockArray[i] == "sssb")
				{
					block = new StoneSquareBlock();
					StageRef.stage.addChild(block);
				}
				else if (blockArray[i] == "kb")
				{
					block = new KingBlock();
					StageRef.stage.addChild(block);
				}

				var blockPhysicsBody:Body = new Body(BodyType.DYNAMIC);
				blockPhysicsBody.shapes.add(new Polygon(Polygon.box(block.width, block.height)));
				blockPhysicsBody.position.setxy(placementArray[i], h - ((i+1) * 100));				
				
				if (block is KingBlock)
				{
					blockPhysicsBody.cbTypes.add(kingCollisionType);
					trace("kingCollisionType set");
				}
				aOnScreenObjects.push(block);
				SpaceRef.space.bodies.add(blockPhysicsBody);
				blockPhysicsBody.userData.graphic = block;
				SpaceRef.space.bodies.at(i).allowRotation = false;
			}
			TweenMax.delayedCall(5, allowRotation);

		}
		
		public function allowRotation():void
		{
			trace("Inside allowRotation");
			for(var i :uint = 0; i < SpaceRef.space.bodies.length; i++)
			{
				SpaceRef.space.bodies.at(i).allowRotation = true;
			}
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function end():void
		{
			this.stop();
			this.visible = false;
			this.cleanUp();
		}
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Loads the parameters from the XML file to the local variables in this class
		 */
		protected static function parseXML():void
		{
			//var xConfig:XML = LoaderMax.getContent("config.xml");
			//_increaseValue = int(xConfig.gameObjects.scoringIncrease);
		}
		
		public function get kingHitBox():CbType
		{
			return kingCollisionType;
		}
		
		public function cleanUp() :void
		{
			for (var i:uint = 0; i < aOnScreenObjects.length; i++)
			{
				this.aOnScreenObjects[i].end();
				StageRef.stage.removeChild(aOnScreenObjects[i]);
			}
		}
	}
}