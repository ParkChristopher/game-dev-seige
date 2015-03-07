package com.teamphysics.samg 
{
	import com.greensock.easing.Elastic;
	import com.greensock.TweenMax;
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
	import org.osflash.signals.natives.base.SignalBitmap;
	import org.osflash.signals.Signal;
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
		
		private var _bIsRotating	:Boolean;
		
		private var _bIsRotatingUp	:Boolean;
		
		private var _nRotationAmount	:Number;
		
		private var _aCannonBalls		:Array;
		
		protected var ballCollisionType		:CbType;
		
		private var _nSpeedBonus		:Number;
		private var cannonBallPhysicsBody:Body;
		
		public var	speedCleanupSignal	:Signal = new Signal(Cannon);
		public var	endGameSignal	:Signal = new Signal();
		public var 	cannonFireSignal	:Signal = new Signal();

		public var s:CannonBall;
		
		public function Cannon() 
		{
			super();
			this.mouseChildren = false;
			this.mouseEnabled = false;
			frontPoint = new Point();
			backPoint = new Point();
			_height = this.mcCannonBarrel.height;//cannon must start horizontal
			_length = this.mcCannonBarrel.width;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		override public function begin():void
		{
			super.begin();
			if (bOwnerIsP1)
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
			
			if (bOwnerIsP1)
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
		public function kingKilled():void
		{
			trace("King was killed");
			this.endGameSignal.dispatch();
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
				if (bOwnerIsP1)
				{
					cannonFireSignal.dispatch(1);
				}
				else
				{
					cannonFireSignal.dispatch(2);
				}
				
				mcPowerBar.stopMoving();
				s = new CannonBall();
				s.gameOverSignal.add(kingKilled);
				s.x = this.mcCannonBarrel.x;
				s.y = this.mcCannonBarrel.y;
				
				s.bOwnerIsP1 = this.bOwnerIsP1;
				
				_aCannonBalls.push(s);
				
				CollisionManager.instance.add(s);
				s.cleanupSignal.add(removeObject);
				StageRef.stage.addChildAt(s, 1);
				s.begin();
				
				/*trace("Left?: " + bOwnerIsP1);
				trace(frontPoint.x + ", " + frontPoint.y);
				trace(backPoint.x + ", " + backPoint.y);*/
				var velocityVec:Vec2 = new Vec2(frontPoint.x - backPoint.x, frontPoint.y - backPoint.y);
				var scaler:Number = 4 + (this.mcPowerBar.mcMask.scaleX * 4) + _nSpeedBonus;
				
				//trace("speed bonus: " +_nSpeedBonus);
				velocityVec = velocityVec.mul(scaler);
				
				s.setCbType(ballCollisionType);
				if (bOwnerIsP1)
				{
					s.buildBall(this.x, this.y,  1);
				}
				else 
				{
					s.buildBall(this.x, this.y, 2);
				}
				s.setVelocity(velocityVec);
					
				
				_bIsRotating = true;
				mcPowerBar.end();
				
				_nSpeedBonus = 0;
				this.speedCleanupSignal.dispatch(this);
				
				justFired();
			}
			
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		private function justFired()
		{
			_bIsRotating = false;
			
			TweenMax.to(this.mcCannonBarrel, 2, { rotation:0, ease:Elastic.easeOut, onComplete:backToZero } );
			//not sure why this isn't working...
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		private function backToZero()
		{
			_nRotationAmount = 0;
			//_bIsRotatingUp = true; //?
			_bIsRotating = true;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function removeObject($object:AbstractGameObject):void
		{
			var objectIndex :int = _aCannonBalls.indexOf($object);
			
				
			if (objectIndex >= 0)
			{
				//trace("Cannon: Removing Object");
				$object.end();
				StageRef.stage.removeChild($object);
				_aCannonBalls.splice(objectIndex, 1);
			}
			
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function rotate($angle:Number)
		{
			var sin:Number;
			var cos:Number;
			if (bOwnerIsP1)
			{
				this.mcCannonBarrel.rotation = $angle;
				cos = Math.cos($angle * (Math.PI / 180));
				sin = Math.sin($angle * (Math.PI / 180));
				frontPoint.x = cos * (_length * .5);
				frontPoint.y = sin * (_length * .5);
				backPoint.x = -cos * (_length * .5);
				backPoint.y = -sin * (_length * .5);
			}
			else 
			{
				this.mcCannonBarrel.rotation = $angle;
				cos = Math.cos($angle * (Math.PI / 180));
				sin = Math.sin($angle * (Math.PI / 180));
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