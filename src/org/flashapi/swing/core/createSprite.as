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
	// createSprite.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 27/01/2010 13:51
	* @see http://www.flashapi.org/
	*/
	
	import flash.display.Sprite;
	
	//--------------------------------------------------------------------------
	//
	// 	Global function
	//
	//--------------------------------------------------------------------------
	
	/**
	 * 	<strong>FOR DEVELOPERS ONLY.</strong>
	 * 	(Not implemented yet.)
	 * 
	 * 	Creates and returns a new <code>Sprite</code> object with the 
	 * 	<code>focusRect</code> property set to <code>false</code>.
	 * 
	 * 	<p>TODO: all <code>Sprite</code> objects within the SPAS 3.0 internal API
	 * 	should be created using this method.</p>
	 * 
	 * 	@return	A new <code>Sprite</code> object.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public function createSprite():Sprite {
		var obj:Sprite = new Sprite();
		obj.focusRect = false;
		return obj;
	}
}