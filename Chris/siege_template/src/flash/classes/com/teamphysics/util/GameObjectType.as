package com.teamphysics.util
{
	
	/**
	 * Defines the object types for collision.
	 * 
	 * @author Chris Park
	 */
	public class GameObjectType
	{
		/** Strings that represent types of objects to be used in collision. */
		public static const TYPE_BLOCK				:String = "BLOCK";
		public static const TYPE_SHIELD_POWERUP		:String = "SHIELD";
		public static const TYPE_SPEED_POWERUP		:String = "SPEED";
		public static const TYPE_CANNONBALL			:String = "CANNONBALL";
		public static const TYPE_KING_BLOCK			:String = "KING";

		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the GameObjectTypes object.
		 */
		public function GameObjectTypes()
		{}
		
		/* ---------------------------------------------------------------------------------------- */		
		
	}
}
