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

	
	public class BaseBlock extends MovieClip
	{
		
		private var _nBlockHealth	:int = 1;		
		protected var _nHeight		:int;
		protected var _nWidth		:int;
		
		//Bodies
		private var body		:Body = new Body(BodyType.DYNAMIC);
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Constructs the BaseCollectible object.
		 */
		public function BaseBlock()
		{
			super();
			parseXML();
			this.stop();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		public function begin() :void
		{
			this.play();
			this.visible = true;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function end():void
		{
			this.stop();
			this.visible = false;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function buildBlock($xPlacement:int, $yPlacement:int):void
		{	
			
			var s:Sprite = new TempTexture();
			s.width = _nWidth
			s.height = _nHeight;
			addChild(s);
			var material :Material = new Material(0,10,2,10);
			//body = new Body(BodyType.DYNAMIC);
			body.shapes.add((new Polygon(Polygon.box(_nWidth, _nHeight), material)));
			body.position.setxy($xPlacement, $yPlacement);

			body.space = SpaceRef.space;
			
			body.userData.graphic = s;	
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
		public function get getHealth(): int
		{
			return  _nBlockHealth;
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
			super.destroy();
		}
	}
}