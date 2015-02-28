package com.teamphysics.zachl.blocks
{
	
	import com.teamphysics.util.SpaceRef;
	import flash.display.Sprite;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	
	 
	//import nape.shape.
	
	public class RectangleBlock extends BaseBlock
	{
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Constructs the Token object.
		 */
		public function RectangleBlock()
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this.stop();
			this._nHeight = 100;
			this._nWidth = 25;
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
		
		override public function end():void
		{
			super.end();
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