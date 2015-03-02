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
	import com.teamphysics.util.CollisionManager;
	import com.teamphysics.util.GameObjectType;
	import com.teamphysics.chrisp.AbstractGameObject; 
	//import nape.shape.
	
	public class LongBlock extends BaseBlock
	{
		private var body		:Body;

		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Constructs the Token object.
		 */
		public function LongBlock()
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this.stop();
			this._sObjectType = GameObjectType.TYPE_BLOCK;
			this.addCollidableType(GameObjectType.TYPE_CANNONBALL);
			this._nHeight = 15;
			this._nWidth = 250;
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
		override public function buildBlock($xPlacement:int, $yPlacement:int, $collisionType:int):void
		{	
			var s:Sprite = new TempTexture();
			s.width = _nWidth
			s.height = _nHeight;
			this.addChild(s);
			var material :Material = new Material(.1,10,2,10);
			
			body = new Body(BodyType.DYNAMIC);
			var polygon:Polygon = new Polygon(Polygon.box(_nWidth, _nHeight), material);
			polygon.filter.collisionGroup = $collisionType;
			body.shapes.add(polygon);
			body.position.setxy($xPlacement, $yPlacement);

			body.space = SpaceRef.space;
			
			body.userData.graphic = s;	
		}
		
		override public function end():void
		{
			super.end();
			body.space = null;
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