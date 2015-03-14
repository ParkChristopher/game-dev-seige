package com.teamphysics.chrisp.powerups {
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
	import org.osflash.signals.Signal;

	
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
		protected var bRemoved			:Boolean;
		public var nShieldHealth	:Number;
		
		public var removeShieldSignal	:Signal = new Signal(Boolean);
		
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
			this.bRemoved = false;
			this._sObjectType = GameObjectType.TYPE_SHIELD_WALL;
			this.addCollidableType(GameObjectType.TYPE_CANNONBALL);
			CollisionManager.instance.add(this);
			
			this.nShieldHealth  = 3;
			
			this.tempTexture = new ShieldBlockTexture();
			this.tempTexture.width = 10;
			this.tempTexture.height = 900;
			
			this.physicsBody = new Body(BodyType.STATIC);
			this.poly = new Polygon(Polygon.box(10, 900));
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
			if (bRemoved)
				return;
				
			this.bRemoved  = true;
			CollisionManager.instance.remove(this);
			StageRef.stage.removeChild(this);
			this.physicsBody.space = null;
			this.removePhysicsBody();
			this.removeShieldSignal.dispatch(bOwnerIsP1);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function removePhysicsBody():void
		{
			this.physicsBody.space = null;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
	}
}

