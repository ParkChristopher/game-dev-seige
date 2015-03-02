package com.teamphysics.samg 
{
	import com.natejc.input.KeyboardManager;
	import com.natejc.input.KeyCode;
	import com.natejc.utils.StageRef;
	import com.teamphysics.chrisp.AbstractGameObject;
	import com.teamphysics.util.CollisionManager;
	import com.teamphysics.util.SpaceRef;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import nape.callbacks.CbType;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.phys.Material;
	import nape.shape.Circle;
	import com.natejc.utils.StageRef;
	import com.teamphysics.util.SoundManager;
	/**
	 * ...
	 * @author Sam Gronhovd
	 */
	public class Cannon extends AbstractGameObject
	{	
		public var backPoint		:Point;
		
		public var frontPoint		:Point;
		
		private var _height			:Number;
		
		private var _length			:Number;
		
		public var mcCannonBarrel	:MovieClip;
		
		public var mcPowerBar		:PowerBar;
		
		private var _bIsLeft		:Boolean;
		
		private var _bIsRotating	:Boolean;
		
		private var _bIsRotatingUp	:Boolean;
		
		private var _nRotationAmount	:Number;
		
		private var _aCannonBalls		:Array;
		
		protected var ballCollisionType		:CbType;
		
		private var _nSpeedBonus		:Number;
		private var cannonBallPhysicsBody:Body;
		public function Cannon() 
		{
			super();
			this.mouseChildren = false;
			this.mouseEnabled = false;
			frontPoint = new Point();
			backPoint = new Point();
			_height = this.mcCannonBarrel.height;//cannon must start horizontal
			_length = this.mcCannonBarrel.width;
			_bIsLeft = true;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function begin():void
		{
			super.begin();
			if (_bIsLeft)
			{
				backPoint.x = this.mcCannonBarrel.x - (this.mcCannonBarrel.width / 2);
				backPoint.y = this.mcCannonBarrel.y;
				backPoint = globalToLocal(backPoint);
				frontPoint.x = this.mcCannonBarrel.x + (this.mcCannonBarrel.width / 2);
				frontPoint.y = this.mcCannonBarrel.y;
				frontPoint = globalToLocal(frontPoint);
			}
			else 
			{
				backPoint.x = this.mcCannonBarrel.x + (this.mcCannonBarrel.width / 2);
				backPoint.y = this.mcCannonBarrel.y;
				backPoint = globalToLocal(backPoint);
				frontPoint.x = this.mcCannonBarrel.x - (this.mcCannonBarrel.width / 2);
				frontPoint.y = this.mcCannonBarrel.y;
				frontPoint = globalToLocal(frontPoint);
			}
			_aCannonBalls = new Array();
			
			_nSpeedBonus = 0;
			
			
			_bIsRotating = true;
			_bIsRotatingUp = true;
			_nRotationAmount = 0;
			
			if (_bIsLeft)
			{
				KeyboardManager.instance.addKeyDownListener(KeyCode.A, addCannonBall);
			}
			else 
			{
				this.scaleX = -1;
				KeyboardManager.instance.addKeyDownListener(KeyCode.L, addCannonBall);
			}
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function setLeftness($bIsLeft)
		{
			_bIsLeft = $bIsLeft;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function setSpeedBonus($nSpeedBonus)
		{
			_nSpeedBonus = $nSpeedBonus;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function enterFrameHandler(e:Event)
		{
			rotateCannon();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		protected function rotateCannon():void
		{
			if (_bIsRotating)
			{
				if (_bIsRotatingUp)
				{	
					if (_nRotationAmount > -66)
						_nRotationAmount--;
					else 
						_bIsRotatingUp = false;
				}
				else //rotating down
				{
					if (_nRotationAmount < 30)
						_nRotationAmount++;
					else
						_bIsRotatingUp = true;
				}
			}
			rotate(_nRotationAmount);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function setBallCollision($collisionType:CbType)
		{
			ballCollisionType = $collisionType;
		}
		
		private function addCannonBall()
		{
			if (_bIsRotating)
			{
				_bIsRotating = false;
				mcPowerBar.begin();
			}
			else if(!_bIsRotating && mcPowerBar.bIsMoving)
			{
				SoundManager.instance.playCannonFire();
				
				mcPowerBar.stopMoving();
				var s:CannonBall = new CannonBall();
				s.x = this.mcCannonBarrel.x;
				s.y = this.mcCannonBarrel.y;
				_aCannonBalls.push(s);
				
				CollisionManager.instance.add(s);
				s.cleanupSignal.add(removeObject);
				StageRef.stage.addChildAt(s, 1);
				s.begin();
		
				cannonBallPhysicsBody = new Body(BodyType.DYNAMIC, new Vec2(this.x, this.y));
				
				var material:Material = new Material(0.5);
				var shape:Circle = new Circle(s.width / 2, null, material);
				if (_bIsLeft)
				{
					shape.filter.collisionGroup = 1;//left
					shape.filter.collisionMask = 2;
				}
				else
				{
					shape.filter.collisionGroup = 2;//right
					shape.filter.collisionMask = 1;
				}
				cannonBallPhysicsBody.shapes.add(shape);
				cannonBallPhysicsBody.cbTypes.add(ballCollisionType);
				SpaceRef.space.bodies.add(cannonBallPhysicsBody);
			
				cannonBallPhysicsBody.userData.graphic = s;
				cannonBallPhysicsBody.mass = 1;
				
				trace("Left?: " + _bIsLeft);
				trace(frontPoint.x + ", " + frontPoint.y);
				trace(backPoint.x + ", " + backPoint.y);
				var velocityVec:Vec2 = new Vec2(frontPoint.x - backPoint.x, frontPoint.y - backPoint.y);
				var scaler:Number = 7 + (this.mcPowerBar.scaleX * 10) + _nSpeedBonus;
				trace("scaler: " + scaler);
				velocityVec = velocityVec.mul(scaler);
				trace("velocityVec: " + velocityVec.x + ", " + velocityVec.y);
					
				cannonBallPhysicsBody.velocity = velocityVec;
				
				_bIsRotating = true;
				mcPowerBar.end();
				
				_nSpeedBonus = 0;
				//this.mcP1SpeedIndicator.visible = false;
			}
			
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function removeObject($object:AbstractGameObject):void
		{
			var objectIndex :int = _aCannonBalls.indexOf($object);
			
				
			if (objectIndex >= 0)
			{
				trace("Cannon: Removing Object");
				$object.end();
				StageRef.stage.removeChild($object);
				this.cannonBallPhysicsBody.space = null;
				_aCannonBalls.splice(objectIndex, 1);
			}
			
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function rotate($angle:Number)
		{
			if (_bIsLeft)
			{
				this.mcCannonBarrel.rotation = $angle;
				var cos:Number = Math.cos($angle * (Math.PI / 180));
				var sin:Number = Math.sin($angle * (Math.PI / 180));
				frontPoint.x = cos * (_length * .5);
				frontPoint.y = sin * (_length * .5);
				backPoint.x = -cos * (_length * .5);
				backPoint.y = -sin * (_length * .5);
			}
			else 
			{
				this.mcCannonBarrel.rotation = $angle;
				var cos:Number = Math.cos($angle * (Math.PI / 180));
				var sin:Number = Math.sin($angle * (Math.PI / 180));
				frontPoint.x = -cos * (_length * .5);
				frontPoint.y = sin * (_length * .5);
				backPoint.x = cos * (_length * .5);
				backPoint.y = -sin * (_length * .5);
			}
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function end():void
		{
			super.end();
			
			KeyboardManager.instance.removeKeyDownListener(KeyCode.A, addCannonBall);
			KeyboardManager.instance.removeKeyDownListener(KeyCode.L, addCannonBall);
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		
	}

}