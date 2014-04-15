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
	// ClosableObject.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 05/01/2008 01:52
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>ClosableObject</code> interface is implemented by <code>UIObject</code>
	 * 	that can be removed other than calling the <code>UIObject.remove()</code> method
	 * 	(e.g. <code>Window</code>, <code>Popup</code>, <code>Tooltip</code>...)
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface ClosableObject {
		
		/**
		 * 	Sets or gets the operation that executes by default when the user closes the 
		 * 	<code>ClosableObject</code> instance.
		 * 	<p>Valid values are:
		 * 		<ul>
		 * 			<li><code>ClosableProperties.DO_NOTHING_ON_CLOSE</code>,</li>
		 * 			<li><code>ClosableProperties.REMOVE_ON_CLOSE</code>,</li>
		 * 			<li><code>ClosableProperties.CALL_CLOSE_FUNCTION</code>,</li>
		 * 			<li><code>ClosableProperties.DISPOSE_ON_CLOSE</code>.</li>
		 * 		</ul>
		 * 	</p>
		 * 
		 * 	@default ClosableProperties.DISPOSE_ON_CLOSE
		 * 
		 * 	@see #onCloseFunction
		 * 	@see org.flashapi.swing.constants.ClosableProperties
		 */
		function get defaultCloseOperation():String;
		function set defaultCloseOperation(value:String):void;
		
		/**
		 * 	Specifies the function called when the <code>ClosableObject.defaultCloseOperation</code>
		 * 	property is <code>ClosableProperties.CALL_CLOSE_FUNCTION</code>.
		 * 
		 * 	@see #defaultCloseOperation
		 */
		function get onCloseFunction():Function;
		function set onCloseFunction(value:Function):void;
	}
}