package com.teamphysics.samg 
{
	import com.teamphysics.chrisp.AbstractGameObject;
	import com.teamphysics.util.GameObjectType;
	import com.natejc.utils.StageRef;
	import com.teamphysics.util.CollisionManager;
	import com.teamphysics.util.SpaceRef;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import nape.callbacks.CbType;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Shape;
	import org.osflash.signals.*;
	import com.teamphysics.zachl.blocks.BaseBlock;
	import com.teamphysics.zachl.blocks.LargeSquareBlock;
	import com.teamphysics.zachl.blocks.LongBlock;
	import com.teamphysics.zachl.blocks.RectangleBlock;
	import com.teamphysics.zachl.blocks.SquareBlock;
	import com.teamphysics.zachl.blocks.LargeStoneSquareBlock;
	import com.teamphysics.zachl.blocks.StoneSquareBlock;
	import com.teamphysics.zachl.blocks.HorizontalRectangleBlock;
	import com.teamphysics.zachl.blocks.KingBlock;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.XMLLoader;
	import com.greensock.TweenMax;
	import com.teamphysics.util.SoundManager;
	import com.teamphysics.util.ScoreManager;
	import com.teamphysics.chrisp.powerups.ShieldBlock;
	
	/**
	 * ...
	 * @author Sam Gronhovd
	 */
	public class CannonBall extends AbstractGameObject 
	{
		public var 		gameOverSignal 				:Signal = new Signal();
		
		private var 	physicsBody					:Body;
		
		private var		shape						:Shape;
		
		private var 	material					:Material;
		
		private var 	ballCollisionType			:CbType;
		
		private var 		tMaxLifeSpanTimer			:Timer = new Timer(10000);
		
		private var		hitTimerReset				:Timer = new Timer(5000);
		
		private var 	isSoundReset				:Boolean;
		
		public function CannonBall() 
		{
			super();
			
			this._sObjectType = GameObjectType.TYPE_CANNONBALL;
			this.addCollidableType(GameObjectType.TYPE_BLOCK);
			this.addCollidableType(GameObjectType.TYPE_KING_BLOCK);
			this.addCollidableType(GameObjectType.TYPE_SHIELD_POWERUP);
			this.addCollidableType(GameObjectType.TYPE_SPEED_POWERUP);
			this.addCollidableType(GameObjectType.TYPE_KING_BLOCK);
			this.addCollidableType(GameObjectType.TYPE_SHIELD_WALL);
		}
		
		override public function begin():void
		{
			super.begin();
			tMaxLifeSpanTimer.addEventListener(TimerEvent.TIMER, this.removeCannonBall);
			tMaxLifeSpanTimer.start();
			this.hitTimerReset.addEventListener(TimerEvent.TIMER, this.resetTimer);
			this.hitTimerReset.start();
			this.isSoundReset = true;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
			TweenMax.killAll(false, false, true);
			tMaxLifeSpanTimer.stop();
			this.hitTimerReset.stop();
			this.isSoundReset = false;
			physicsBody = null;
			this.visible = false;
			CollisionManager.instance.remove(this);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function setCbType($cType:CbType)
		{
			this.ballCollisionType = $cType;

		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function setVelocity($vVelocityVec:Vec2)
		{
			physicsBody.velocity = $vVelocityVec;

		}
		
		/* ---------------------------------------------------------------------------------------- */
		

		public function buildBall($xPos:int, $yPos:int, $collisionGroup:int)
		{
			//trace($xPos + ", " + $yPos);
			physicsBody = new Body(BodyType.DYNAMIC, new Vec2($xPos, $yPos));
			material = new Material(0.5, 1, 1, 5);
			shape = new Circle(this.width / 2, null, material);
			
			if ($collisionGroup == 1)
			{
				bOwnerIsP1 = true;
				shape.filter.collisionGroup = 1;//left
				shape.filter.collisionMask = 2;
			}
			else
			{
				bOwnerIsP1 = false;
				shape.filter.collisionGroup = 2;//right
				shape.filter.collisionMask = 1;
			}
			
			physicsBody.shapes.add(shape);
			physicsBody.cbTypes.add(ballCollisionType);
			SpaceRef.space.bodies.add(physicsBody);
			
			physicsBody.userData.graphic = this;
			physicsBody.mass = 1;
			

		}
		
		public function get body():Body
		{
			return this.physicsBody;
		}
		/* ---------------------------------------------------------------------------------------- */
		
		override public function collidedWith($object:AbstractGameObject):void
		{	
			if ($object.objectType == GameObjectType.TYPE_SHIELD_WALL)
			{
				var tempShieldBlock = ShieldBlock($object);
				
				if (tempShieldBlock.bOwnerIsP1 == this.bOwnerIsP1)
					return;
					
				if (tempShieldBlock.bHasBeenCollidedWith)
					return;
				
				if (this.bOwnerIsP1)
					ScoreManager.instance.nP1ShotsLanded += 1;
				else
					ScoreManager.instance.nP2ShotsLanded += 1;
				
				tempShieldBlock.bHasBeenCollidedWith = true;
				tempShieldBlock.nShieldHealth --;	
				
				if (tempShieldBlock.nShieldHealth <= 0)
				{
					tempShieldBlock.end();
					SoundManager.instance.playShieldDown();
					return;
				}
				
				SoundManager.instance.playShieldBounce();
			}
			
			if ($object.objectType == GameObjectType.TYPE_SHIELD_POWERUP)
			{
				$object.bOwnerIsP1 = this.bOwnerIsP1;
				
				if (this.bOwnerIsP1)
					ScoreManager.instance.nP1Score += 150;
				else
					ScoreManager.instance.nP2Score += 150;
				
				$object.end();
				CollisionManager.instance.remove($object);
				$object.cleanupSignal.dispatch($object);
				
			}
			
			if ($object.objectType == GameObjectType.TYPE_SPEED_POWERUP)
			{
				$object.bOwnerIsP1 = this.bOwnerIsP1;
				
				if (this.bOwnerIsP1)
					ScoreManager.instance.nP1Score += 150;
				else
					ScoreManager.instance.nP2Score += 150;
				
				$object.end();
				CollisionManager.instance.remove($object);
				$object.cleanupSignal.dispatch($object);
				
			}
			
			if ($object.objectType == GameObjectType.TYPE_BLOCK)
			{
				var block : BaseBlock = BaseBlock($object);
				
				if($object is RectangleBlock)
				{
					block = RectangleBlock($object);
				}
				else if($object is LargeSquareBlock)
				{
					block = LargeSquareBlock($object);
				}
				else if($object is LongBlock)
				{
					block = LongBlock($object);
				}
				else if($object is SquareBlock)
				{
					block = SquareBlock($object);
				}
				else if($object is LargeStoneSquareBlock)
				{
					block = LargeStoneSquareBlock($object);
				}
				else if($object is StoneSquareBlock)
				{
					block = StoneSquareBlock($object);
				}
				else if($object is HorizontalRectangleBlock)
				{
					block = HorizontalRectangleBlock($object);
				}
				else if($object is KingBlock)
				{
					block = KingBlock($object);
				}
				
				//trace("OBJECT FIRED CANNONBALL OWNER IS: " + bOwnerIsP1 + " Block is : " + block.getCollisionGroup);
				//If cannonball is owned by p1 and the block collisiongroup is 2 or the reverse
				if(this.bOwnerIsP1 == true && block.getCollisionGroup == 2 || this.bOwnerIsP1 == false && block.getCollisionGroup == 1)
				{
					if (!block.bHasBeenCollidedWith)
					{
						//Guessing on score placement here
						if (this.bOwnerIsP1)
						{
							ScoreManager.instance.nP1Score += 50;
							ScoreManager.instance.nP1ShotsLanded += 1;
						}
						else
						{
							ScoreManager.instance.nP2ShotsLanded += 1;
							ScoreManager.instance.nP2Score += 50;
						}
						
						if (isSoundReset)
						{
							SoundManager.instance.playBlockHit();
							this.isSoundReset = false;
						}
						
						var massTimesVelocity:Number = physicsBody.mass * physicsBody.velocity.length;
						
						trace("ball velocity * mass: " + massTimesVelocity);
						
						if (massTimesVelocity > 1000)
						{
							block.health = block.health - (massTimesVelocity / 33);
							trace("block.health: " + block.health);
						}
						else if (massTimesVelocity > 600)
						{
							block.health = block.health - (massTimesVelocity / 29);
							trace("block.health: " + block.health);
						}
						else if (massTimesVelocity > 300)
						{
							block.health = block.health - (massTimesVelocity / 24);
							trace("block.health: " + block.health);
						}
						else 
						{
							block.health = block.health - (massTimesVelocity / 15);
							trace("block.health: " + block.health);
						}
						
						/*if (massTimesVelocity > 850)
						{
							trace("massive damage");


							block.health-= 40;

							
							trace("block.health: " + block.health);
						}
						else if (massTimesVelocity > 450)
						{
							trace("standard damage");

							block.health = block.health - 30;

							//block.health = block.health - 20;

							trace("block.health: " + block.health);
						}
						else if (massTimesVelocity > 200)
						{
							block.health = block.health - 20;
						}
						else if (massTimesVelocity > 100)
						{
							trace("min damage");

							block.health -= 15;

							trace("block.health: " + block.health);
						}*/
						
						//block.health--;
						//trace("block.health: " + block.health);
					
						if(block.health <= 0)
						{
							block.end();
							CollisionManager.instance.remove($object);
							$object.cleanupSignal.dispatch($object);
						}
						//CollisionManager.instance.remove(this);
							
					
						block.bHasBeenCollidedWith = true;
					}
				}
				TweenMax.delayedCall(5, this.removeCannonBall);
				
			}
			if ($object.objectType == GameObjectType.TYPE_KING_BLOCK)
			{
				
				//trace("king is player1?: " + $object.bOwnerIsP1);
					//trace("ball is player1: " + this.bOwnerIsP1);
					//trace(!$object.bOwnerIsP1 && !this.bOwnerIsP1);
					//trace(($object.bOwnerIsP1 && this.bOwnerIsP1) || (!$object.bOwnerIsP1 && !this.bOwnerIsP1));
				if (($object.bOwnerIsP1 && !this.bOwnerIsP1) || (!$object.bOwnerIsP1 && this.bOwnerIsP1))
				{	
					if (this.bOwnerIsP1)
						ScoreManager.instance.sWinner = "P1";
					else
						ScoreManager.instance.sWinner = "P2";
					
					trace("KING WAS HIT");
					//TweenMax.delayedCall(.5, this.endGame);
				
					$object.end();
					CollisionManager.instance.remove($object);
					$object.cleanupSignal.dispatch($object);
					this.cleanupSignal.dispatch(this);
					this.endGame();
				}
				
			}

		}
		/* ---------------------------------------------------------------------------------------- */
		
		public function endGame():void
		{
			SoundManager.instance.playVictory();
			this.gameOverSignal.dispatch();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function resetTimer($e:TimerEvent):void
		{
			this.hitTimerReset.reset();
			this.isSoundReset = true;

		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function removeCannonBall(e:TimerEvent = null):void
		{
			this.cleanupSignal.dispatch(this);
		}
		
		public function cleanCannonBall():void
		{
			this.physicsBody.space = null;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
	}

}