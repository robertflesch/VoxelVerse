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

package org.flashapi.swing.framework {
	
	// -----------------------------------------------------------
	// Debugger.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 01/11/2008 23:59
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>Debugger</code> interface defines the basic set of APIs that you
	 * 	must implement to create SPAS 3.0 objects for debugging your applications.
	 * 
	 * 	@see org.flashapi.swing.UIManager#debugger
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface Debugger {
		
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Displays expressions, or writes to log files, while debugging.
		 * 	A single print statement can support multiple arguments.
		 * 	If any argument in a print statement includes a data type other than a
		 * 	<code>String</code>, the print function invokes the associated 
		 * 	<code>toString()</code> method for that data type.
		 * 	For example, if the argument is a <code>Boolean</code> value the print
		 * 	function invokes <code>Boolean.toString()</code> and displays the return
		 * 	value.
		 * 
		 * 	@param	arguments	One or more (comma separated) expressions to evaluate.
		 * 	For multiple expressions, a space is inserted between each expression in
		 * 	the output
		 */
		function print(... arguments):void;
	}
}