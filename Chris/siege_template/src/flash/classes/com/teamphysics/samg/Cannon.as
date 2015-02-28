package com.teamphysics.samg 
{
	import com.teamphysics.samg.AbstractObject;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import nape.geom.Vec2;
	/**
	 * ...
	 * @author Sam Gronhovd
	 */
	public class Cannon extends AbstractObject
	{
		public var backPoint	:Point;
		
		public var frontPoint	:Point;
		
		private var _height		:Number;
		
		private var _length		:Number;
		
		public function Cannon() 
		{
			super();
			this.mouseChildren = false;
			this.mouseEnabled = false;
			frontPoint = new Point();
			backPoint = new Point();
			_height = this.height;//cannon must start horizontal
			_length = this.width;
		
		}
		
		public override function begin()
		{
			super.begin();
			backPoint.x = this.x - (this.width / 2);
			backPoint.y = this.y;
			backPoint = globalToLocal(backPoint);
			frontPoint.x = this.x + (this.width / 2);
			frontPoint.y = this.y;
			frontPoint = globalToLocal(frontPoint);
		}
		
		public function rotate($angle:Number)
		{
			this.rotation = $angle;
			var cos:Number = Math.cos($angle * (Math.PI / 180));
			var sin:Number = Math.sin($angle * (Math.PI / 180));
			frontPoint.x = cos * (_length * .5);
			frontPoint.y = sin * (_length * .5);
			backPoint.x = -cos * (_length * .5);
			backPoint.y = -sin * (_length * .5);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
			this.visible = false;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		
	}

}