package com.teamphysics.zachl.blocks
{
	import com.teamphysics.chrisp.AbstractGameObject;
	import com.teamphysics.util.SpaceRef;
	import flash.display.Sprite;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Polygon;
	
	public class BaseBlock extends AbstractGameObject
	{
		
		protected var _nBlockHealth		:int;		
		protected var _nHeight			:int;
		protected var _nWidth			:int;
		protected var tempSprite		:Sprite;
		protected var collisionGroup	:int = 0;
		
		//Bodies
		protected var body		:Body = new Body(BodyType.DYNAMIC);
		
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Constructs the BaseCollectible object.
		 */
		public function BaseBlock()
		{
			super();
			
			_nBlockHealth = 100;
			health = 100;
			parseXML();
			this.stop();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		override public function begin() :void
		{
			this.play();
			this.visible = true;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
			body.userData.graphic = null;
			body.space = null;
			
			while (this.numChildren > 0)
				this.removeChildAt(0);
				
			SpaceRef.space.bodies.remove(body);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function buildBlock($xPlacement:int, $yPlacement:int, $collisionType:int):void
		{	
			
			var s:Sprite = new TempTexture();
			tempSprite = s;
			s.width = _nWidth
			s.height = _nHeight;
			this.addChild(s);
			var material :Material = new Material(0,10,2,10);
			body.shapes.add((new Polygon(Polygon.box(_nWidth, _nHeight), material)));
			body.position.setxy($xPlacement, $yPlacement);
			body.space = SpaceRef.space;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function setCollisionType(collisionType:int)
		{}
		
		/* ---------------------------------------------------------------------------------------- */			
		
		/**
		 * Loads the parameters from the XML file to the local variables in this class
		 */
		protected static function parseXML():void
		{}
		
		/* ---------------------------------------------------------------------------------------- */		
		
		/**
		 * Basic get for _nValue
		 */
		public function get health(): int
		{
			return  _nBlockHealth;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function set health($hp:int):void
		{
			_nBlockHealth = $hp;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function get blockBody(): Body
		{
			return  body;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function get getCollisionGroup(): int
		{
			return  collisionGroup;
		}
		
		/* ---------------------------------------------------------------------------------------- */				
		
		/**
		 * Basic set for _nValue
		 */
		public function set healthValue($value:int): void
		{
			 _nBlockHealth = $value;
		}		
		/* ---------------------------------------------------------------------------------------- */				
		
		/**
		 * Destroys any collectible that calls the function and it's children.
		 */
		public function destroy() :void
		{}
		
		/* ---------------------------------------------------------------------------------------- */
	}
}