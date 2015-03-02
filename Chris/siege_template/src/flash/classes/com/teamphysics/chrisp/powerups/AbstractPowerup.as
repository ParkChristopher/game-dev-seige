
package com.teamphysics.chrisp.powerups
{
	import com.teamphysics.chrisp.AbstractGameObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.teamphysics.util.GameObjectType;

	
	/**
	 * Base class for powerups
	 * 
	 * @author Chris Park
	 */
	public class AbstractPowerup extends AbstractGameObject
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
			
			this.sType = $sType;
			this.visible = false;
			
			init();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function init():void
		{	
			this.x = MIN_POS_X + Math.random() * (MAX_POS_X - MIN_POS_X);
			this.y = MIN_POS_Y + Math.random() * (MAX_POS_Y - MIN_POS_Y);
			
			
			/******NOTE CURRENTLY USED REMOVE IF NECESSARY***********/
			//Create body and set position somewhere between castles.
			this.physicsBody = new Body(BodyType.KINEMATIC);
			physicsBody.shapes.add(new Circle(this.width * 0.5, null));
			physicsBody.position.setxy(this.x, this.y);
			physicsBody.userData.graphic = this;
			/********************************************************/
			
			
			this.addCollidableType(GameObjectType.TYPE_CANNONBALL);
			
			
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function begin():void
		{
			super.begin();
			this.show();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
			super.end();
			this.hide();
		}
		
		/* ---------------------------------------------------------------------------------------- */		
		
		//Controls Tweening for this powerup
		protected function show():void
		{
			TweenMax.to(this, 2, {y:this.y + 100, repeat:-1, yoyo:true, ease:Quad.easeInOut}  );
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		//Stops tweening for this powerup
		protected function hide():void
		{
			TweenMax.killTweensOf(this);
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
		override public function activate($object:MovieClip):void
		{
			super.activate($object);
		}
		
		//Relinquishes all memory used by this object.
		public function destroy():void
		{
			while (this.numChildren > 0)
				this.removeChildAt(0);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function get getPowerupType():String
		{
			return this.sType;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
	}
}
