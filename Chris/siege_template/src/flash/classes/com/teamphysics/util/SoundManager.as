package com.teamphysics.util
{
	
	import treefortress.sound.SoundAS;
	
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
		public static var MUSIC_TITLE_SCREEN:String = "TitleScreenLoop";
		public static var MUSIC_RESULTS_SCREEN:String = "ResultsScreenLoop";
		public static var MUSIC_GAME_SCREEN:String = "GameScreenLoop";
		
		public static var SE_VOLUME:Number = 1;
		
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
			SoundAS.loadSound("../src/audio/KirbYourEnthusiasm.mp3" ,MUSIC_GAME_SCREEN);
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
			SoundAS.playFx(SOUND_POWERUP_GET, .5);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playTitleMusic():void
		{
			SoundAS.fadeAllTo(0);
			SoundAS.fadeFrom(MUSIC_TITLE_SCREEN, 0, .2);
			SoundAS.playLoop(MUSIC_TITLE_SCREEN, .2);
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playGameMusic():void
		{
			
			SoundAS.fadeAllTo(0);
			SoundAS.fadeFrom(MUSIC_GAME_SCREEN, 0, .2);
			SoundAS.playLoop(MUSIC_GAME_SCREEN, .2);
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
