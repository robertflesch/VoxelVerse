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

package org.flashapi.swing.dnd {
	
	// -----------------------------------------------------------
	// DnDImage.as
	// -----------------------------------------------------------
	
	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 27/10/2008 23:17
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>DnDImage</code> interface defines the basic  API that must be 
	 * 	implemented by the images objects displayed during a Drag and Drop operation.
	 * 
	 * 	@see org.flashapi.swing.dnd.DnDOperation#dragImage
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface DnDImage {
		
		//--------------------------------------------------------------------------
		//
		// Getter / setter properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Sets the alpha transparency of the <code>DnDImage</code> object,
		 * 	from <code>0</code> (fully transparent) to <code>1</code> 
		 * 	(fully opaque).
		 */
		function set opacity(value:Number):void;
		
		//--------------------------------------------------------------------------
		//
		// Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Resizes the <code>DnDImage</code> object with the specified dimensions.
		 * 
		 * 	@param	width The new width of the <code>DnDImage</code> object,
		 * 			in pixels.
		 * 	@param	height The new height of the <code>DnDImage</code> object,
		 * 			in pixels.
		 */
		function resize(width:Number, height:Number):void;
		
		/**
		 * 	@copy org.flashapi.swing.core.IUIObject#finalize()
		 */
		function finalize():void;
	}
}