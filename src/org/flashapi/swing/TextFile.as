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

package org.flashapi.swing {
	
	
	// -----------------------------------------------------------
	// TextFile.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.1, 31/12/2008 03:25
	* @see http://www.flashapi.org/
	*/
	
	import flash.events.EventDispatcher;
	
	[IconFile("TextFile.png")]
	
	/**
	 * 	<img src="TextFile.png" alt="TextFile" width="18" height="18"/>
	 * 
	 * 	The <code>TextFile</code> class creates wrapper objects used to extand the
	 * 	capabilities of the <code>String</code> class and to be recognized and
	 * 	integrated by <code>UIContainer</code> objects.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class TextFile extends EventDispatcher {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. 	Creates a new <code>TextFile</code> instance with the
		 * 					specified parameter.
		 * 
		 * 	@param	source	The string source for this <code>TextFile</code> instance.
		 */
		public function TextFile(source:String = "") { 
			super();
			initObj(source);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	An integer specifying the number of characters in this <code>TextFile</code>
		 * 	instance. 
		 */
		public function get length():int {
			return _string.length;
		}
		
		private var _string:String;
		/**
		 * 	Sets or gets the string source for this <code>TextFile</code> instance.
		 * 
		 * 	@default An empty <code>String</code>.
		 */
		public function get string():String {
			return _string;
		}
		public function set string(value:String):void {
			_string = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Returns the character in the position specified by the <code>index</code>
		 * 	parameter. If <code>index</code> is not a number from <code>0</code> to
		 * 	<code>my_text.length - 1</code>, an empty string is returned.
		 * 
		 * 	<p>This method is similar to <code>TextFile.charCodeAt()</code> except
		 * 	that the returned value is a character, not a 16-bit integer character
		 * 	code.</p>
		 * 
		 * 	@param	index	An integer specifying the position of a character in
		 * 					the text. The first character is indicated by <code>0</code>,
		 * 					and the last character is indicated by <code>my_text.length - 1</code>.
		 * 
		 * 	@return			The character at the specified index, or an empty string
		 * 					if the specified index is outside the authorized range.
		 * 
		 * 	@see #charCodeAt()
		 */
		public function charAt(index:Number = 0):String {
			return _string.charAt(index);
		}
		
		/**
		 * 	Returns the numeric Unicode character code of the character at the
		 * 	specified index. If <code>index</code> is not a number from <code>0</code>
		 * 	to <code>textfile.length - 1</code>, <code>NaN</code> is returned.
		 * 
		 * 	<p>This method is similar to <code>TextFile.charAt()</code> except
		 * 	that the returned value is a 16-bit integer character code, not the actual
		 * 	character.</p>
		 * 
		 * 	@param	index	An integer that specifies the position of a character in
		 * 					the text.
		 * 					The first character is indicated by <code>0</code>, and the
		 * 					last character is indicated by <code>my_text.length - 1</code>. 
		 * 
		 *	@return			The Unicode character code of the character at the specified
		 * 					index, 	or <code>NaN</code> if the index is outside the
		 * 					authorized range.
		 * 
		 * 	@see #charAt()
		 */
		public function charCodeAt(index:Number = 0):Number {
			return _string.charCodeAt(index);
		}
		
		/**
		 * 	Appends the supplied arguments to the end of the <code>TextFile</code> instance,
		 * 	converting them to strings if necessary, and returns the resulting string. The
		 * 	original value of the source <code>TextFile</code> instance remains unchanged. 
		 * 
		 * 	@param	... args	Zero or more values to be concatenated.
		 * 
		 * 	@return				A new <code>String</code> consisting of this text 
		 * 						concatenated with the specified parameters.  
		 */
		public function concat(... args):String {
			return _string.concat(args);
		}
		
		/**
		 * 	@private
		 */
		override public function toString():String {
			return _string;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(source:String):void {
			_string = source;
		}
	}
}