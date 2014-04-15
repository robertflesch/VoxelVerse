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
	// LabelUI.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 13/08/2007 11:43
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.text.UITextFormat;
	
	/**
	 * 	The <code>LabelUI</code> interface defines the interface required to
	 * 	create <code>Label</code> look and feels.
	 * 
	 * 	@see org.flashapi.swing.Label
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface LabelUI extends LookAndFeel {
		
		/**
		 * 	Returns a reference to the <code>UITextFormat</code> used by the look and feel.
		 * 
		 * 	@return	The TextFormat used by the look and feel
		 * 
		 * 	@see org.flashapi.swing.text.UITextFormat
		 */
		function getTextFormat():UITextFormat;
		
		/**
		 * 	Returns the default height of the <code>Label</code> instance, in pixels.
		 * 
		 * 	@return	the height of the Label instance.
		 */
		function getDefaultHeight():Number;
		
		/**
		 * 	Updates the look and feel each time the <code>Label</code> instance is refreshed.
		 * 	This method is useful to implement special dynamic effects.
		 */
		function update():void;
	}
}