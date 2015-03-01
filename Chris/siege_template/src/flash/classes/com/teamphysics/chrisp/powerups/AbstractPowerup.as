
package com.teamphysics.chrisp.powerups
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	import nape.shape.Polygon;

	
	/**
	 * Base class for powerups
	 * 
	 * @author Chris Park
	 */
	public class AbstractPowerup extends MovieClip
	{
		protected const MIN_POS_X = 400;
		protected const MAX_POS_X = 500;
		protected const MIN_POS_Y = 50;
		protected const MAX_POS_Y = 300;
		
		protected var sType					:String;
		protected var physicsBody			:Body;
		/* ---------------------------------------------------------------------------------------- */
		
		//Constructs the PowerUp object.
		public function AbstractPowerup($sType:String)
		{
			super();
			
			this.mouseEnabled	= false;
			this.mouseChildren	= false;
			
			this.sType = $sType;
			this.visible = false;
			
			init();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function init():void
		{	
			this.x = MIN_POS_X + Math.random() * (MAX_POS_X - MIN_POS_X);
			this.y = MIN_POS_Y + Math.random() * (MAX_POS_Y - MIN_POS_Y);
			
			//Create body and set position somewhere between castles.
			this.physicsBody = new Body(BodyType.KINEMATIC);
			physicsBody.shapes.add(new Circle(this.width * 0.5, null));
			physicsBody.position.setxy(this.x, this.y);
			physicsBody.userData.graphic = this;
			
			
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function begin():void
		{
			this.visible = true;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function end():void
		{
			this.visible = false;
		}
		
		/* ---------------------------------------------------------------------------------------- */		
		
		
		public function get getPhysicsBody():Body
		{
			return this.physicsBody;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function set setPhysicsBody($value:Body):void
		{
			physicsBody = $value;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		//Set up a powerups ability when it is picked up
		public function activate():void
		{
			
		}
		
		//Relinquishes all memory used by this object.
		public function destroy():void
		{
			while (this.numChildren > 0)
				this.removeChildAt(0);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
	}
}
