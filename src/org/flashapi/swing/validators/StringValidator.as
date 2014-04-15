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

package org.flashapi.swing.validators {
	
	// -----------------------------------------------------------
	// StringValidator.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 05/11/2008 19:10
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.localization.validation.string.StringLocaleUs;
	
	/**
	 * 	The <code>StringValidator</code> class validates that the length of a
	 * 	<code>String</code> is within a specified range.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class StringValidator  extends AbstractValidator {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>StringValidator</code> instance with
		 * 	the specified parameters.
		 * 
		 * 	@param	minLength	Minimum length for a valid String.
		 * 	@param	maxLength	Maximum length for a valid String.
		 */
		public function StringValidator(minLength:Number = NaN, maxLength:Number = NaN) {
			super(StringLocaleUs);
			initObj(minLength, maxLength);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//--------------------------------------------------------------------------
		
		/** 
		 *  Maximum length for a valid String.
		 *  The default value is <code>NaN</code>, which means <code>maxLength</code>
		 * 	is ignored.
		 * 
		 * 	@see #minLength
		 */
		public var maxLength:Number;
		
		/** 
		 *  Minimum length for a valid String.
		 *  The default value is <code>NaN</code>, which means <code>minLength</code>
		 * 	is ignored.
		 * 
		 * 	@see #maxLength
		 */
		public var minLength:Number;
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  @private
		 */
		override public function validate(value:String):Boolean {
			var len:int = value.length;
			_errorType = 0;
			if (!isNaN(minLength)) if (len < minLength) _errorType = 1;
			if (!isNaN(maxLength)) if (len > maxLength) _errorType = 2;
			return _errorType > 0 ? false : true;
		}
		
		/**
		 *  @private
		 */
		override public function get message():String {
			return new $composerClass().compose(
				{ errorType:_errorType, minLength:minLength, maxLength:maxLength }
			);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private var _errorType:uint = 0;
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function initObj(minLength:Number, maxLength:Number):void {
			this.minLength = minLength;
			this.maxLength = maxLength;
		}
	}
}