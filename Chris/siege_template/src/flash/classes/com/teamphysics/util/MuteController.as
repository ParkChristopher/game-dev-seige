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
	import com.natejc.utils.StageRef;
	import com.treefortress.sound.SoundAS;
	import com.treefortress.sound.SoundInstance;
	import com.treefortress.sound.SoundManager;
	import flash.net.SharedObject;
	import com.lontzz.MusicManager;
	
	public class MuteController extends MovieClip
	{
		/** A button to handle muting the sound. */
		public var btMute		:SimpleButton;
		/** A button to handle unmuting the sound. */
		public var btUnmute		:SimpleButton;
		/** A shared object to tell when the game was muted in a previous session. */
		public var so:SharedObject = SharedObject.getLocal("mute"); 

		public function MuteController() 
		{
			if(so.size == 0)
			{
				so.data.mute = "false";
			}
			if(so.data.mute == "false")
			{
				btMute.visible = false;
			}
			else
				btUnmute.visible = false;
			this.btMute.addEventListener(MouseEvent.MOUSE_DOWN, unmuteSound);
			this.btUnmute.addEventListener(MouseEvent.MOUSE_DOWN, muteSound);
		}
		
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Listens for a click to happen on the mute button and then sends that off to the mute function.
		 */
		public function muteSound(Event):void
		{
			btMute.visible = true;
			btUnmute.visible = false;
			this.muteMusic();
		}
		
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Listens for a click to happen on the unmute button and then sends that off to the mute function.
		 */
		public function unmuteSound(Event):void
		{
			btUnmute.visible = true;
			btMute.visible = false;
			this.muteMusic();
		}
		
		/* ---------------------------------------------------------------------------------------- */				
		/**
		 * Fades all sounds to zero or returns them to full volume.
		 */
		public function muteMusic() :void
		{
			MusicManager.instance.playClickSound();
			SoundAS.pauseAll();
			if(so.data.mute == "false")
			{
				SoundAS.fadeAllTo(0, 1000);
				SoundAS.mute = true;
				so.data.mute = "true";
			}
			else if(so.data.mute == "true")
			{
				SoundAS.mute = false;
				SoundAS.fadeAllFrom(0, 1);
				so.data.mute = "false";
				SoundAS.resumeAll();
			}

		}
	}
	
}