
package com.teamphysics.util
{
	import nape.space.Space;


	public class SpaceRef
	{
		protected static var	_space :Space;		// Stores the reference to the physics space.
		
		
	// **********************************************************************************
		
		
		/**
		 * Constructs the SpaceRef object. This class is a static class and should not be instantiated.
		 */
		public function SpaceRef()
		{
			throw new Error("SpaceRef is a static class and should not be instantiated.");
		
		} // END CONSTRUCTOR
		
		
	// **********************************************************************************
		
		
		/**
		 * Gets/Sets the space reference.
		 *
		 * @param	spaceRef 	    The static stage reference.
		 * @return					The static stage reference.
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