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
			
			//NOTE These are set up the same as speed indicators but are not
			//becoming visible
			
			if (this.bOwnerIsP1)
			{
				$object.mcP1ShieldIndicator.visible = true;
			}
			else
			{
				$object.mcP2ShieldIndicator.visible = true;
			}
			
		}
	}
}
