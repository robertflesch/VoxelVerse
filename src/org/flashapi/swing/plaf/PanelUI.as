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

package org.flashapi.swing.plaf {
	
	// -----------------------------------------------------------
	// PanelUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.2, 09/11/2010 13:29
	* @see http://www.flashapi.org/
	*/
	
	/**
	 * 	The <code>PanelUI</code> interface defines the interface required to
	 * 	create <code>Panel</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.Button
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface PanelUI extends LookAndFeel {
		
		/**
		 * 	Draws the background of the <code>Panel</code> instance.
		 * 	Each time the <code>drawPanel</code> method is called, the look and feel
		 * 	data transfer object has the following properties defined:
		 * 
		 * 	<ul>
		 * 		<li><code>currentTarget</code>: a reference to the display object where the panel is drawn,</li>
		 * 		<li><code>color</code>: a reference to the panel color,</li>
		 * 		<li><code>width</code>: the panel width,</li>
		 * 		<li><code>height</code>: the panel height,</li>
		 * 		<li><code>backgroundAlpha</code>: the current panel background alpha.</li>
		 * 	</ul>
		 */
		function drawPanel():void;
		
		/**
		 * 	Returns the default color of the look and feel.
		 * 
		 * 	@return	The default color of this look and feel.
		 */
		function getColor():uint;
	}
}