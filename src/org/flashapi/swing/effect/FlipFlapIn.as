////////////////////////////////////////////////////////////////////////////////
//    
//    Swing Package for Actionscript 3.0 (SPAS 3.0)
//    Copyright (C) 2004-2011 BANANA TREE DESIGN & Pascal ECHEMANN.
//    
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//    
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//    GNU General Public License for more details.
//    
//    You should have received a copy of the GNU General Public License
//    along with this program. If not, see <http://www.gnu.org/licenses/>.
//    
////////////////////////////////////////////////////////////////////////////////
	
package org.flashapi.swing.effect {
	
	// -----------------------------------------------------------
	// FlipFlapIn.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 25/01/2009 20:41
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.Quality;
	import org.flashapi.swing.effect.core.FlipFlapEffects;
	
	/**
	 * 	The <code>FlipFlapIn</code> class creates a flipping effect from the stage to
	 * 	the user place.
	 * 
	 * 	@see org.flashapi.swing.effect.FlipFlapOut
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class FlipFlapIn extends FlipFlapEffects implements Effect {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates e new <code>FlipFlapIn</code> effect with 
		 * 	the specified parameters.
		 * 
		 * 	@param	target		The target container for this effect.
		 * 	@param	duration	The effect duration, in milliseconds.
		 */
		public function FlipFlapIn(target:Object, duration:uint = 600) {
			super(target, duration, FlipFlapIn);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	A <code>Quality</code> class constant that defines the quality of the effect.
		 */
		public static var quality:String = Quality.LOW;
		
		//--------------------------------------------------------------------------
		//
		// Protected methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 */
		override protected function initialize():void {
			$start = .4;
			$end = 1;
		}
	}
}