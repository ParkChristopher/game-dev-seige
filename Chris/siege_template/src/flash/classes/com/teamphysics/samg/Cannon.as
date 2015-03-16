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
	import com.teamphysics.util.ScoreManager;
	
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
		
		private var _sShotType		:String;
		
		private var _nRotationAmount	:Number;
		
		private var _aCannonBalls		:Array;
		
		protected var ballCollisionType		:CbType;
		
		private var _nSpeedBonus		:Number;
		private var cannonBallPhysicsBody:Body;
		
		public var	speedCleanupSignal	:Signal = new Signal(Cannon);

		public var 	changeShotTypeSignal	:Signal = new Signal(String);

		public var	endGameSignal	:Signal = new Signal();
		public var 	cannonFireSignal	:Signal = new Signal();

		public var s:CannonBall;

		
		private var multiS1	:CannonBall;
		private var multiS2	:CannonBall;
		private var multiS3	:CannonBall;

		
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
		
		public function show()
		{
			this.visible = true;

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
			
			_sShotType = "single";
			
			_nSpeedBonus = 0;
			
			
			_bIsRotating = true;
			_bIsRotatingUp = true;
			_nRotationAmount = 0;
			
			if (bOwnerIsP1)
			{
				KeyboardManager.instance.addKeyDownListener(KeyCode.A, firePressed);
				KeyboardManager.instance.addKeyDownListener(KeyCode.Q, changeShotType);
				
			}
			else 
			{
				this.scaleX = -1;
				KeyboardManager.instance.addKeyDownListener(KeyCode.L, firePressed);
				KeyboardManager.instance.addKeyDownListener(KeyCode.P, changeShotType);
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
		

		private function firePressed()
		{	
			if (_bIsRotating)
			{
				SoundManager.instance.playSpeedUp();
				_bIsRotating = false;
				mcPowerBar.begin();
			}
			else if(!_bIsRotating && mcPowerBar.bIsMoving)
			{
				trace("player 1: " + bOwnerIsP1 + " , cannon fired");
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

				if (_sShotType == "single")
				{
					shootSingleShot();
				}
				else
				{
					shootMultiShot();
				}
				
				_bIsRotating = true;
				mcPowerBar.end();
				
				if (_nSpeedBonus != 0)
					SoundManager.instance.playSpeedShot();
					
				_nSpeedBonus = 0;
				this.speedCleanupSignal.dispatch(this);
				
				justFired();
			}
			
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		private function shootMultiShot()
		{
			multiS1 = new CannonBall();
			multiS2 = new CannonBall();
			multiS3 = new CannonBall();
			multiS1.scaleX = multiS1.scaleY = .6;
			multiS2.scaleX = multiS2.scaleY = .6;
			multiS3.scaleX = multiS3.scaleY = .6;
			
			multiS1.gameOverSignal.add(kingKilled);
			multiS2.gameOverSignal.add(kingKilled);
			multiS3.gameOverSignal.add(kingKilled);
			
			multiS1.x = this.mcCannonBarrel.x;
			multiS1.y = this.mcCannonBarrel.y;
			multiS2.x = this.mcCannonBarrel.x;
			multiS2.y = this.mcCannonBarrel.y;
			multiS3.x = this.mcCannonBarrel.x;
			multiS3.y = this.mcCannonBarrel.y;
			
			multiS1.bOwnerIsP1 = this.bOwnerIsP1;
			multiS2.bOwnerIsP1 = this.bOwnerIsP1;
			multiS3.bOwnerIsP1 = this.bOwnerIsP1;
			
			_aCannonBalls.push(multiS1);
			_aCannonBalls.push(multiS2);
			_aCannonBalls.push(multiS3);
			
				
			CollisionManager.instance.add(multiS1);
			CollisionManager.instance.add(multiS2);
			CollisionManager.instance.add(multiS3);
			
			multiS1.cleanupSignal.add(removeObject);
			multiS2.cleanupSignal.add(removeObject);
			multiS3.cleanupSignal.add(removeObject);
			
			StageRef.stage.addChildAt(multiS1, 1);
			StageRef.stage.addChildAt(multiS2, 1);
			StageRef.stage.addChildAt(multiS3, 1);
			
			multiS1.begin();
			multiS2.begin();
			multiS3.begin();
				
				/*trace("Left?: " + bOwnerIsP1);
				trace(frontPoint.x + ", " + frontPoint.y);
				trace(backPoint.x + ", " + backPoint.y);*/
			var velocityVec:Vec2 = new Vec2(frontPoint.x - backPoint.x, frontPoint.y - backPoint.y);
			var scaler:Number = 4 + (this.mcPowerBar.mcMask.scaleX * 4) + _nSpeedBonus;
				
				//trace("speed bonus: " +_nSpeedBonus);
			velocityVec = velocityVec.mul(scaler);
			
			multiS1.setCbType(ballCollisionType);
			multiS2.setCbType(ballCollisionType);
			multiS3.setCbType(ballCollisionType);
			
			if (bOwnerIsP1)
			{
				ScoreManager.instance.nP1ShotsFired += 1;
				multiS1.buildBall(this.x, this.y,  1);
				multiS2.buildBall(this.x, this.y,  1);
				multiS3.buildBall(this.x, this.y,  1);
			}
			else 
			{
				ScoreManager.instance.nP2ShotsFired += 1;
				multiS1.buildBall(this.x, this.y, 2);
				multiS2.buildBall(this.x, this.y, 2);
				multiS3.buildBall(this.x, this.y, 2);
			}
			
			multiS1.body.mass = .6;
			multiS2.body.mass = .6;
			multiS3.body.mass = .6;
			
			multiS1.setVelocity(velocityVec);
			velocityVec = velocityVec.rotate(2 * Math.PI / 180);
			multiS2.setVelocity(velocityVec);
			velocityVec = velocityVec.rotate( -4 * Math.PI / 180);
			multiS3.setVelocity(velocityVec);
			justFired();
		}
		
		private function shootSingleShot()
		{
			trace("shoot single shot");
			var velocityVec:Vec2;
			var scaler:Number;
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
			velocityVec = new Vec2(frontPoint.x - backPoint.x, frontPoint.y - backPoint.y);
			scaler = 4 + (this.mcPowerBar.mcMask.scaleX * 4) + _nSpeedBonus;
				
				//trace("speed bonus: " +_nSpeedBonus);
			velocityVec = velocityVec.mul(scaler);
				
			s.setCbType(ballCollisionType);
				
			if (bOwnerIsP1)
			{
				ScoreManager.instance.nP1ShotsFired += 1;
				s.buildBall(this.x, this.y,  1);
			}
			else 
			{
				ScoreManager.instance.nP2ShotsFired += 1;
				s.buildBall(this.x, this.y, 2);
			}
			s.body.mass = 1;
			s.setVelocity(velocityVec);
		}
		
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
			SoundManager.instance.playLock();
		}
		
		private function changeShotType()
		{
			if (_sShotType == "single")
			{
				changeShotTypeSignal.dispatch("multi");
				_sShotType = "multi";
			}
			else //shotType == "multi"
			{
				changeShotTypeSignal.dispatch("single");
				_sShotType = "single";
			}
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function removeObject($object:AbstractGameObject):void
		{
			var objectIndex :int = _aCannonBalls.indexOf($object);
			
				
			if (objectIndex >= 0)
			{
				//trace("Cannon: Removing Object");
				if(CannonBall($object))
				{
					var tempCannonball : CannonBall = CannonBall($object);
					tempCannonball.cleanCannonBall();
				}
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
			
			KeyboardManager.instance.removeKeyDownListener(KeyCode.A, firePressed);
			KeyboardManager.instance.removeKeyDownListener(KeyCode.L, firePressed);
			
			for (var i:int = 0; i < _aCannonBalls.length; i++)
			{
				_aCannonBalls[i].end();
			}
			
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function pauseCannons():void
		{
			if (bOwnerIsP1)
			{
				KeyboardManager.instance.removeKeyDownListener(KeyCode.A, firePressed);
				KeyboardManager.instance.removeKeyDownListener(KeyCode.Q, changeShotType);
			}
			else
			{
				KeyboardManager.instance.removeKeyDownListener(KeyCode.L, firePressed);
				KeyboardManager.instance.removeKeyDownListener(KeyCode.P, changeShotType);
			}
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function resumeCannons():void
		{
			if (bOwnerIsP1)
			{
				KeyboardManager.instance.addKeyDownListener(KeyCode.A, firePressed);
				KeyboardManager.instance.addKeyDownListener(KeyCode.Q, changeShotType);
			}
			else
			{
				KeyboardManager.instance.addKeyDownListener(KeyCode.L, firePressed);
				KeyboardManager.instance.addKeyDownListener(KeyCode.P, changeShotType);
			}
			
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		
	}

}