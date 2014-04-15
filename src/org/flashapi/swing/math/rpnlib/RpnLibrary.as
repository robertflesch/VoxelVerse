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

package org.flashapi.swing.math.rpnlib {
	
	// -----------------------------------------------------------
	// RpnLibrary.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 17/05/2008 13:57
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.math.RpnExp;
	
	/**
	 * 	The <code>RpnLibrary</code> interface is implemented by classes that can
	 * 	be passed as the <code>library</code> parameter for the <code>addLibrary()</code>
	 * 	method of the defined by the <code>RpnExp</code> class.
	 * 
	 * 	@see org.flashapi.swing.math.RpnExp
	 * 	@see org.flashapi.swing.math.RpnExp#addLibrary()
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface RpnLibrary {
		
		/**
		 * 	Returns the list of <code>RpnOperator</code> objects that are defined
		 * 	by this <code>RpnLibrary</code> object.
		 */
		function get operatorList():Array;
		
		/**
		 * 	Sets or gets the <code>RpnExp</code> instance associated with this
		 * 	<code>RpnLibrary</code> object.
		 */
		function get rpnInstance():RpnExp;
		function set rpnInstance(value:RpnExp):void;
		
		/**
		 * 	Returns a list of special mathematical symbols defined by this
		 * 	<code>RpnLibrary</code> object.
		 */
		function get specialSymbolList():Array;
	}
}