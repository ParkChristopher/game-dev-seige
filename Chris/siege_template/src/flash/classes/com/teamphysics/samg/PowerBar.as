package com.teamphysics.samg 
{
	import com.teamphysics.chrisp.AbstractGameObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Sam Gronhovd
	 */
	public class PowerBar extends AbstractGameObject 
	{
		public var bPowerBarFilling		:Boolean;
		
		public var bIsMoving			:Boolean;
		
		public function PowerBar() 
		{
			super();
			this.scaleX = 0;
		}
		
		override public function begin():void
		{
			super.begin();
			this.scaleX = 0;
			bPowerBarFilling = true;
			bIsMoving = true;
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		public override function end():void
		{
			super.end();
			this.scaleX = 0;
		}
		
		public function stopMoving()
		{
			this.bIsMoving = false;
		}
		
		private function enterFrameHandler(e:Event)
		{
			if (this.bIsMoving)
			{
				if (this.bPowerBarFilling && this.scaleX < 1.0)
				{
					this.scaleX += .03;
				}
				else if (this.bPowerBarFilling && this.scaleX >= 1.0)
				{
					this.bPowerBarFilling = false;
				}
				else if (!this.bPowerBarFilling && this.scaleX > 0)
				{
					this.scaleX -= .03;
				}
				else if (!this.bPowerBarFilling && this.scaleX <= 0)
				{
					this.bPowerBarFilling = true;
				}
			}
		}
		
	}

}