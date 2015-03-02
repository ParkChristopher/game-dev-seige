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
		
		public static var SOUND_BUTTON_CLICK:String = "../src/audio/ButtonClick.mp3";
		public static var SOUND_CANNON_FIRE:String = "../src/audio/CannonFire.mp3";
		public static var SOUND_POWERUP_GET:String = "../src/audio/PowerupGet.mp3";
		public static var MUSIC_TITLE_SCREEN:String = "../src/audio/TitleScreenLoop.mp3";
		public static var MUSIC_RESULTS_SCREEN:String = "../src/audio/ResultsScreenLoop.mp3";
		
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
			SoundAS.loadSound(SOUND_BUTTON_CLICK, "ButtonClick");
			SoundAS.loadSound(SOUND_CANNON_FIRE, "CannonFire");
			SoundAS.loadSound(SOUND_POWERUP_GET, "PowerupGet");
			SoundAS.loadSound(MUSIC_TITLE_SCREEN, "TitleScreenLoop");
			SoundAS.loadSound(MUSIC_RESULTS_SCREEN, "ResultsScreenLoop");
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playButtonClick():void
		{
			SoundAS.playFx("ButtonClick");
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playCannonFire():void
		{
			SoundAS.playFx("CannonFire");
		}
		/* ---------------------------------------------------------------------------------------- */
		
		public function playPowerupGet():void
		{
			SoundAS.playFx("PowerupGet");
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function playTitleMusic():void
		{
			
			SoundAS.fadeTo("TitleScreenLoop", .5);
			SoundAS.playLoop("TitleScreenLoop", .5);
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
