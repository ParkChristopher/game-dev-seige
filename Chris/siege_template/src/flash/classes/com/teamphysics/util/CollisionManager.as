package com.teamphysics.util
{
	import com.teamphysics.chrisp.AbstractGameObject;
	import com.natejc.utils.StageRef;
	import flash.events.Event;

	/**
	 * Manages collisions between game objects.
	 * 
	 * @author Chris Park
	 */
	public class CollisionManager
	{
		/** Stores a reference to the singleton instance. */  
		private static const _instance	:CollisionManager = new CollisionManager( SingletonLock );
		/** Lists of objects checked for collision. */
		protected var _aTrackedObjects	:Array = new Array();
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the CollisionManager object.
		 * 
		 * @param	lock	This class is a singleton and should not be externally instantiated.
		 */
		public function CollisionManager($lock:Class)
		{
			if ($lock != SingletonLock)
				throw new Error("CollisionManager is a singleton and should not be instantiated. Use CollisionManager.instance instead");
		}
		
		/* ---------------------------------------------------------------------------------------- */
	
		/**
		 * Returns an instance to this class.
		 *
		 * @return		An instance to this class.
		 */
		public static function get instance():CollisionManager
		{		
			return _instance;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Resets the collision manager.
		 */
		public function reset():void
		{
			this._aTrackedObjects = new Array();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Starts the collision manager.
		 */
		public function begin():void
		{
			StageRef.stage.addEventListener(Event.ENTER_FRAME, this.testAllCollisions);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Ends the collision manager.
		 */
		public function end():void
		{
			StageRef.stage.removeEventListener(Event.ENTER_FRAME, this.testAllCollisions);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Adds an object to the tracked collisions
		 * 
		 * @param	$object	AbstractGameObject.
		 */
		public function add($object:AbstractGameObject):void
		{
			var aObjectsOfSameType :Array = this._aTrackedObjects[$object.objectType];
			
			if (aObjectsOfSameType == null)
				aObjectsOfSameType = new Array();
			
			aObjectsOfSameType.push($object);
			this._aTrackedObjects[$object.objectType] = aObjectsOfSameType;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Removes an object from the tracked collisions
		 * 
		 * @param	$object AbstractGameObject.
		 */
		public function remove($object:AbstractGameObject):void
		{
			var aObjectsOfSameType :Array = this._aTrackedObjects[$object.objectType];
			
			if (aObjectsOfSameType == null)
				return;
			
			var nObjectRemoveIndex :int = aObjectsOfSameType.indexOf($object);
			
			if (nObjectRemoveIndex >= 0)
				aObjectsOfSameType.splice(nObjectRemoveIndex, 1);
			
			this._aTrackedObjects[$object.objectType] = aObjectsOfSameType;
			
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Tests collision for all tracked objects
		 * 
		 * @param	$e Stage instance event.
		 */
		public function testAllCollisions($e:Event):void
		{
			var aObjectsOfSameType	:Array;
			
			for (var sObjectType:String in this._aTrackedObjects)
			{
				aObjectsOfSameType = this._aTrackedObjects[sObjectType];
				
				if (aObjectsOfSameType != null)
				{
					for (var i:uint = 0; i < aObjectsOfSameType.length; i++)
						this.testSingleCollision(aObjectsOfSameType[i]);
					
				}
			}
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Tests collision for a single object
		 * 
		 * @param	$object AbstractGameObject.
		 */
		public function testSingleCollision($object:AbstractGameObject):void
		{
			var aCollidesWithTypes	:Array = $object.collidableTypes;
			var aCollidesAgainst	:Array;
			var sTypeIndex			:String;
			var mcObjectInstance	:AbstractGameObject;
			
			for (var i:uint = 0; i < aCollidesWithTypes.length; i++)
			{
				sTypeIndex = aCollidesWithTypes[i];
				aCollidesAgainst = this._aTrackedObjects[sTypeIndex];
				
				if (aCollidesAgainst != null)
				{
					for (var j:uint = 0; j < aCollidesAgainst.length; j++)
					{
						mcObjectInstance = aCollidesAgainst[j];
						
						if (mcObjectInstance == null)
							break;
							
						if ($object.Hitbox.hitTestObject(mcObjectInstance.Hitbox))
							$object.collidedWith(mcObjectInstance);
						
					}
				}
			}
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
	}
}

class SingletonLock {} // Do nothing, this is just to prevent external instantiation.

