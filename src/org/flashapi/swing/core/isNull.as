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
	// isNull.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 16/01/2009 15:00
	* @see http://www.flashapi.org/
	*/
	
	//--------------------------------------------------------------------------
	//
	// 	Global function
	//
	//--------------------------------------------------------------------------
	
	/**
	 * 	A convenient function that checks an object, to know whether
	 * 	it is <code>null</code> (returns <code>true</code>), or not
	 * 	(returns <code>false</code>).
	 * 
	 * 	@param	obj	The object to check to know whether it is <code>null</code>.
	 * 
	 * 	@return	<code>true</code> if the object is <code>null</code>; 
	 * 			<code>false</code> otherwise.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public function isNull(obj:*):Boolean {
		return (obj == null);
	}
}