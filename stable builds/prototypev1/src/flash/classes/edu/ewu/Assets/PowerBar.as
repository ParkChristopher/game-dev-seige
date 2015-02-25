package edu.ewu.Assets 
{
	import edu.ewu.Assets.AbstractObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Sam Gronhovd
	 */
	public class PowerBar extends AbstractObject 
	{
		public var bPowerBarFilling		:Boolean;
		
		public var bIsMoving			:Boolean;
		
		public function PowerBar() 
		{
			super();
			this.scaleX = 0;
		}
		
		public override function begin()
		{
			super.begin();
			this.scaleX = 0;
			bPowerBarFilling = true;
			bIsMoving = true;
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		public override function end()
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