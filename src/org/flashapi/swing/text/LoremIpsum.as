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

package org.flashapi.swing.text {
	
	// -----------------------------------------------------------
	// LoremIpsum.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.1.0, 08/02/2011 15:15
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>LoremIpsum</code> class is a utility class that generates a filler
	 * 	text (aka placeholder text) to help developers to demonstrate the graphic
	 * 	elements of a SPAS 3.0 application, such as font, typography, and layout.
	 * 
	 * 	<p> The following text represents the lorem ipsum text used by the
	 * 	<code>LoremIpsum</code> class:<br>
	 * 	
	 * 	"<em>Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
	 * 	sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
	 * 	Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi 
	 * 	ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit 
	 * 	in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 
	 * 	Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia 
	 * 	deserunt mollit anim id est laborum.</em>"
	 * 	</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.4
	 */
	public class LoremIpsum {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>LoremIpsum</code> object.
		 */
		public function LoremIpsum() {
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the string representation of the <code>LoremIpsum</code> object.
		 * 
		 * 	@return	The entire lorem ipsum text.
		 */
		public function toString():String  {
			return LOREM_IPSUM;
		}
		
		/**
		 * 	Returns a substring consisting of the words that start at the specified
		 * 	<code>startIndex</code> and with a number of words specified by <code>wordsNum</code>.
		 * 
		 * 	@param	startIndex	An integer that specified the index of the first words
		 * 						to be used to create the substring. 
		 * 						<span class="hide">If <code>startIndex</code> is a
		 * 						negative number, the starting index is determined from
		 * 						the end of the string, where <code>-1</code> is the
		 * 						last character.</span>
		 * 	@param	wordsNum	The number of words in the substring being created.
		 * 						The default value allows to retreive the first sentence
		 * 						of the lorem ipsum text.
		 * 
		 * 	@return	A substring based on the specified parameters.
		 */
		public function substr(startIndex:int = 0, wordsNum:uint = 19):String {
			return getTextPart(startIndex, wordsNum);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static const LOREM_IPSUM:String =
			"Lorem ipsum dolor sit amet, consectetur adipisicing elit, " +
			"sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. " +
			"Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi " +
			"ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit " +
			"in voluptate velit esse cillum dolore eu fugiat nulla pariatur. " +
			"Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia " +
			"deserunt mollit anim id est laborum.";
		
		private static const CURSOR:uint = 68;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function getTextPart(startIndex:uint, wordsNum:uint):String {
			var buffer:Array = LOREM_IPSUM.split(" ");
			var i:uint = startIndex;
			var s:String = "";
			for (; i <= wordsNum-1; ++i) s += buffer[i] + " ";
			return s;
		}
	}
}