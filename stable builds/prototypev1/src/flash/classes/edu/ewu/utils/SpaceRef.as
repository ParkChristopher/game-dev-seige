
package edu.ewu.utils
{
	import nape.space.Space;


	public class SpaceRef
	{
		protected static var	_space :Space;		// Stores the reference to the Stage.
		
		
	// **********************************************************************************

		
		/**
		 * Constructs the StageRef object. This class is a static class and should not be instantiated.
		 */
		public function SpaceRef()
		{
			throw new Error("StageRef is a static class and should not be instantiated.");

		} // END CONSTRUCTOR
		
		
	// **********************************************************************************
	
	
		/**
		 * Gets/Sets the stage reference.
		 *
		 * @param	stageRef	The static stage reference.
		 * @return				The static stage reference.
		 */
		public static function get space():Space
		{
			return _space;
		} // END FUNCTION GET stage
	
		
	// **********************************************************************************
		
	
		public static function set space(spaceRef:Space):void
		{
			_space = spaceRef;
		} // END FUNCTION SET stage
		
	}
}