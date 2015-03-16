package com.teamphysics.samg 
{
	import com.teamphysics.chrisp.AbstractGameObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Sam Gronhovd
	 */
	public class PowerBar extends AbstractGameObject 
	{
		public var bPowerBarFilling		:Boolean;
		public var bIsMoving			:Boolean;
		public var mcMask				:MovieClip;
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function PowerBar() 
		{
			super();
			this.scaleX = 0;
			mcMask.visible = false;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function begin():void
		{
			super.begin();
			mcMask.scaleX = .5;
			this.mask = mcMask;
			this.scaleX = 1;
			bPowerBarFilling = true;
			bIsMoving = true;
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public override function end():void
		{
			super.end();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function stopMoving()
		{
			this.bIsMoving = false;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		private function enterFrameHandler(e:Event)
		{
			if (this.bIsMoving)
			{
				if (this.bPowerBarFilling && this.mcMask.scaleX < 1.0)
				{
					this.mcMask.scaleX += .02;
				}
				else if (this.bPowerBarFilling && this.mcMask.scaleX >= 1.0)
				{
					this.bPowerBarFilling = false;
				}
				else if (!this.bPowerBarFilling && this.mcMask.scaleX > 0)
				{
					this.mcMask.scaleX -= .02;
				}
				else if (!this.bPowerBarFilling && this.mcMask.scaleX <= 0)
				{
					this.bPowerBarFilling = true;
				}
			}
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
	}
}