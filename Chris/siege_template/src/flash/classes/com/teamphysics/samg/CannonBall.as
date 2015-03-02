package com.teamphysics.samg 
{
	import com.teamphysics.chrisp.AbstractGameObject;
	import com.teamphysics.util.GameObjectType;
	import com.natejc.utils.StageRef;
	import com.teamphysics.util.CollisionManager;
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
			
			this.visible = false;
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
				
				trace("block was hit");
				
				var block : BaseBlock = BaseBlock($object);
				
				trace(block.health);
				block.health--;
				trace(block.health);
				
				if(block.health == 0)
				{
					block.end();
					CollisionManager.instance.remove($object);
					$object.cleanupSignal.dispatch($object);
				}
				CollisionManager.instance.remove(this);
				TweenMax.delayedCall(1.5, this.removeCannonBall);				
				
			}
			if ($object.objectType == GameObjectType.TYPE_KING_BLOCK)
			{
				trace("KING WAS HIT");
				this.gameOverSignal.dispatch();
				
				$object.end();
				CollisionManager.instance.remove($object);
				$object.cleanupSignal.dispatch($object);
				
			}
		}
		
		public function removeCannonBall():void
		{
			this.cleanupSignal.dispatch(this);
		}
		/* ---------------------------------------------------------------------------------------- */
		
	}

}