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
	import nape.phys.Material;
	import com.teamphysics.util.CollisionManager;
	import com.teamphysics.util.GameObjectType;
	import com.teamphysics.chrisp.AbstractGameObject;
	import com.natejc.utils.StageRef;
	
	public class BaseBlock extends AbstractGameObject
	{
		
		protected var _nBlockHealth	:int = 100;		
		protected var _nHeight		:int;
		protected var _nWidth		:int;
		protected var tempSprite	:Sprite;
		
		public var bHasBeenCollidedWith	:Boolean;
		
		//Bodies
		private var body		:Body = new Body(BodyType.DYNAMIC);
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Constructs the BaseCollectible object.
		 */
		public function BaseBlock()
		{
			super();
			//this._sObjectType = GameObjectType.TYPE_BLOCK;
			//this.addCollidableType(GameObjectType.TYPE_CANNONBALL);
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
		
		public function setCollisionType(collisionType:int)
		{
			
		}
		
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Loads the parameters from the XML file to the local variables in this class
		 */
		protected static function parseXML():void
		{
			//var xConfig:XML = LoaderMax.getContent("config.xml");
			//_increaseValue = int(xConfig.gameObjects.scoringIncrease);
		}
		
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Basic get for _nValue
		 */
		public function get health(): int
		{
			return  _nBlockHealth;
		}
		public function set health($hp:int):void
		{
			_nBlockHealth = $hp;
		}
		public function get blockBody(): Body
		{
			return  body;
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
		{
			
		}
	}
}