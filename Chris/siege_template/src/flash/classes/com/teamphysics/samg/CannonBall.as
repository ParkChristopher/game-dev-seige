﻿package com.teamphysics.samg 
{
	import com.teamphysics.chrisp.AbstractGameObject;
	import com.teamphysics.util.GameObjectType;
	import com.natejc.utils.StageRef;
	import com.teamphysics.util.CollisionManager;
	import com.teamphysics.util.SpaceRef;
	import nape.callbacks.CbType;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import nape.shape.Shape;
	import org.osflash.signals.*;
	import com.teamphysics.zachl.blocks.BaseBlock;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.XMLLoader;
	import com.greensock.TweenMax; 
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
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
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
			trace($xPos + ", " + $yPos);
			physicsBody = new Body(BodyType.DYNAMIC, new Vec2($xPos, $yPos));
			material = new Material(0.5, 1, 1, 5);
			shape = new Circle(this.width / 2, null, material);
			
			if ($collisionGroup == 1)
			{
				shape.filter.collisionGroup = 1;//left
				shape.filter.collisionMask = 2;
			}
			else
			{
				shape.filter.collisionGroup = 2;//right
				shape.filter.collisionMask = 1;
			}
			
			physicsBody.shapes.add(shape);
			physicsBody.cbTypes.add(ballCollisionType);
			SpaceRef.space.bodies.add(physicsBody);
			
			physicsBody.userData.graphic = this;
			physicsBody.mass = 1;
			

		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function collidedWith($object:AbstractGameObject):void
		{
			trace($object.objectType);
			
			if ($object.objectType == GameObjectType.TYPE_SHIELD_WALL)
			{
				//if this wall belongs to owner of cannonball do nothing
				if ($object.bOwnerIsP1 == this.bOwnerIsP1)
					return;
				
				//removal from collision happens in end for this object
				$object.end();
			}
			
			if ($object.objectType == GameObjectType.TYPE_SHIELD_POWERUP)
			{
				$object.bOwnerIsP1 = this.bOwnerIsP1;
				
				$object.end();
				CollisionManager.instance.remove($object);
				$object.cleanupSignal.dispatch($object);
				
			}
			
			if ($object.objectType == GameObjectType.TYPE_SPEED_POWERUP)
			{
				$object.bOwnerIsP1 = this.bOwnerIsP1;
				
				$object.end();
				CollisionManager.instance.remove($object);
				$object.cleanupSignal.dispatch($object);
				
			}
			
			if ($object.objectType == GameObjectType.TYPE_BLOCK)
			{
				
				//trace("block was hit");
				
				var block : BaseBlock = BaseBlock($object);
				
				if (!block.bHasBeenCollidedWith)
				{
					trace("ball velocity: " + physicsBody.velocity.length);
					if (physicsBody.velocity.length > 350)
					{
						trace(block.health);
						block.health--;
						trace(block.health);
					}
				
					if(block.health == 0)
					{
						block.end();
						CollisionManager.instance.remove($object);
						$object.cleanupSignal.dispatch($object);
					}
					//CollisionManager.instance.remove(this);
						
				
					block.bHasBeenCollidedWith = true;
				}
				TweenMax.delayedCall(1.5, this.removeCannonBall);
				
			}
			if ($object.objectType == GameObjectType.TYPE_KING_BLOCK)
			{
				trace("KING WAS HIT");
				this.gameOverSignal.dispatch();
				
				$object.end();
				CollisionManager.instance.remove($object);
				$object.cleanupSignal.dispatch($object);
				this.cleanupSignal.dispatch(this);
				
			}
		}
		
		public function removeCannonBall():void
		{
			this.cleanupSignal.dispatch(this);
		}
		/* ---------------------------------------------------------------------------------------- */
		
	}

}