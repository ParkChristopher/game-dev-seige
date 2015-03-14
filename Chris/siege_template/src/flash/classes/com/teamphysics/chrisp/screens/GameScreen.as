package com.teamphysics.chrisp.screens 
{
	
	import com.greensock.TweenMax;
	import com.natejc.utils.StageRef;
	import com.teamphysics.chrisp.AbstractGameObject;
	import com.teamphysics.chrisp.powerups.AbstractPowerup;
	import com.teamphysics.chrisp.powerups.ShieldPowerup;
	import com.teamphysics.chrisp.powerups.SpeedPowerup;

	import com.teamphysics.chrisp.powerups.ShieldBlock;

	import com.teamphysics.chrisp.screens.AbstractScreen;
	import com.teamphysics.chrisp.powerups.ShieldBlock;
	import com.teamphysics.chrisp.screens.CastleSelectScreen;

	import com.teamphysics.samg.Cannon;
	import com.teamphysics.samg.PowerBar;
	import com.teamphysics.util.CollisionManager;
	import com.teamphysics.util.GameObjectType;
	import com.teamphysics.util.ScoreManager;
	import com.teamphysics.util.SoundManager;
	import com.teamphysics.util.SpaceRef;
	import com.teamphysics.zachl.blocks.Castle;
	import com.teamphysics.zachl.blocks.RectangleBlock;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import nape.callbacks.CbEvent;
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionListener;
	import nape.callbacks.InteractionType;
	import nape.constraint.PivotJoint;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import nape.space.Space;
	import nape.util.BitmapDebug;
	import nape.util.Debug;
 	import nape.util.BitmapDebug;
	import org.osflash.signals.Signal;
	import com.teamphysics.util.SoundManager;
	import com.natejc.utils.StageRef;
	import com.teamphysics.util.ScoreManager;
	
	/**
	 * Game Screen
	 * 
	 * @author Chris Park, Zach Lontz, Sam Gronhovd
	 */
	public class GameScreen extends FadeScreen
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
		
		//Strings
		public var castle					:String;
		public var castle2					:String;
		
		//Score Boxes
		public var txtP1Score				:TextField;
		public var txtP2Score				:TextField;
		
		//Booleans
		protected var bCannonP1RotatingUp	:Boolean;
		protected var bCannonP1IsRotating	:Boolean;
		protected var bCannonP2RotatingUp	:Boolean;
		protected var bCannonP2IsRotating	:Boolean;
		protected var bIsPaused				:Boolean;
		
		protected var bPowerupActive		:Boolean;
		
		//Numbers
		protected var nCannonOneRotateAmount	:Number;
		protected var nCannonTwoRotateAmount	:Number;
		public var nSpeedMultiplier				:Number = 0;
		
		//Cannon
		public var player1Cannon			:Cannon;
		public var player2Cannon			:Cannon;
		public var player1PowerBar			:PowerBar;
		public var player2PowerBar			:PowerBar;
		
		//Castles
		public var player1Castle			: Castle = new Castle();
		public var player2Castle			: Castle = new Castle();
		public var p1CastleChoice			:int = 0;
		public var p2CastleChoice			:int = 0;
		
		private var p1KingLocked			:Boolean = false;
		private var p2KingLocked			:Boolean = false;
		
		//Powerup 
		public var mcP1SpeedIndicator		:MovieClip;
		public var mcP1ShieldIndicator		:MovieClip;
		public var mcP2SpeedIndicator		:MovieClip;
		public var mcP2ShieldIndicator		:MovieClip;
		
		public var shieldBlockP1			:ShieldBlock;
		public var shieldBlockP2			:ShieldBlock;
		public var mcP1Shield				:MovieClip;
		public var mcP2Shield				:MovieClip;

		public var mcPlayer1AmmoSelector		:MovieClip;
		public var mcPlayer2AmmoSelector		:MovieClip;

		
		//Physics Parts
		public var debug					:Debug;
		protected var space					:Space;
		protected var floorPhysicsBody		:Body;
		protected var wallPhysicsBody		:Body;
		protected var handJoint				:PivotJoint;
		protected var king1CollisionType	:CbType = new CbType();
		protected var king2CollisionType	:CbType = new CbType();
		protected var ballCollisionType		:CbType = new CbType();

		//DEBUG SETTINGS
		public var debugToggle				:Boolean = false;
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the GameScreen object.
		 */
		public function GameScreen()
		{
			super();
			
			nCannonOneRotateAmount = 0;
			nCannonTwoRotateAmount = 0;
			bCannonP1RotatingUp = true;
			bCannonP1IsRotating = true;
			bCannonP2RotatingUp = true;
			bCannonP2IsRotating = true;
		}
		
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function begin():void
		{
			super.begin();
			SoundManager.instance.playGameMusic();
			CollisionManager.instance.reset();
			CollisionManager.instance.begin();
			
			ScoreManager.instance.reset();
			this.txtP1Score.text = "0";
			this.txtP2Score.text = "0";
			
			this.bIsPaused = false;
			
			//Turn off indicators until a powerup is acquired.
			this.mcP1Shield.visible = false;
			this.mcP2Shield.visible = false;
			this.mcP1ShieldIndicator.visible = false;
			this.mcP1SpeedIndicator.visible = false;
			this.mcP2ShieldIndicator.visible = false;
			this.mcP2SpeedIndicator.visible = false;
			this.bPowerupActive = false;
			
			this.mcPlayer1AmmoSelector.visible = false;
			this.mcPlayer2AmmoSelector.visible = false;
			this.player1ChangeShotIndicator("single");
			this.player2ChangeShotIndicator("single");
			
			//Set up and start the powerup timer.
			this.powerupTimer = new Timer(5000);
			this.powerupTimer.addEventListener(TimerEvent.TIMER, spawnPowerup);
			this.powerupTimer.start();
			
			this.aOnScreenObjects = new Array();
			
			
			//Power Bars
			this.player1PowerBar = new PowerBar();
			this.addChildAt(player1PowerBar, 1);
			this.player2PowerBar = new PowerBar();
			this.addChildAt(player2PowerBar, 1);
			
			this.btQuit.addEventListener(MouseEvent.CLICK, quitClicked);
			this.btPause.addEventListener(MouseEvent.CLICK, pauseClicked);
			//Create the space
			space = new Space(new Vec2(0, 450));
			//DEBUG CODE
			if(this.debugToggle == true)
			{
				debug = new BitmapDebug(stage.stageWidth, stage.stageHeight, stage.color);
				addChild(debug.display);
			}
			SpaceRef.space = space;
			
			//Create Floor
			floorPhysicsBody = new Body(BodyType.STATIC);
			var p:Polygon = new Polygon ( Polygon.rect(0, stage.stageHeight - 95,
				stage.stageWidth, 100));
				p.filter.collisionGroup = 3;
			floorPhysicsBody.shapes.add(p);
			space.bodies.add(floorPhysicsBody);
			floorPhysicsBody.space = space;
			
			
			
			//Build Castles
			buildCastles();
			
			p1KingLocked = false;
			p2KingLocked = false;
			
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			this.player1Castle.kingOutOfBounds.add(kingHit);
			this.player2Castle.kingOutOfBounds.add(kingHit);
			
		}
		
		private function startCannons()
		{
			this.mcPlayer1AmmoSelector.visible = true;
			this.mcPlayer2AmmoSelector.visible = true;
			
			//Start Cannons

			player1Cannon = new Cannon();
			player1Cannon.x = 60;
			player1Cannon.y = 450;
			player1Cannon.setBallCollision(ballCollisionType);
			player1Cannon.cannonFireSignal.add(resetCastleBlocksHit);
			player1Cannon.changeShotTypeSignal.add(player1ChangeShotIndicator);
			
			StageRef.stage.addChildAt(player1Cannon, StageRef.stage.numChildren);
			player1Cannon.bOwnerIsP1 = true;
			player1Cannon.speedCleanupSignal.add(removeSpeed);
			player1Cannon.endGameSignal.add(kingHit);
			player1Cannon.begin();
			
			//Cannon 2
			player2Cannon = new Cannon();
			player2Cannon.x = 900 - 60;
			player2Cannon.y = 450;
			player2Cannon.setBallCollision(ballCollisionType);
			player2Cannon.cannonFireSignal.add(resetCastleBlocksHit);
			player2Cannon.changeShotTypeSignal.add(player2ChangeShotIndicator);

			StageRef.stage.addChildAt(player2Cannon, StageRef.stage.numChildren);
			player2Cannon.bOwnerIsP1 = false;
			player2Cannon.speedCleanupSignal.add(removeSpeed);
			player2Cannon.endGameSignal.add(kingHit);
			player2Cannon.begin();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
			super.end();
			
			CollisionManager.instance.end();
			
			this.btQuit.removeEventListener(MouseEvent.CLICK, quitClicked);
			this.btPause.removeEventListener(MouseEvent.CLICK, pauseClicked);
			
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			//Stop and remove timers
			this.powerupTimer.removeEventListener(TimerEvent.TIMER, spawnPowerup);
			this.powerupTimer.stop();
			if(this.p1KingLocked == true || this.p2KingLocked == true)
			{
				player1Cannon.speedCleanupSignal.remove(removeSpeed);
				player1Cannon.cannonFireSignal.removeAll();
				player2Cannon.speedCleanupSignal.remove(removeSpeed);
				player2Cannon.cannonFireSignal.removeAll();
			}
			this.player1Castle.cleanPlaceMentBlocks();
			this.player2Castle.cleanPlaceMentBlocks();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function resetCastleBlocksHit($playerNum:Number)
		{
			trace("resetCastleBlockHit, game screen" + $playerNum);
			if ($playerNum == 1)
			{
				player2Castle.resetBlocks();
				
				if (shieldBlockP2 != null)
					this.shieldBlockP2.bHasBeenCollidedWith = false;
			}
			else
			{
				player1Castle.resetBlocks();
				
				if (shieldBlockP1 != null)
					this.shieldBlockP1.bHasBeenCollidedWith = false;
			}
		}
		
		/* ---------------------------------------------------------------------------------------- */
		public function getCastleSelection($p1CastleChoice:int, $p2CastleChoice)
		{
			p1CastleChoice = $p1CastleChoice;
			p2CastleChoice = $p2CastleChoice;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		private function buildCastles()
		{
			player1Castle.begin("Player1", this.p1CastleChoice);

			player1Castle.kingPlacedSignal.add(player1KingSelected);

			player2Castle.begin("Player2", this.p2CastleChoice);
			player2Castle.kingPlacedSignal.add(player2KingSelected);
		}
		/* ---------------------------------------------------------------------------------------- */
		
		private function player1KingSelected()
		{
			trace("player1KingSelected");
			p1KingLocked = true;
			player1Castle.cleanPlaceMentBlocks();
			if (p1KingLocked && p2KingLocked)
			{
				startCannons();
			}
		}
		
		private function player2KingSelected()
		{
			trace("player2KingSelected");
			p2KingLocked = true;
			player2Castle.cleanPlaceMentBlocks();
			if (p1KingLocked && p2KingLocked)
			{
				startCannons();
			}
		}
		
		
		public function kingHit():void
		{
			this.screenCompleteSignal.dispatch();
			this.player1Castle.kingOutOfBounds.remove(kingHit);
			this.player2Castle.kingOutOfBounds.remove(kingHit);
			this.space.clear();
			this.cleanScreen();			
		}
		/* ---------------------------------------------------------------------------------------- */
		
		public function enterFrameHandler(e:Event)
		{
			space.step(1 / stage.frameRate);
			space.bodies.foreach(updateGraphics);
			if(this.debugToggle == true)
			{
				debug.clear();
				debug.draw(space);
				debug.flush();
			}
			
			this.updateScore();
		}
		/* ---------------------------------------------------------------------------------------- */
		
		private function player1ChangeShotIndicator($sToType:String)
		{
			if ($sToType == "single")
			{
				if (this.mcPlayer1AmmoSelector.visible)
					SoundManager.instance.playItemSelect();
					
				TweenMax.to(this.mcPlayer1AmmoSelector, .5, { y:536 } );
			}
			else
			{
				if (this.mcPlayer1AmmoSelector.visible)
					SoundManager.instance.playItemSelect();
				
				TweenMax.to(this.mcPlayer1AmmoSelector, .5, { y:580 } );
			}
		}
		
		private function player2ChangeShotIndicator($sToType:String)
		{
			if ($sToType == "single")
			{
				if (this.mcPlayer2AmmoSelector.visible)
					SoundManager.instance.playItemSelect();
					
				TweenMax.to(this.mcPlayer2AmmoSelector, .5, { y:536 } );
			}
			else
			{
				if (this.mcPlayer2AmmoSelector.visible)
					SoundManager.instance.playItemSelect();
					
				TweenMax.to(this.mcPlayer2AmmoSelector, .5, { y:580 } );
			}
		}
		
		protected function player1Rotation():void
		{
			if (this.bCannonP1IsRotating)
			{
				if (this.bCannonP1RotatingUp)
				{	
					if (this.nCannonOneRotateAmount > -66)
						this.nCannonOneRotateAmount--;
					else 
						this.bCannonP1RotatingUp = false;
				}
				else //rotating down
				{
					if (this.nCannonOneRotateAmount < 30)
						this.nCannonOneRotateAmount++;
					else
						this.bCannonP1RotatingUp = true;
				}
			}
			
			player1Cannon.rotate(nCannonOneRotateAmount);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function player2Rotation():void
		{
			if (this.bCannonP2IsRotating)
			{
				if (this.bCannonP2RotatingUp)
				{	
					if (this.nCannonTwoRotateAmount > -66)
						this.nCannonTwoRotateAmount--;
					else 
						this.bCannonP2RotatingUp = false;
				}
				else //rotating down
				{
					if (this.nCannonTwoRotateAmount < 30)
						this.nCannonTwoRotateAmount++;
					else
						this.bCannonP2RotatingUp = true;
				}
			}
			
			player2Cannon.rotate(nCannonTwoRotateAmount);
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
		
		public function removeSpeed($object:Cannon):void
		{
			if ($object.bOwnerIsP1)
				this.mcP1SpeedIndicator.visible = false;
			else
				this.mcP2SpeedIndicator.visible = false;
		}
		
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function removeShield($player:Boolean):void
		{
			if ($player == true)
			{
				this.mcP1Shield.visible = false;
				shieldBlockP1.removeShieldSignal.remove(removeShield);
			}
			else
			{
				this.mcP2Shield.visible = false;
				shieldBlockP2.removeShieldSignal.remove(removeShield);
			}
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		//Removes all movieclips on screen end
		public function cleanScreen():void
		{
			this.player1Castle.end();
			this.player2Castle.end();
			trace("After Castle end");
			if (this.shieldBlockP1 != null && this.shieldBlockP1.visible == true)
				this.shieldBlockP1.end();
				
			if (this.shieldBlockP2 != null && this.shieldBlockP2.visible == true)
				this.shieldBlockP2.end();
			trace("aOnScreenObjects.length " + aOnScreenObjects.length);
			for (var i:uint = 0; i < aOnScreenObjects.length; i++)
			{
				trace("i: " + i);
				this.aOnScreenObjects[i].end();
				this.removeChild(aOnScreenObjects[i]);
			}
			
			this.player1Cannon.end();
			this.player2Cannon.end();
			StageRef.stage.removeChild(player1Cannon);
			StageRef.stage.removeChild(player2Cannon);
			
		}
		/* ---------------------------------------------------------------------------------------- */
		
		public function removeObject($object:AbstractGameObject):void
		{
			var objectIndex :int = aOnScreenObjects.indexOf($object);
			
			if ($object.objectType == GameObjectType.TYPE_SHIELD_POWERUP)
				{
					SoundManager.instance.playPowerupGet();
					$object.activate(this);
					
					$object.cleanupSignal.remove(removeObject);
					this.createShield($object.bOwnerIsP1);
						
					this.bPowerupActive = false;
				}
				
				
			if($object.objectType == GameObjectType.TYPE_SPEED_POWERUP)
				{
					SoundManager.instance.playPowerupGet();
					$object.activate(this);
					
					if($object.bOwnerIsP1)
						this.player1Cannon.setSpeedBonus(10);
					else
						this.player2Cannon.setSpeedBonus(10);
						
					$object.cleanupSignal.remove(removeObject);
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
		
		public function createShield($isPlayerOne:Boolean):void
		{
			var shield		:ShieldBlock;
			
			shield = new ShieldBlock($isPlayerOne);
			
			if ($isPlayerOne)
			{		
				shieldBlockP1 = shield;
				this.mcP1Shield.visible = true;
				shieldBlockP1.removeShieldSignal.add(removeShield);
			}
			else
			{		
				shieldBlockP2 = shield;
				this.mcP2Shield.visible = true;
				shieldBlockP2.removeShieldSignal.add(removeShield);
			}
			
			SoundManager.instance.playShieldActivate();
			StageRef.stage.addChild(shield);
			
		}
		
		/* ---------------------------------------------------------------------------------------- */
		//[ EVENT TRIGGERS ]
		/* ---------------------------------------------------------------------------------------- */
		protected function updateScore():void
		{
			this.txtP1Score.text = ScoreManager.instance.nP1Score.toString();
			this.txtP2Score.text = ScoreManager.instance.nP2Score.toString();
		}
		
		protected function quitClicked($e:MouseEvent):void
		{
			trace("Game Screen: Quit Clicked.");
			if(this.p1KingLocked == true && this.p2KingLocked == true)
			{
				SoundManager.instance.playButtonClick();
				this.cleanScreen();
				this.space.clear();
				this.quitClickedSignal.dispatch();
			}
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function pauseClicked($e:MouseEvent):void
		{
			trace("Game Screen: Pause Clicked.");
			SoundManager.instance.playPause();
			
			if (bIsPaused)
			{
				this.bIsPaused = false;
				this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
				
				if (player1Cannon != null && player2Cannon != null) 
				{
					player1Cannon.resumeCannons();
					player2Cannon.resumeCannons();
				}
				SoundManager.instance.playPause();
				SoundManager.instance.resumeSound();
				return;
			}
			
			if (!bIsPaused)
			{
				this.bIsPaused = true;
				this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				
				if (player1Cannon != null && player2Cannon != null) 
				{
					player1Cannon.pauseCannons();
					player2Cannon.pauseCannons();
				}
				
				SoundManager.instance.playPause();
				TweenMax.delayedCall(.5, SoundManager.instance.pauseSound);
				//SoundManager.instance.pauseSound();
				return;
			}
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function spawnPowerup($e:TimerEvent):void
		{
			var choice	:int = 1 + Math.random() * 2;
			var powerup :AbstractPowerup;
		
			
			if (bPowerupActive)
				return;
			
			trace("GameScreen: Spawning Powerup");
			
			
			if (choice == 1)
				powerup = new ShieldPowerup();
			else
				powerup = new SpeedPowerup();
				
			this.bPowerupActive = true;
			this.aOnScreenObjects.push(powerup);
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

