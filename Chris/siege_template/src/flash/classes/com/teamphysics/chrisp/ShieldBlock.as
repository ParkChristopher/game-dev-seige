package com.teamphysics.chrisp
{
	import com.teamphysics.chrisp.AbstractGameObject;
	import flash.display.Sprite;
	import nape.phys.Body;
	import nape.shape.Polygon;
	import nape.phys.BodyType;
	import com.teamphysics.util.SpaceRef;
	import com.natejc.utils.StageRef;
	import com.teamphysics.util.GameObjectType;
	import com.teamphysics.util.CollisionManager;
	import com.greensock.TweenMax;

	
	/**
	 * Creates a shield block to protect the player castle
	 * 
	 * @author Chris Park
	 */
	public class ShieldBlock extends AbstractGameObject
	{
		
		protected var physicsBody		:Body;
		protected var poly				:Polygon;
		protected var tempTexture		:Sprite;
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the ShieldBlock object.
		 */
		public function ShieldBlock($bOwnerIsP1:Boolean)
		{
			super();
			
			this.bOwnerIsP1 = $bOwnerIsP1
			init();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function init()
		{
			this._sObjectType = GameObjectType.TYPE_SHIELD_WALL;
			this.addCollidableType(GameObjectType.TYPE_CANNONBALL);
			
			CollisionManager.instance.add(this);
			
			this.tempTexture = new ShieldBlockTexture();
			this.tempTexture.width = 10;
			this.tempTexture.height = 775;
			
			this.physicsBody = new Body(BodyType.STATIC);
			this.poly = new Polygon(Polygon.box(10, 775));
			
			this.physicsBody.shapes.add(this.poly);
			
			if (this.bOwnerIsP1)
			{
				this.poly.filter.collisionGroup = 1;
				this.physicsBody.position.setxy(275, 0);
			}
			else
			{
				this.poly.filter.collisionGroup = 2;
				this.physicsBody.position.setxy(625, 0);
			}
			
			this.addChild(tempTexture);
			this.physicsBody.space = SpaceRef.space;
			this.physicsBody.userData.graphic = this.tempTexture;
			
		}
		/* ---------------------------------------------------------------------------------------- */
		
		override public function begin():void
		{
			super.begin();
			
			
			
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
			super.end();
			cleanUp();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function cleanUp() :void
		{
			CollisionManager.instance.remove(this);
			StageRef.stage.removeChild(this);
			TweenMax.delayedCall(.5, this.removePhysicsBody);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function removePhysicsBody():void
		{
			this.physicsBody.space = null;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
	}
}

