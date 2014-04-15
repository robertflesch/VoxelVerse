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

package org.flashapi.swing.plaf {
	
	// -----------------------------------------------------------
	// BorderUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 13/07/2008 16:14
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>BorderUI</code> interface defines the interface required to
	 * 	create objects that implement <code>Border</code> interface.
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface BorderUI extends LookAndFeel { 
		
		/** 
		 * 	Returns the default background color of the look and feel.
		 * 
		 * 	@return	The default background color of this look and feel.
		 */
		function getBackgroundColor():uint;
		
		/** 
		 * 	Returns the default border color of the look and feel.
		 * 
		 * 	@return	The default border color of this look and feel.
		 */
		function getBorderColor():uint;
		
		/** 
		 * 	Returns the default opacity value of the border for this look and feel.
		 * 
		 * 	@return	The default opacity value of the border for this look and feel.
		 */
		function getBorderAlpha():Number;
	}
}