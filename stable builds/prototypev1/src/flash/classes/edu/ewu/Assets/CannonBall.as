package edu.ewu.Assets 
{
	import edu.ewu.Assets.AbstractObject
	
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
		
	}

}