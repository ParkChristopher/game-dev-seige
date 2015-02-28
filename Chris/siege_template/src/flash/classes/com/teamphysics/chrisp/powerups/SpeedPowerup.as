package com.teamphysics.chrisp.powerups
{
	import flash.display.Sprite;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	import nape.shape.Polygon;

	
	/**
	 * A speed powerup for the next cannonball fired
	 * 
	 * @author Chris Park
	 */
	public class SpeedPowerup extends AbstractPowerup
	{
		public var speedIncrease	:Number = 10;
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the SpeedPowerup object.
		 */
		public function SpeedPowerup()
		{
			super("Speed");
			
			init();
		}
		
		/* ---------------------------------------------------------------------------------------- */		
		
		override public function begin():void
		{
			super.begin();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
			super.end();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function activate():void
		{
			super.activate();
			
			//Have a variable in Cannon for speed multiplier
			//set that speed multiplier to this objects contained speed value
			
		}
		/* ---------------------------------------------------------------------------------------- */
		
	}
}

