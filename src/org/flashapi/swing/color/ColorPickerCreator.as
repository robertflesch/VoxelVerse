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

package org.flashapi.swing.color {
	
	// -----------------------------------------------------------
	// ColorPickerCreator.as
	// -----------------------------------------------------------

	/**
	* @author Pascal ECHEMANN
	* @version 1.0.0, 05/01/2009 20:06
	* @see http://www.flashapi.org/
	*/
	
	import org.flashapi.swing.core.IUIObject;
	
	/**
	 *  The <code>ColorPickerCreator</code> interface must be implemented by all
	 *  <code>IUIObject</code> instances that have to communicate with
	 * 	<code>ColorPicker</code> objects.
	 * 
	 * 	@see org.flashapi.swing.color.ColorPicker
	 * 
	 * 	@langversion ActionScript 3.0
	 * 	@playerversion Flash Player 9
	 * 	@productversion SPAS 3.0 alpha
	 */
	public interface ColorPickerCreator extends IUIObject {
		
		/**
		 * 	Sets or gets the <code>ColorPicker</code> instance associated with
		 * 	this <code>ColorPickerCreator</code> object.
		 * 
		 * 	@default null
		 * 
		 * 	@see org.flashapi.swing.color.ColorPicker
		 */
		function get colorPicker():ColorPicker;
		function set colorPicker(value:ColorPicker):void;
		
		/**
		 * 	Sets or gets the current selected color value for this
		 * 	<code>ColorPickerCreator</code> object.
		 * 
		 * 	@default 0x000000
		 * 
		 * 	@see org.flashapi.swing.color.ColorPicker#selectedColor
		 */
		function get selectedColor():uint;
		function set selectedColor(value:uint):void;
	}
}