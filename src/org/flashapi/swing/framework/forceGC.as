﻿////////////////////////////////////////////////////////////////////////////////
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
	// forceGC.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 14/05/2011 21:35
	* @see http://www.flashapi.org/
	*/
	
	import flash.net.LocalConnection;
	
	//--------------------------------------------------------------------------
	//
	// 	Global function
	//
	//--------------------------------------------------------------------------
	
	/**
	 * 	Forces the garbage collector to run. Use this function only to check 
	 * 	whether objects are garbage collected or not.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha 5.8
	 */
	public function forceGC():void {
		try {
			new LocalConnection().connect('foo');
			new LocalConnection().connect('foo');
		} catch (e:*) {}
	}
}