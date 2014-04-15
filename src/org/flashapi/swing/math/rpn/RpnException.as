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

package org.flashapi.swing.math.rpn {
	
	// -----------------------------------------------------------
	// RpnException.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version beta 1, 30/04/2008 13:42
	* @see http://www.flashapi.org/
	*/
	
	import flash.utils.Dictionary;
	import org.flashapi.swing.exceptions.IllegalArgumentException;
	
	/**
	 * 	A <code>RpnException</code> exception is thrown when a <code>RpnExp</code>
	 * 	evaluation failed. For example, an <code>RpnException</code> exception is
	 * 	thrown if a you try to calculate the following expression: "a &#47; b",
	 * 	where b is equal to zero.
	 * 
	 * 	<p>The following table lists the errors that are defined by the <code>RpnException</code> 
	 * 	class with the corresponding code value:
	 * 	<table class="innertable"> 
	 * 		<tr>
	 * 			<th>Code</th>
	 * 			<th>Message</th>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>0</code></td>
	 * 			<td>Syntax error.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>1</code></td>
	 * 			<td>Unknown character.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>2</code></td>
	 * 			<td>Division by zero.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>3</code></td>
	 * 			<td>Numeric value out of range.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>5</code></td>
	 * 			<td>Invalid number format.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>6</code></td>
	 * 			<td>An opening or closing parenthesis/brace is missing.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>8</code></td>
	 * 			<td>Symbol not allowed at the end or beginning of the expression.</td>
	 * 		</tr>
	 * 		<tr>
	 * 			<td><code>10</code></td>
	 * 			<td>Insufficient number of parameters.</td>
	 * 		</tr>
	 * 	</table></p>
	 * 
	 * 	<p>Developers can create thier own error messages by using a string as parameter
	 * 	of the <code>RpnException</code> constructor function.</p>
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class RpnException extends Error {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Constructor. Creates a new <code>RpnException</code> object with the
		 * 	specified error type.
		 * 	
		 * 	@param	error	An integer or a string associated with the error object.
		 */
		public function RpnException(error:*) {
			super("RpnException: " + getErrorMessage(error));
		}
		
		//--------------------------------------------------------------------------
		//
		// 	Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		private static var _error:Dictionary = null;
		/**
		 *  Returns a collection of errors defined by an integer value.
		 */
		public function get errors():Dictionary {
			if (_error == null) initErrors();
			return _error;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Private properties
		//
		//--------------------------------------------------------------------------
		
		private static var _initialized:Boolean = false;
		private var _defaultErrors:Array = 	[
			[0, "Syntax error."],
			[1, "Unknown character."],
			[2, "Division by zero."],
			[3, "Numeric value out of range."],
			[5,	"Invalid number format."],
			[6,	"An opening or closing parenthesis/brace is missing."],
			[8,	"Symbol not allowed at the end or beginning of the expression."],
			[10,"Insufficient number of parameters."]
		];
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		
		private function getErrorMessage(value:*):String {
			if (_error == null) initErrors();
			if (value is String) return value;
			else if (value is uint) return _error[value];
			else throw new IllegalArgumentException("The 'error' parameter must be a string or a positive integer.");
			return "";
		}
		
		private function initErrors():void {
			_error = new Dictionary();
			var i:int = _defaultErrors.length - 1;
			for (; i >= 0; i--) _error[_defaultErrors[i][0]] = _defaultErrors[i][1];
		}
	}
}