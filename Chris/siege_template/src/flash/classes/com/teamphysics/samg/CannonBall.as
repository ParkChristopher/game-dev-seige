package com.teamphysics.samg 
{
	import com.teamphysics.chrisp.AbstractGameObject;
	
	/**
	 * ...
	 * @author Sam Gronhovd
	 */
	public class CannonBall extends AbstractGameObject 
	{
		
		public function CannonBall() 
		{
			super();
			this.mouseChildren = false;
			this.mouseEnabled = false;
		}
		
		override public function begin():void
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