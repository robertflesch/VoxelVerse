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

package org.flashapi.swing.util {
	
	// -----------------------------------------------------------
	// TextTransform.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 2.0.0, 03/12/2009 09:47
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.constants.TextTransformType;
	
	/**
	 * 	The <code>TextTransform</code> class creates convenient objects that provide
	 * 	methods and preoperties to set letter case of a string text.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class TextTransform {
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>TextTransform</code> instance with the
		 * 	specified parameters.
		 * 
		 * 	@param	text	The original text to be transformed by the <code>TextTransform</code>
		 * 					object.
		 * 	@param	type	The type of transformation to apply on the original text.
		 */
		public function TextTransform(text:String, type:String = "none") {
			super();
			initObj(text, type);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private var _type:String;
		/**
		 * 	returns the type of transformation applied on the original text.
		 * 	Possible values are constants of the <code>TextTransformType</code>
		 * 	class.
		 * 
		 * 	@default TextTransformType.NONE
		 * 
		 * 	@see #transform()
		 */
		public function get type():String {
			return _type;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Applies a letter case transformation to the original text with the specified
		 * 	transformation type.
		 * 
		 * 	@param	type	The type of transformation applied to the original text.
		 * 
		 * 	@return	A copy of the original text, after being transformed.
		 * 
		 * 	@see #type
		 */
		public function transform(type:String):String {
			transformText(type);
			return _texTransform;
		}
		
		/**
		 * 	Returns a <code>String</code> which is a copy of the original text, after
		 * 	being transformed.
		 * 
		 * 	@return	A copy of the original text, after being transformed.
		 */
		public function getTexTransform():String {
			return _texTransform;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _texTransform:String;
		private var _text:String;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(text:String, type:String):void {
			_text = text;
			transformText(type);
		}
		
		private function transformText(type:String):void {
			_type = type;
			switch(type) {
				case TextTransformType.NONE :
					_texTransform = _text;
					break;
				case TextTransformType.UPPERCASE :
					_texTransform = _text.toUpperCase();
					break;
				case TextTransformType.LOWERCASE :
					_texTransform = _text.toUpperCase();
					break;
				case TextTransformType.CAPITALIZE :
					_texTransform = _text.replace(/^.|\b./g, capitalize);
					break;
			}
		}
		
		private function capitalize():String {
			return arguments[0].toUpperCase();
		}
	}
}