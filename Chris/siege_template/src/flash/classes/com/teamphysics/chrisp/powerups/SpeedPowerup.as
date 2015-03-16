package com.teamphysics.chrisp.powerups
{
	import com.teamphysics.util.GameObjectType;
	import flash.display.MovieClip;

	
	/**
	 * A speed powerup for the next cannonball fired
	 * 
	 * @author Chris Park
	 */
	public class SpeedPowerup extends AbstractPowerup
	{
		public var speedIncrease	:Number = 10;
		
		/* ---------------------------------------------------------------------------------------- */
		
		//Constructs the SpeedPowerup object.
		public function SpeedPowerup()
		{
			super("Speed");
			init();
		}
		
		/* ---------------------------------------------------------------------------------------- */		
		
		override protected function init():void
		{
			super.init();
			this._sObjectType = GameObjectType.TYPE_SPEED_POWERUP;
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
		
		override public function activate($object:MovieClip):void
		{
			super.activate($object);
			
			if (this.bOwnerIsP1)
				$object.mcP1SpeedIndicator.visible = true;
			else
				$object.mcP2SpeedIndicator.visible = true;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
	}
}
