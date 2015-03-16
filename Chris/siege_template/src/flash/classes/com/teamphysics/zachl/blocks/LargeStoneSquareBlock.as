package com.teamphysics.zachl.blocks
{
	
	import com.teamphysics.util.GameObjectType;
	import com.teamphysics.util.SpaceRef;
	import com.teamphysics.zachl.blocks.BaseBlock;
	import flash.display.Sprite;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Polygon;
	
	public class LargeStoneSquareBlock extends BaseBlock
	{
		private var collisionGroupHolder 	:int;

		/* ---------------------------------------------------------------------------------------- */	
		
		/**
		 * Constructs the Token object.
		 */
		public function LargeStoneSquareBlock()
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this._sObjectType = GameObjectType.TYPE_BLOCK;
			this.addCollidableType(GameObjectType.TYPE_CANNONBALL);
			this.stop();
			this._nHeight = this._nWidth = 50;
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
			var s:Sprite = new LargeStoneSquareBlockGraphic();
			s.width = _nWidth
			s.height = _nHeight;
			this.addChild(s);
			var material :Material = new Material(.1,10,2,10);
			
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