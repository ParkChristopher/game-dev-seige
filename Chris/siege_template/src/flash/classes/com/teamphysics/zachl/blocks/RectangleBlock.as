package com.teamphysics.zachl.blocks
{
	
	import com.teamphysics.util.GameObjectType;
	import com.teamphysics.util.SpaceRef;
	import flash.display.Sprite;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Polygon;
	
	public class RectangleBlock extends BaseBlock
	{
		private var collisionGroupHolder 	:int;

		/* ---------------------------------------------------------------------------------------- */		
		
		/**
		 * Constructs the Token object.
		 */
		public function RectangleBlock()
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this.stop();
			this._sObjectType = GameObjectType.TYPE_BLOCK;
			this.addCollidableType(GameObjectType.TYPE_CANNONBALL);
			this._nHeight = 100;
			this._nWidth = 25;
		}
		
		/* ---------------------------------------------------------------------------------------- */	
		
		/**
		 * Calls the CollectibleManager to create a Vector of collectibles 
		 * and then randomly places them using the pickRandomStartingLocation function
		 */
		override public function begin() :void
		{
			super.begin();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function buildBlock($xPlacement:int, $yPlacement:int, $collisionType:int):void
		{	
			var s:Sprite = new RectangleBlockGraphic();
			s.width = _nWidth
			s.height = _nHeight;
			tempSprite = s;
			this.addChild(s);
			var material :Material = new Material(0,1.5,1,1.5);
			
			body = new Body(BodyType.DYNAMIC);
			var polygon:Polygon = new Polygon(Polygon.box(_nWidth, _nHeight), material);
			polygon.filter.collisionGroup = $collisionType;
			this.collisionGroupHolder = polygon.filter.collisionGroup;
			body.shapes.add(polygon);
			body.position.setxy($xPlacement, $yPlacement);
			body.space = SpaceRef.space;
			body.userData.graphic = s;	
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
			super.end();
			body.space = null;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function get getCollisionGroup(): int
		{
			return this.collisionGroupHolder;
		}
		
		/* ---------------------------------------------------------------------------------------- */	
		
		/**
		 * Calls CollectibleManagers destroy function
		 */
		override public function destroy() :void
		{
			super.destroy();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
	}
}