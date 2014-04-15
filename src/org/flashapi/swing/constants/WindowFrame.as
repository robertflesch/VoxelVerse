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

package org.flashapi.swing.constants {
	
	// -----------------------------------------------------------
	// WindowFrame.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 15/10/2002 05:18
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.DeniedConstructorAccess;
	
	/**
	 * 	The <code>WindowFrame</code> class is an enumeration of constant values 
	 * 	that you can use to set the <code>request</code> parameter of the
	 * 	<code>UIManager.navigateToURL()</code> method.
	 * 
	 * 	@see org.flashapi.swing.managers.UIManager#navigateToURL()
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public class WindowFrame {
		
		//--------------------------------------------------------------------------
		//
		// Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	@private
		 * 
		 * 	Constructor.
		 * 
		 *  @throws 	org.flashapi.swing.exceptions.DeniedConstructorAccess
		 * 				A DeniedConstructorAccess if you try to create a new WindowFrame
		 * 				instance.
		 */
		public function WindowFrame() {
			super();
			new DeniedConstructorAccess(this);
		}
		
		//--------------------------------------------------------------------------
		//
		// Public constants
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 	Loads the page within the same frame as the link tag. 
		 */
		public static const SELF:String = "_self";
		
		/**
		 * 	Causes the link to open in a totally new browser window, leaving the page
		 * 	with the refering link still open behind it.
		 */
		public static const BLANK:String = "_blank";
		
		/**
		 * 	Refers to the immediate parent of a frame to load in the full body of the
		 * 	window.
		 */
		public static const PARENT:String = "_parent";
		
		/**
		 * 	Causes the new page to load in the full body of the window.
		 */
		public static const TOP:String = "_top";
	}
}