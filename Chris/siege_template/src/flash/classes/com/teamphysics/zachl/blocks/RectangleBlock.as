package com.teamphysics.zachl.blocks
{
	
	import com.natejc.input.KeyboardManager;
	import com.natejc.input.KeyCode;
	import com.teamphysics.util.SpaceRef;
	import flash.display.SimpleButton;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Polygon;
	import org.osflash.signals.Signal;
	import com.natejc.utils.StageRef;
	import nape.phys.Material;
	 
	//import nape.shape.
	
	public class RectangleBlock extends BaseBlock
	{
		private var body		:Body;

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
		override public function buildBlock($xPlacement:int, $yPlacement:int):void
		{	
			trace("Overriden method");
			var s:Sprite = new TempTexture();
			s.width = _nWidth
			s.height = _nHeight;
			StageRef.stage.addChild(s);
			var material :Material = new Material(.1,10,2,10);
			
			body = new Body(BodyType.DYNAMIC);
			body.shapes.add(new Polygon(Polygon.box(_nWidth, _nHeight), material));
			body.position.setxy($xPlacement, $yPlacement);

			body.space = SpaceRef.space;
			
			body.userData.graphic = s;	
		}
		
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