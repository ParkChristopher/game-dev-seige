package com.teamphysics.util
{
	
	//TO ADD: Ground Hit
	//
	import adobe.utils.CustomActions;
	import treefortress.sound.SoundAS;
	import treefortress.sound.SoundInstance;
	
	/**
	 * @author Chris Park
	 */
	public class SoundManager
	{
		/** Stores a reference to the singleton instance. */  
		private static const _instance	:SoundManager = new SoundManager( SingletonLock );
		
		public static var SOUND_BUTTON_CLICK:String = "ButtonClick";
		public static var SOUND_CANNON_FIRE:String = "CannonFire";
		public static var SOUND_POWERUP_GET:String = "PowerupGet";
		public static var SOUND_GET_POINT:String = "GetPoint";
		public static var SOUND_GROUND_HIT:String = "GroundHit";
		public static var SOUND_HIT_BLOCK:String = "HitBlock";
		public static var SOUND_ITEM_SELECT:String = "ItemSelect";
		public static var SOUND_KING_DIED:String = "KingDied";
		public static var SOUND_CANNON_LOCK:String = "Lock";
		public static var SOUND_GAME_PAUSE:String = "Pause";
		public static var SOUND_CANNON_ROTATION:String = "Rotation";
		public static var SOUND_SHIELD_ACTIVATE:String = "ShieldActivate";
		public static var SOUND_SHIELD_DOWN:String = "ShieldDown";
		public static var SOUND_SPEED_UP:String = "VelocityUp";
		public static var SOUND_VICTORY:String = "Victory";
		public static var SOUND_SHIELD_BOUNCE:String = "Shield Bounce";
		public static var SOUND_SPEED_SHOT:String = "Speed Shot";
		
		public static var MUSIC_TITLE_SCREEN:String = "TitleScreenLoop";
		public static var MUSIC_RESULTS_SCREEN:String = "ResultsScreenLoop";
		public static var MUSIC_GAME_SCREEN:String = "GameScreenLoop";
		
		
		public static var SE_VOLUME:Number = 1;
		public var titleMusicInstance			:SoundInstance;
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the SingletonExample object.
		 * 
		 * @param	lock	This class is a singleton and should not be externally instantiated.
		 */
		public function SoundManager($lock:Class)
		{
			if ($lock != SingletonLock)
				throw new Error("SoundManager is a singleton and should not be instantiated. Use SingletonExample.instance instead");
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		//Initialize sounds
		public function init():void
		{
			SoundAS.loadSound("../src/audio/ButtonClick.mp3" ,SOUND_BUTTON_CLICK);
			SoundAS.loadSound("../src/audio/CannonFire.mp3" ,SOUND_CANNON_FIRE);
			SoundAS.loadSound("../src/audio/PowerupGet.mp3" ,SOUND_POWERUP_GET);
			SoundAS.loadSound("../src/audio/TitleScreenLoop.mp3" ,MUSIC_TITLE_SCREEN);
			SoundAS.loadSound("../src/audio/ResultsScreenLoop.mp3" ,MUSIC_RESULTS_SCREEN);
			SoundAS.loadSound("../src/audio/KirbYourEnthusiasm.mp3" , MUSIC_GAME_SCREEN);
			SoundAS.loadSound("../src/audio/GetPoint.mp3", SOUND_GET_POINT);
			SoundAS.loadSound("../src/audio/GroundHit.mp3", SOUND_GROUND_HIT);
			SoundAS.loadSound("../src/audio/HitBlock.mp3", SOUND_HIT_BLOCK);
			SoundAS.loadSound("../src/audio/ItemSelect.mp3", SOUND_ITEM_SELECT);
			SoundAS.loadSound("../src/audio/KingDied.mp3", SOUND_KING_DIED);
			SoundAS.loadSound("../src/audio/Lock.mp3", SOUND_CANNON_LOCK);
			SoundAS.loadSound("../src/audio/Pause.mp3", SOUND_GAME_PAUSE);
			SoundAS.loadSound("../src/audio/Rotation.mp3", SOUND_CANNON_ROTATION );
			SoundAS.loadSound("../src/audio/ShieldActivate.mp3", SOUND_SHIELD_ACTIVATE);
			SoundAS.loadSound("../src/audio/ShieldDown.mp3", SOUND_SHIELD_DOWN);
			SoundAS.loadSound("../src/audio/VelocityUp.mp3", SOUND_SPEED_UP);
			SoundAS.loadSound("../src/audio/Victory.mp3", SOUND_VICTORY);
			SoundAS.loadSound("../src/audio/ShieldBounce.mp3", SOUND_SHIELD_BOUNCE);
			SoundAS.loadSound("../src/audio/SpeedShot.mp3", SOUND_SPEED_SHOT);
			
		}
		/* ---------------------------------------------------------------------------------------- */
		
		public function playSpeedShot():void
		{
			SoundAS.playFx(SOUND_SPEED_SHOT, .2);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playShieldBounce():void
		{
			SoundAS.playFx(SOUND_SHIELD_BOUNCE, .5);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playItemSelect():void
		{
			SoundAS.playFx(SOUND_ITEM_SELECT, .5);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playPointGet():void
		{
			SoundAS.playFx(SOUND_GET_POINT, .5);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playGroundHit():void
		{
			SoundAS.playFx(SOUND_GROUND_HIT, .5);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playRotation():void
		{
			SoundAS.playFx(SOUND_CANNON_ROTATION, .01);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playPause():void
		{
			SoundAS.playFx(SOUND_GAME_PAUSE, .5);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playSpeedUp():void
		{
			SoundAS.playFx(SOUND_SPEED_UP, .1);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playLock():void
		{
			SoundAS.playFx(SOUND_CANNON_LOCK, .5);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playResultsMusic():void
		{
			SoundAS.fadeAllTo(0);
			SoundAS.fadeFrom(MUSIC_RESULTS_SCREEN, 0, .2);
			SoundAS.playLoop(MUSIC_RESULTS_SCREEN, .2);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playVictory():void
		{
			
			SoundAS.stopAll();
			SoundAS.playFx(SOUND_VICTORY, .1);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playKingDied():void
		{
			SoundAS.playFx(SOUND_KING_DIED, .5);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playBlockHit():void
		{
			SoundAS.playFx(SOUND_HIT_BLOCK, .5);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playShieldDown():void
		{
			SoundAS.playFx(SOUND_SHIELD_DOWN, .2);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playShieldActivate():void
		{
			SoundAS.playFx(SOUND_SHIELD_ACTIVATE, .5);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playButtonClick():void
		{
			SoundAS.playFx(SOUND_BUTTON_CLICK);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playCannonFire():void
		{
			SoundAS.playFx(SOUND_CANNON_FIRE, .1);
		}
		/* ---------------------------------------------------------------------------------------- */
		
		public function playPowerupGet():void
		{
			SoundAS.playFx(SOUND_POWERUP_GET, .2);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playTitleMusic():void
		{
			if (titleMusicInstance == null || !titleMusicInstance.isPlaying)
			{
				
				SoundAS.fadeAllTo(0);
				SoundAS.fadeFrom(MUSIC_TITLE_SCREEN, 0, .2);
				titleMusicInstance = SoundAS.playLoop(MUSIC_TITLE_SCREEN, .2);
			}
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playGameMusic():void
		{
			
			SoundAS.fadeAllTo(0);
			SoundAS.fadeFrom(MUSIC_GAME_SCREEN, 0, .1);
			SoundAS.playLoop(MUSIC_GAME_SCREEN, .1);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function pauseSound():void
		{
			SoundAS.pauseAll();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function resumeSound():void
		{
			SoundAS.resumeAll();
		}
		/* ---------------------------------------------------------------------------------------- */
		
		//Returns an instance to this class.
		public static function get instance():SoundManager
		{
			return _instance;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
	}
}

class SingletonLock {} // Do nothing, this is just to prevent external instantiation.
