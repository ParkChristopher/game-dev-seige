package com.teamphysics.chrisp.powerups
{
	import com.teamphysics.util.GameObjectType;
	import com.teamphysics.util.CollisionManager;
	import flash.display.MovieClip;

	
	/**
	 * Shield Powerup
	 * 
	 * @author Chris Park
	 */
	public class ShieldPowerup extends AbstractPowerup
	{
		
		/* ---------------------------------------------------------------------------------------- */
		
		//Constructs the ShieldPowerup object.
		public function ShieldPowerup()
		{
			super("Shield");
			
			init();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override protected function init():void
		{
			super.init();
			this._sObjectType = GameObjectType.TYPE_SHIELD_POWERUP;
			
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
			
			//Create a static body in front of castle of cannon owner
			//Remove that body once it is hit by the other cannons fire.
		}
	}
}
