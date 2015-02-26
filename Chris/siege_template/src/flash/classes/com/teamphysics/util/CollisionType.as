package com.teamphysics.util 
{
	/**
	 * ...
	 * @author Sam Gronhovd
	 */
	public class CollisionType 
	{
		/** Collision code for the the player character */
		public static const TYPE_HERO						:String = "heroObject";
		
		/** Collision code for the enemy objects */
		public static const TYPE_ENEMY						:String = "enemyObject";
			
		/** Collision code for collectible objects */
		public static const TYPE_COLLECTIBLE				:String = "collectibleObject";
		
		/** Collision code for bomb collectibles */
		public static const TYPE_COLLECTIBLE_BOMB			:String = "collectibleBombObject";
		
		/** Collision code for invincibility Collectibles */
		public static const TYPE_COLLECTIBLE_INVINCIBILITY	:String = "collectibleInvincibilityObject";
		
		/** Collision code for the explosion objects */
		public static const TYPE_EXPLOSION					:String = "explosionObject";
		
		public function CollisionType() 
		{
			throw new Error("StaticClassExample is a static class and should not be instantiated.");
		}
		
	}

}