package com.teamphysics.zachl.blocks
{
	
	import com.teamphysics.util.SpaceRef;
	import flash.display.Sprite;
	import nape.callbacks.*;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	
	 
	//import nape.shape.

	public class KingBlock extends BaseBlock
	{
		protected var nBlockWidth			: int = 50;
		protected var nBlockHeight			: int = 75;
		public static var kingBody			:Body = new Body(BodyType.DYNAMIC);
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Constructs the Token object.
		 */
		public function KingBlock()
		{
			//var body:Body = new Body(BodyType.DYNAMIC);
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this._nHeight = 75;
			this._nWidth = 50;
			this.stop();
		}
		
		public override function buildBlock($xPlacement:int, $yPlacement:int):void
		{		
			var s:Sprite = new TempTexture();
			
			addChild(s);
		
			//var body:Body = new Body(BodyType.DYNAMIC);
			kingBody.shapes.add(new Polygon(Polygon.box(nBlockWidth, nBlockHeight)));
			kingBody.position.setxy($xPlacement, $yPlacement);

			kingBody.space = SpaceRef.space;
			
			kingBody.userData.graphic = s;		
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
		
		public function get body():Body
		{
			return kingBody;
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