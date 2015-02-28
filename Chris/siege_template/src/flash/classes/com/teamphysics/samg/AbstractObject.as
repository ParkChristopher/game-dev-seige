package com.teamphysics.samg
{
	import com.teamphysics.util.CollisionManager;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import org.osflash.signals.Signal;
	
	
	/**
	 * ...
	 * @author Sam Gronhovd
	 */
	public class  AbstractObject extends MovieClip
	{
		/** used for collision detection for all game objects */
		public var mcHitBox				:Sprite; //throwing wierd errors when attempting to call from subclasses error 1152
		
		/** the type of Object, used in Collision Manager */
		public var sObjectType			:String;
		
		/** the types of objects this object can collide with */
		protected var _aCollidesWithType	:Array = new Array();
		
		/** signal that is dispatched when the object is done*/
		public var objectFinishedSignal		:Signal = new Signal();
		
		/**
		 * Creates an AbstractObject Object, should never actually be instantiated 
		 *
		 */
		public function AbstractObject()
		{
			this.visible = false;
			stop();
			mcHitBox = new Sprite();
			mcHitBox.width = 56;
			mcHitBox.height = 33;
			mcHitBox.visible = false;
			
		}
		
		/* Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­ */
		
		/**
		 * makes the object visible, and starts any animations
		 *
		 */
		public function begin()
		{
			CollisionManager.instance.add(this);
			this.visible = true;
			play();
		}
		
		/* Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­ */
		
		/**
		 * makes the object not visible and stops any animations
		 *
		 */
		public function end():void
		{
			objectFinishedSignal.dispatch(this);
			CollisionManager.instance.remove(this);
			this.visible = false;
			stop();
		}
		
		/* Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­ */
		
		/**
		 * move function to be overriden as needed by concrete objects
		 *
		 */
		public function move()
		{
			
		}
		
		/* Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­ */
		
		/**
		 * makes the object visible
		 *
		 */
		public function show()
		{
			this.visible = true;
			
		}
		
		/* Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­ */
		
		/**
		 * returns the array of Strings that designate the objects that can collide with this object
		 * 
		 * @return Array of Strings with the types of Objects to collide with
		 *
		 */
		public function getCollidesWithTypes():Array
		{
			return _aCollidesWithType;
		
		}
		
		/* Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­ */
		
		/**
		 * collision function to be overriden as needed by concrete objects
		 *
		 */
		public  function collidedWith($oGameObject:AbstractObject)
		{
			
		}
		
		/* Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­Â­ */
	}
	
}