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

package org.flashapi.swing.core {
	
	// -----------------------------------------------------------
	// DeepThought.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 29/08/2010 09:50
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>DeepThought</code> class has been designed to give the most 
	 * 	approaching "Answer to the Ultimate Question of Life, the Universe and
	 * 	Everything". 
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class DeepThought {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates an new <code>DeepThought</code> instance.
		 */
		public function DeepThought() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	The <code>getAnswer()</code> method is the action that enables a
		 * 	<code>DeepThought</code> instance to return the "Answer to the Ultimate
		 * 	Question of Life, The Universe, and Everything".
		 * 
		 * 	@return The "Ultimate Answer to the Ultimate Question of Life, The Universe,
		 * 			and Everything"
		 */
		public function getAnswer():* {
			return DeepThought.NUMBER_FROM_WHICH_ALL_MEANING_COULD_BE_DERIVED;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	According to the Hitchhiker's Guide to the Galaxy, 42 is the number from
		 * 	which all meaning ("the meaning of life, the universe, and everything")
		 * 	could be derived. 
		 */
		private static const NUMBER_FROM_WHICH_ALL_MEANING_COULD_BE_DERIVED:Number = 42;
	}
}