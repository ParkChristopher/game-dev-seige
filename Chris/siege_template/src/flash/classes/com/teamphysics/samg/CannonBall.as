package com.teamphysics.samg 
{
	import com.teamphysics.samg.AbstractObject;
	
	/**
	 * ...
	 * @author Sam Gronhovd
	 */
	public class CannonBall extends AbstractObject 
	{
		
		public function CannonBall() 
		{
			super();
			this.mouseChildren = false;
			this.mouseEnabled = false;
		}
		
		public override function begin()
		{
			super.begin();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
			this.visible = false;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
	}

}