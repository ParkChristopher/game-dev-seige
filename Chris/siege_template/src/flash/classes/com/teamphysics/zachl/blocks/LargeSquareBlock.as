package com.teamphysics.zachl.blocks
{
	
	
	import com.teamphysics.util.SpaceRef;
	import flash.display.Sprite;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	
	 
	//import nape.shape.
	
	public class LargeSquareBlock extends BaseBlock
	{
		
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Constructs the Token object.
		 */
		public function LargeSquareBlock()
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this.stop();
			this._nHeight = this._nWidth = 50;
		}
		
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Calls the CollectibleManager to create a Vector of collectibles and then randomly places them using the pickRandomStartingLocation function
		 */
		override public function begin() :void
		{
			super.begin();
		}
		

		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Calls CollectibleManagers destroy function
		 */
		override public function destroy() :void
		{
			super.destroy();
		}
	}
}