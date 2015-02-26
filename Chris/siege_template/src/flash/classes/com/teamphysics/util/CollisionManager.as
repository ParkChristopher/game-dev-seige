package com.teamphysics.util
{
	import com.teamphysics.samg.AbstractObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.teamphysics.util.CollisionType;


	/**
	 * 
	 * 
	 * @author Sam Gronhovd
	 */
	public class CollisionManager extends MovieClip
	{
		/** Stores a reference to the singleton instance. */  
		private static const _instance	:CollisionManager = new CollisionManager( SingletonLock );
		
		private var _aObjectsBeingTracked:Array = new Array();
		
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
		 * Sets the Manager back to a blank state
		 *
		 */
		public function reset()
		{
			_aObjectsBeingTracked = new Array();//this seems gross...
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Starts checking collisions
		 *
		 */
		public function begin()
		{
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			//_aObjectsBeingTracked[CollisionType.TYPE_COLLECTIBLE] = new Array();
			//_aObjectsBeingTracked[CollisionType.TYPE_ENEMY] = new Array();
			//_aObjectsBeingTracked[CollisionType.TYPE_HERO] = new Array();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Stops Checking collisions
		 *
		 */
		public function end()
		{
			this.reset();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * adds an item to check collisions for
		 *
		 * @param The object to be added to the manager
		 */
		public function add($oGameObject:AbstractObject)
		{
			var aObjectsOfSameType:Array = _aObjectsBeingTracked[$oGameObject.sObjectType];
			
			if (!aObjectsOfSameType)
			{
				aObjectsOfSameType = new Array();
			}
			
			aObjectsOfSameType.push($oGameObject);
			_aObjectsBeingTracked[$oGameObject.sObjectType] = aObjectsOfSameType;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Sets the Manager back to a blank state
		 *
		 * @param The object to be removed from the manager
		 * 
		 * @return boolean stating whether the item was removed successfully or not
		 */
		public function remove($oGameObject:AbstractObject):Boolean
		{
			var aObjectsOfSameType:Array = _aObjectsBeingTracked[$oGameObject.sObjectType];
			
			if (!aObjectsOfSameType)
			{
				aObjectsOfSameType = new Array();
			}
			
			var nObjectsToBeRemovedIndex:int = aObjectsOfSameType.indexOf($oGameObject);
			if (nObjectsToBeRemovedIndex >= 0)
			{
				aObjectsOfSameType.splice(nObjectsToBeRemovedIndex, 1);
				_aObjectsBeingTracked[$oGameObject.sObjectType] = aObjectsOfSameType;
				return true;
			
				}
			return false;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Gets an array of all of the objects of the given type
		 * 
		 * @param The type of object to get all the instances of
		 * 
		 * @return the array of all of the objects of the given type
		 *
		 */
		private function getAddedObjectsOfType($sType:String):Array
		{
			return _aObjectsBeingTracked[$sType];
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * happens every frame
		 * 
		 * 
		 */
		public function enterFrameHandler(e:Event)
		{
			testAllCollisions();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Tests the collisions of all of the objects in the manager
		 * 
		 * 
		 */
		public function testAllCollisions()
		{
			var aObjectsOfSameType:Array;
			//trace("_aObjectsBeingTracked[CollisionType.TYPE_COLLECTIBLE].length: " + _aObjectsBeingTracked[CollisionType.TYPE_COLLECTIBLE].length);
			for (var sObjectType:String in _aObjectsBeingTracked)
			{
				aObjectsOfSameType = _aObjectsBeingTracked[sObjectType];
				if (aObjectsOfSameType)
				{
					for (var i:int = 0; i < aObjectsOfSameType.length; i++)
					{
						this.testCollisionsSingleObject(aObjectsOfSameType[i]);
					}
				}
			}
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Sets the Manager back to a blank state
		 *
		 */
		private function testCollisionsSingleObject($oGameObject:AbstractObject)//TODO throwing null object error
		{
			var aCollidesWithTypes:Array = $oGameObject.getCollidesWithTypes();
			var aObjectsToTestAgainst:Array;
			var sCollidesWithTypeIndex:String;
			var mcObjectToTestAgainst:AbstractObject;
			for (var i:int = 0; i < aCollidesWithTypes.length; i++)
			{
				sCollidesWithTypeIndex = aCollidesWithTypes[i];
				if (!_aObjectsBeingTracked[sCollidesWithTypeIndex])
				{
					_aObjectsBeingTracked[sCollidesWithTypeIndex] = new Array();
				}
				aObjectsToTestAgainst = _aObjectsBeingTracked[sCollidesWithTypeIndex];
				//trace("aObjectsToTestAgainst.length: " + aObjectsToTestAgainst.length);
				for (var j:int = 0; j < aObjectsToTestAgainst.length; j++)
				{
					mcObjectToTestAgainst = aObjectsToTestAgainst[j];
					if ($oGameObject.mcHitBox.hitTestObject(mcObjectToTestAgainst.mcHitBox))//Null reference error on this line
					{
						$oGameObject.collidedWith(mcObjectToTestAgainst);
					}
				}
			}
		}
		
		/* ---------------------------------------------------------------------------------------- */

	}
}



class SingletonLock {} // Do nothing, this is just to prevent external instantiation.

