﻿package com.teamphysics.zachl.blocks
{
	import com.greensock.loading.LoaderMax;
	import com.greensock.TweenMax;
	import com.natejc.input.KeyboardManager;
	import com.natejc.input.KeyCode;
	import com.natejc.utils.StageRef;
	import com.teamphysics.util.CollisionManager;
	import com.teamphysics.util.SpaceRef;
	import com.teamphysics.zachl.blocks.BaseBlock;
	import com.teamphysics.zachl.blocks.HorizontalRectangleBlock;
	import com.teamphysics.zachl.blocks.KingBlock;
	import com.teamphysics.zachl.blocks.LargeSquareBlock;
	import com.teamphysics.zachl.blocks.LargeStoneSquareBlock;
	import com.teamphysics.zachl.blocks.LongBlock;
	import com.teamphysics.zachl.blocks.RectangleBlock;
	import com.teamphysics.zachl.blocks.SquareBlock;
	import com.teamphysics.zachl.blocks.StoneSquareBlock;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionListener;
	import nape.phys.Body;
	import org.osflash.signals.Signal;

	public class Castle extends MovieClip
	{
		
		private var castle					:String;
		private var placementArray			:Array;
		private var aOnScreenObjects		:Array;
		private var blockArray				:Array;
		private var arrayOfBlocks			:Vector.<BaseBlock>;

		private var player					:String;
		private var stringCoords			:String;
		protected var kingCollisionType		:CbType = new CbType();
		protected var ballCollisionType		:CbType = new CbType();
		protected var interactionListener	:InteractionListener;
		public var kingDiedSignal 			:Signal = new Signal();
		private var nWidth 					:int = StageRef.stage.stageWidth;
		private var _nCollisionGroup		:int;
		private var castleNumber			:int;

		
		private var kingPlacementBlocks		:Vector.<KingPlacementBlock>;
		private var curKingPlacementBlock	:KingPlacementBlock;
		private var _nCurKingPlacementIndex	:int;
		public var kingPlacedSignal			:Signal = new Signal();
		private var king					:KingBlock;
		private var tKingPlacementTimer		:Timer;
		

		//Bodies
		private var body		:Body;
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Constructs the BaseCollectible object.
		 */
		public function Castle()
		{
			super();		
			this.stop();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		public function begin($player:String, $castleNumber: int) :void
		{
			this.play();
			this.visible = true;
			this.player = $player;
			this.castleNumber = $castleNumber
			parseXML();
			this.aOnScreenObjects = new Array();
			arrayOfBlocks = new Vector.<BaseBlock>;

			kingPlacementBlocks = new Vector.<KingPlacementBlock>();
			tKingPlacementTimer = new Timer(100);

			this.buildCastle();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function buildCastle():void
		{	
						
			var w:int = StageRef.stage.stageWidth;
			var h:int = StageRef.stage.stageHeight;
			
			var i:int = 0;
			var block:BaseBlock;
						
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
				else if(blockArray[i] == "hwb")
				{
					block = new HorizontalRectangleBlock();
					StageRef.stage.addChild(block);
				}
				else if (blockArray[i] == "si")
				{
					block = new LongBlock();
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
					block= new KingPlacementBlock();
					kingPlacementBlocks.push(block);
					StageRef.stage.addChild(block);
				}
				
				block.buildBlock(placementArray[i], h - ((i + 1) * 100), _nCollisionGroup);
				
				arrayOfBlocks.push(block);

				aOnScreenObjects.push(block);
				CollisionManager.instance.add(block);
				SpaceRef.space.bodies.at(i).allowRotation = false;
			}
			TweenMax.delayedCall(5, allowRotation);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function swapKingPosition(e:Event)
		{
			_nCurKingPlacementIndex = (_nCurKingPlacementIndex + 1) % kingPlacementBlocks.length;
			curKingPlacementBlock.mcKing.visible = false;
			curKingPlacementBlock = kingPlacementBlocks[_nCurKingPlacementIndex];
			curKingPlacementBlock.mcKing.visible = false;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		private function lockKingPosition()
		{
			this.tKingPlacementTimer.stop();
			trace("curTempKing x: " + this.curKingPlacementBlock.xCoordinate);
			trace("curTempKing y: " + this.curKingPlacementBlock.yCoordinate);
			king = new KingBlock();
			trace("curKingPlacementBlock.mcKing.x: " + curKingPlacementBlock.mcKing.x + "curKingPlacementBlock.mcKing.y" + curKingPlacementBlock.mcKing.y);
			king.buildBlock(this.curKingPlacementBlock.xCoordinate, this.curKingPlacementBlock.yCoordinate, _nCollisionGroup);
			trace("after king.buildblock");
			
			aOnScreenObjects.push(king);
			arrayOfBlocks.push(king);
			CollisionManager.instance.add(king);
			if (player == "Player1")
			{
				KeyboardManager.instance.removeKeyDownListener(KeyCode.A, lockKingPosition);
			}
			else
			{
				KeyboardManager.instance.removeKeyDownListener(KeyCode.L, lockKingPosition);
			}
			kingPlacedSignal.dispatch();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		

		public function allowRotation():void
		{
			for(var i :uint = 0; i < SpaceRef.space.bodies.length; i++)
			{
				SpaceRef.space.bodies.at(i).allowRotation = true;
			}
			tKingPlacementTimer.addEventListener(TimerEvent.TIMER, swapKingPosition);
			
			if (player == "Player1")
			{
				KeyboardManager.instance.addKeyDownListener(KeyCode.A, lockKingPosition);
			}
			else
			{
				KeyboardManager.instance.addKeyDownListener(KeyCode.L, lockKingPosition);
			}
			_nCurKingPlacementIndex = 0;
			curKingPlacementBlock = kingPlacementBlocks[_nCurKingPlacementIndex];
			tKingPlacementTimer.start();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function resetBlocks()
		{
			for (var i:uint; i < arrayOfBlocks.length; i++)
			{
				arrayOfBlocks[i].bHasBeenCollidedWith = false;
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
		protected function parseXML():void
		{
			var xConfig:XML = LoaderMax.getContent("config.xml");
			if(castleNumber == 1)
			{
				this.castle = String(xConfig.gameObjects.Castle1.blocks);
				blockArray = this.castle.split(" ");
				if(player == "Player1")
				{
					this.stringCoords = String(xConfig.gameObjects.Castle1.p1coords);
					_nCollisionGroup = 1;
				}
				else
				{
					this.stringCoords = String(xConfig.gameObjects.Castle1.p2coords);
					_nCollisionGroup = 2;
				}
			}
			else if(castleNumber == 2)
			{
				this.castle = String(xConfig.gameObjects.Castle2.blocks);
				blockArray = this.castle.split(" ");
				if(player == "Player1")
				{
					this.stringCoords = String(xConfig.gameObjects.Castle2.p1coords);
					_nCollisionGroup = 1;
				}
				else
				{
					this.stringCoords = String(xConfig.gameObjects.Castle2.p2coords);
					_nCollisionGroup = 2;
				}
			}
			else if(castleNumber == 3)
			{
				this.castle = String(xConfig.gameObjects.Castle3.blocks);
				blockArray = this.castle.split(" ");
				if(player == "Player1")
				{
					this.stringCoords = String(xConfig.gameObjects.Castle3.p1coords);
					_nCollisionGroup = 1;
				}
				else
				{
					this.stringCoords = String(xConfig.gameObjects.Castle3.p2coords);
					_nCollisionGroup = 2;
				}
			}
			else if(castleNumber == 4)
			{
				this.castle = String(xConfig.gameObjects.Castle4.blocks);
				blockArray = this.castle.split(" ");
				if(player == "Player1")
				{
					this.stringCoords = String(xConfig.gameObjects.Castle4.p1coords);
					_nCollisionGroup = 1;
				}
				else
				{
					this.stringCoords = String(xConfig.gameObjects.Castle4.p2coords);
					_nCollisionGroup = 2;
				}
			}
			else if(castleNumber == 5)
			{
				this.castle = String(xConfig.gameObjects.Castle5.blocks);
				blockArray = this.castle.split(" ");
				if(player == "Player1")
				{
					this.stringCoords = String(xConfig.gameObjects.Castle5.p1coords);
					_nCollisionGroup = 1;
				}
				else
				{
					this.stringCoords = String(xConfig.gameObjects.Castle5.p2coords);
					_nCollisionGroup = 2;
				}
			}
			else if(castleNumber == 6)
			{
				this.castle = String(xConfig.gameObjects.Castle6.blocks);
				blockArray = this.castle.split(" ");
				if(player == "Player1")
				{
					this.stringCoords = String(xConfig.gameObjects.Castle6.p1coords);
					_nCollisionGroup = 1;
				}
				else
				{
					this.stringCoords = String(xConfig.gameObjects.Castle6.p2coords);
					_nCollisionGroup = 2;
				}
			}
			placementArray = this.stringCoords.split(" ");

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
		
		public function cleanPlaceMentBlocks()
		{
			var block:KingPlacementBlock;
			for (var i:int = 0; i < kingPlacementBlocks.length; i++)
			{
				block = kingPlacementBlocks.pop();
				block.end();
				StageRef.stage.removeChild(block);
			}
		}
	}
}