package com.teamphysics.util
{
	import com.teamphysics.chrisp.AbstractGameObject;
	import com.natejc.utils.StageRef;
	import flash.events.Event;
	import flash.net.SharedObject;

	/**
	 * Manages the score for the game
	 * 
	 * @author Chris Park
	 */
	public class ScoreManager
	{
		/** Stores a reference to the singleton instance. */  
		private static const _instance	:ScoreManager = new ScoreManager( SingletonLock );
		
		public var nP1Score				:Number;
		public var nP2Score				:Number;
		public var nP1ShotsFired		:Number;
		public var nP2ShotsFired		:Number;
		public var nP1Accuracy			:Number;
		public var nP2Accuracy			:Number;
		public var nHighScore			:Number;
		public var nP1ShotsLanded		:Number;
		public var nP2ShotsLanded		:Number;
		public var sWinner				:String;
		
		/* ---------------------------------------------------------------------------------------- */
		
		/**
		 * Constructs the ScoreManager object.
		 * 
		 * @param	lock	This class is a singleton and should not be externally instantiated.
		 */
		public function ScoreManager($lock:Class)
		{
			if ($lock != SingletonLock)
				throw new Error("ScoreManager is a singleton and should not be instantiated. Use CollisionManager.instance instead");
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		//get instance of score manager
		public static function get instance():ScoreManager
		{		
			return _instance;
		}
		/* ---------------------------------------------------------------------------------------- */
		
		//resets all initial score values
		public function reset():void
		{
			this.nP1Score = 0;
		    this.nP2Score = 0;
			this.nP1ShotsFired = 0;
			this.nP2ShotsFired = 0;
			this.nP1Accuracy = 0;
			this.nP2Accuracy = 0;
			this.nP1ShotsLanded = 0;
			this.nP2ShotsLanded = 0;
			
			this.sWinner = "";
			this.updateHighScore();
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function calculateAccuracy():void
		{
			if (this.nP1ShotsFired == 0)
				this.nP1Accuracy = 0;
			else
				this.nP1Accuracy = this.nP1ShotsLanded / this.nP1ShotsFired;
				
			if (this.nP2ShotsFired == 0)
				this.nP2Accuracy = 0;
			else
				this.nP2Accuracy = this.nP2ShotsLanded / this.nP2ShotsFired;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
		public function updateHighScore():void
		{
			var so:SharedObject = SharedObject.getLocal("data");
			
			if (so.size == 0)
				so.data.highscore = 0;
				
			if (this.nP1Score > so.data.highscore)
				so.data.highscore = this.nP1Score;
			
			if (this.nP2Score > so.data.highscore)
				so.data.highscore = this.nP2Score;
				
			this.nHighScore = so.data.highscore;
		}
		
		/* ---------------------------------------------------------------------------------------- */
		
	}
}

class SingletonLock {} // Do nothing, this is just to prevent external instantiation.


