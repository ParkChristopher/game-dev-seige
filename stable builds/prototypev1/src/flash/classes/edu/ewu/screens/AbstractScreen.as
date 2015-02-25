package edu.ewu.screens
{
	import flash.display.MovieClip;
	import org.osflash.signals.*;
	
	/**
	 * ...
	 * @author Sam Gronhovd
	 */
	public class AbstractScreen extends MovieClip
	{
		/** tells the game that the screen has started to begin, before animaions are complete*/
		public var beginStartSignal			:Signal = new Signal();
		
		/** tells the game the screen has finished begining animations */
		public var beginOverSignal			:Signal = new Signal();
		
		/** tells the game that the screen has finished */
		public var screenCompleteSignal		:Signal = new Signal();
		
		/** dispatches when hiding is begining */
		public var endBeginSignal			:Signal = new Signal();
		
		/**
		 * constructs an Abstract Screen object, should never actually be called
		 *
		 */
		public function AbstractScreen()
		{
			this.visible = false;
		}
		
		/* ­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­ */
		
		/**
		 * Starts the screen, making it visible
		 *
		 */
		public function begin()
		{
			this.visible = true;
			this.beginStartSignal.dispatch();
		}
		
		/* ­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­ */
		
		/**
		 * stops the screen, making it invisible and dispatching the screenCompleteSignal
		 *
		 */
		public function beginOver()
		{
			this.beginOverSignal.dispatch();
		}
		
		/* ­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­ */
		
		/**
		 * stops the screen, making it invisible
		 *
		 */
		public function end()
		{
			this.endBeginSignal.dispatch();
		}
		
		/* ­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­­ */
		
		/**
		 * stops the screen, making it invisible and dispatching the screenCompleteSignal
		 *
		 */
		public function endComplete()
		{
			this.visible = false;
			screenCompleteSignal.dispatch();
		}
	}
	
}