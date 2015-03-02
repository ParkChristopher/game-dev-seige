﻿package com.teamphysics.samg 
{
	import com.teamphysics.chrisp.AbstractGameObject;
	import com.teamphysics.util.GameObjectType;
	import com.natejc.utils.StageRef;
	import com.teamphysics.util.CollisionManager;
	import org.osflash.signals.*;
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
			
			/*this._sObjectType = GameObjectType.TYPE_CANNONBALL;
			this.addCollidableType(GameObjectType.TYPE_BLOCK);
			this.addCollidableType(GameObjectType.TYPE_KING_BLOCK);*/
			this.addCollidableType(GameObjectType.TYPE_SHIELD_POWERUP);
			this.addCollidableType(GameObjectType.TYPE_SPEED_POWERUP);
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
			if ($object.objectType == GameObjectType.TYPE_SHIELD_POWERUP)
			{
				trace("--is a shield");
				//set up shield
				
			}
			
			if ($object.objectType == GameObjectType.TYPE_SPEED_POWERUP)
			{
				trace("--is a speed boost");
				//set up speed
				
			}
			
			if ($object.objectType == GameObjectType.TYPE_BLOCK)
			{
				trace("block was hit");
				//set up speed
				
			}
			if ($object.objectType == GameObjectType.TYPE_KING_BLOCK)
			{
				trace("KING WAS HIT");
				this.gameOverSignal.dispatch();
				
			}
			$object.end();
			CollisionManager.instance.remove($object);
			$object.cleanupSignal.dispatch($object);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
	}

}