package com.teamphysics.chrisp
{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import org.osflash.signals.Signal;
	
	/**
	 * Base class for all game objects
	 * 
	 * @author Chris Park
	 */
	public class AbstractGameObject extends MovieClip
	{
		/** Game object Hitbox. */
		public var mcHitbox				:MovieClip;
		public var bActive				:Boolean = false;
		
		/** Object type used for collision detection. */
		protected var _sObjectType		:String;
		
		/** Array of objects this object can collide with */
		protected var _aCanCollideWith	:Array = new Array();
		
		/** Signals for this object to be cleaned up*/
		public var cleanupSignal		:Signal = new Signal(AbstractGameObject);
		
		public var bOwnerIsP1			:Boolean;
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the AbstractGameObject object.
		 */
		public function AbstractGameObject()
		{
			super();
			
			this.mouseEnabled	= false;
			this.mouseChildren	= false;
		}
		
		/* ---------------------------------------------------------------------------------------- */		
		
		/**
		 * Initializes this class.
		 */
		public function begin():void
		{
			//parseXML();
			this.visible = true;
		}

		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Ends and stops this class.
		 */
		public function end():void
		{
			this.visible = false;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function activate($object:MovieClip):void
		{
			
		}
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Parses the relevant data from the xml config file for this object.
		 */
		protected function parseXML():void
		{
			//var xConfig:XML = LoaderMax.getContent("xmlConfig");
			//trace(xConfig);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Get or set the collision object type for this object.
		 *
		 * @param	$value	Set object collision type.
		 * @return			Object collision type.
		 */
		public function get objectType ():String
		{
			return _sObjectType;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function set objectType ($value:String):void
		{
			_sObjectType = $value;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Returns the list of object types this object can collide with.
		 */
		public function get collidableTypes():Array
		{
			return _aCanCollideWith;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * returns the hitbox of this object.
		 * 
		 * @return mcHitbox
		 */
		public function get Hitbox():MovieClip
		{
			if (this.mcHitbox != null)
				return this.mcHitbox;
				
			return this;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Adds an object type to this objects possible collisions list.
		 * 
		 * @param	$type String.
		 */
		public function addCollidableType($type:String):void
		{
			if (_aCanCollideWith.indexOf($type) < 0)
				_aCanCollideWith.push($type);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Responses to collision with another object.
		 * 
		 * @param	$object AbstractGameObject
		 */
		public function collidedWith($object:AbstractGameObject):void
		{}
		
		/* ---------------------------------------------------------------------------------------- */
		
		
		
	}
}
