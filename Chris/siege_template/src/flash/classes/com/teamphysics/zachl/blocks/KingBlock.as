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
	import org.osflash.signals.*;
	import com.teamphysics.util.CollisionManager;
	import com.teamphysics.util.GameObjectType;
	import com.teamphysics.chrisp.AbstractGameObject; 
	
	//import nape.shape.

	public class KingBlock extends BaseBlock
	{
		private var body		:Body;
		/** A variable to track when the hero has died. */
		private var collisionGroupHolder 	:int;
		private var kingDiedSignal 	:Signal = new Signal();
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Constructs the Token object.
		 */
		public function KingBlock()
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this._nHeight = 50;
			this._nWidth = 25;
			this._sObjectType = GameObjectType.TYPE_KING_BLOCK;
			if(this._sObjectType == GameObjectType.TYPE_KING_BLOCK)
			{
				trace("Correctly set as king");
				trace(this._sObjectType);
				trace("GameObjectType.TYPE_KING_BLOCK: " + GameObjectType.TYPE_KING_BLOCK);
			}
			this.addCollidableType(GameObjectType.TYPE_CANNONBALL);
			this.stop();
		}
		
		override public function buildBlock($xPlacement:int, $yPlacement:int, $collisionType:int):void
		{	
			var s:Sprite = new KingBlockGraphic();
			s.width = _nWidth
			s.height = _nHeight;
			this.addChild(s);
			var material :Material = new Material(.1, 10, 2, 10);
			if ($collisionType == 1)
			{
				bOwnerIsP1 = true;
			}
			else
			{
				bOwnerIsP1 = false;
			}
			
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
			body.space = null;
		}
		
		override public function get getCollisionGroup(): int
		{
			return this.collisionGroupHolder;
		}
		/* ---------------------------------------------------------------------------------------- */
	
		
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