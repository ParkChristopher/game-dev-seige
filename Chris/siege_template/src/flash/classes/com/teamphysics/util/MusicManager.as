package com.teamphysics.util
{
	import com.natejc.input.KeyboardManager;
	import com.natejc.input.KeyCode;
	import flash.display.SimpleButton;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;
	import com.lontzz.BaseGameObject;
	import com.natejc.util.StageRef;
	import com.treefortress.sound.SoundAS;
	import com.treefortress.sound.SoundInstance;
	import com.treefortress.sound.SoundManager;
	import flash.net.SharedObject;

	public class MusicManager 
	{
		private static const _instance :MusicManager = new MusicManager(SingletonLock);
		public static var GAMEMUSIC:String = "01 Old Friends.mp3";
		public static var TITLEMUSIC:String = "15 Gateless.mp3";
		public static var CLICKSOUND:String = "Click.mp3";
		public static var COLLECTSOUND:String = "Collect.mp3";
		public static var HITSOUND:String = "Hit.mp3";
		public var so:SharedObject = SharedObject.getLocal("mute"); 

		/** Number to handle the volume for music/sounds. */
		public var volume:Number = 1;

		
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Constructs the MusicManager object.
		 * False = playing
		 * True = muted
		 */
		public function MusicManager($lock:Class)
		{
			if($lock != SingletonLock)
				throw new Error("CollisionManager is a singleton and should not be instantiated multiple times");
			
			
			//SoundAS.loadSound("../src/audio/01 Old Friends.mp3", GAMEMUSIC, 100);
			//SoundAS.loadSound("../src/audio/15 Gateless.mp3", TITLEMUSIC, 100);
			//SoundAS.loadSound("../src/audio/Click.mp3", CLICKSOUND, 100);
			//SoundAS.loadSound("../src/audio/Collect.mp3", COLLECTSOUND, 100);
			//SoundAS.loadSound("../src/audio/Hit.mp3", HITSOUND, 100);


			
		}

		/**
		 * Returns an instance to this class.
		 *
		 * @return		An instance to this class.
		 */
		public static function get instance():MusicManager
		{
			return _instance;
		}

		
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Plays the game screen music.
		 */
		public function playGameScreenMusic() :void
		{
			SoundAS.stopAll();
			SoundAS.playLoop(GAMEMUSIC, volume);
		}		
		
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Plays the hit sound.
		 */
		public function playHitSound() :void
		{
			SoundAS.pause(GAMEMUSIC);
			SoundAS.play(HITSOUND, 1);
			SoundAS.resume(GAMEMUSIC);
		}			
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Plays the collected sound.
		 */
		public function playCollectSound() :void
		{
			SoundAS.pause(GAMEMUSIC);
			SoundAS.play(COLLECTSOUND, volume);
			SoundAS.resume(GAMEMUSIC);
		}		
		
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Plays the title screen music.
		 */
		public function playTitleScreenMusic() :void
		{
			SoundAS.stopAll();
			if(so.data.mute == "false")
			{
				trace("so.data.mute == " + so.data.mute);
				trace("Play title screen");
				SoundAS.playLoop(TITLEMUSIC, volume);
			}
		}
		
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Plays a clicked sound when a button is clicked.
		 */
		public function playClickSound() :void
		{
			SoundAS.pauseAll();
			SoundAS.play(CLICKSOUND, volume);
			SoundAS.resumeAll();
		}
		
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Ends all sound.
		 */
		public function end() :void
		{
			SoundAS.pauseAll();
		}
	}
	
}
/* ---------------------------------------------------------------------------------------- */				
/**
* Acts as a lock for the singleton method above to prevent multiple instances.
*/
class SingletonLock {}