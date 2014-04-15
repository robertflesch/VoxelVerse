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

package org.flashapi.vsound {
	
	// -----------------------------------------------------------
	// SequencerMode.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 29/11/2010 17:14
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>SequencerMode</code> class defines the constants for the allowed
	 * 	values of the <code>mode</code> property of a <code>VSoundSequencer</code>
	 * 	control.
	 * 
	 * 	@see org.flashapi.vsound.VSoundSequencer
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.4
	 */
	public class SequencerMode {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 	Constructor.
		 */
		public function SequencerMode() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Specifies that the succession of the sequence effects is automatically
		 * 	managed by the <code>VSoundSequencer</code> object.
		 */
		public static const AUTOMATIC:String = "automatic";
		
		/**
		 * 	Specifies that the succession of the sequence effects needs a Uuser Interface
		 * 	input action to be performed.
		 */
		public static const MANUAL:String = "manual";
	}
}